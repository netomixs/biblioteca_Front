import 'package:biblioteca_temporal/controllers/LibroController.dart';
 
import 'package:biblioteca_temporal/views/editar_libro.dart';
import 'package:biblioteca_temporal/views/nuevo_libro_screen.dart';
import 'package:biblioteca_temporal/views/nuevo_prestamo.dart';
import 'package:biblioteca_temporal/widgets/eleemnto_libro.dart';
import 'package:flutter/material.dart';

class LibrosListScreen extends StatefulWidget {
 
  const LibrosListScreen({super.key });

  @override
  State<LibrosListScreen> createState() => _LibrosListScreenState();
}

List<dynamic>? libros = [];

class _LibrosListScreenState extends State<LibrosListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          heroTag: "Nuevo Libro",
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NuevoLibroScreen(),
              ),
            );
          },
          tooltip: 'Agregar libro',
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: RefreshIndicator(
            onRefresh: (() {
              return LibroController.getLibros();
            }),
            child: FutureBuilder(
                future: LibroController.getLibros(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No images found'));
                  } else {
                    var respuesta = snapshot.data!["Data"] as List<dynamic>;

                    libros = respuesta;
                    libros?.forEach(
                      (element) {
                        print(element["Imagen"]);
                        ;
                      },
                    );
                    return ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(10),
                        itemCount: libros!.length,
                        itemBuilder: (BuildContext context, index) {
                          print(
                              libros![index]["autor"][0]["persona"]["Nombre"]);
                          return ElementLibro(
                            onPressedEdit: (p0) async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditarLibroScreen(
                                        IdLibro: libros![index]["Id"])),
                              );
                            },
                            onPressed: () async {
                              print(libros![index]);
                                await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NuevoPrestamo(
                                        IdLibro: libros![index]["Id"])),
                              );
                            },
                            onPressedDelete: (p0) async {
                             await LibroController.eliminar(libros![index]["Id"]).then((value){
                              
                              print(value);
                              if(value["Code"]==200 && value["IsSuccess"]){
                                  setState(() {
                                    try {
                                       libros!.removeAt(index);
                                    } catch (e) {
                                      print(e);
                                    }
                                   
                                  });
                              }

                             });
                            },
                            libro: libros![index],
                            index: index,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                              height: 8,
                            ));
                  }
                }),
          ),
        ));
  }
}
