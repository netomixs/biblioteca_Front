import 'package:biblioteca_temporal/controllers/LibroController.dart';
import 'package:biblioteca_temporal/controllers/PrestamoController.dart';
import 'package:biblioteca_temporal/widgets/elemento_prestamo.dart';
import 'package:flutter/material.dart';

class PrestamosScreen extends StatefulWidget {
  const PrestamosScreen({super.key});

  @override
  State<PrestamosScreen> createState() => _PrestamosScreenState();
}

class _PrestamosScreenState extends State<PrestamosScreen> {
    List<dynamic>? libros = [];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Padding(
            padding: EdgeInsets.all(16),
            child: Expanded(
                child: RefreshIndicator(
              onRefresh: (() {
                return PrestamoController.getPrestamos();
              }),
              child: FutureBuilder(
                  future: PrestamoController.getPrestamos(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No images found'));
                    } else {
                      var respuesta = snapshot.data!["Data"] as dynamic;

                      libros = respuesta as List<dynamic>;
                      print(libros);
                      return ListView.separated(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(10),
                          itemCount: libros!.length,
                          itemBuilder: (BuildContext context, index) {
                            return ElementoPrestamo(
                              index: index,
                              Fecha_Entrega: libros![index]["Fecha_Entrega"],
                              Fecha_Limite: libros![index]["Fecha_FIn"],
                              Fecha_Prestamo: libros![index]["Fecha_Inicio"],
                              id_Admin: "${libros![index]["Id_Administrador"]}",
                              id_Lector: "${libros![index]["Id_Lector"]}",
                              id_prestamo: "${libros![index]["Id"]}",
                              onPressedDelete: (p0) async {
                                await PrestamoController.eliminar(
                                        libros![index]["Id"])
                                    .then((value) {
                                  print(value);
                                  if (value["Code"] == 200) {
                                    setState(() {
                                      libros!.removeAt(index);
                                    });
                                  }
                                });
                              },
                              onPressedEdit: (p0) async {
                                await PrestamoController.update(
                                        libros![index]["Id"],
                                        libros![index]["Fecha_FIn"],
                                        DateTime.now().toIso8601String())
                                    .then((value) {
                                  if (value["Code"] == 201) {
                                    setState(() {});
                                  }
                                });
                              },
                              onPressed: () {},
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(
                                height: 8,
                              ));
                    }
                  }),
            ))));
  }
}
