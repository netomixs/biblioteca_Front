import 'package:biblioteca_temporal/controllers/LibroController.dart';
import 'package:biblioteca_temporal/views/editar_libro.dart';
import 'package:biblioteca_temporal/widgets/eleemnto_libro.dart';
import 'package:biblioteca_temporal/widgets/input_Text.dart';
import 'package:biblioteca_temporal/widgets/input_text_on_tap.dart';
import 'package:biblioteca_temporal/widgets/principal_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NuevoPrestamo extends StatefulWidget {
  final int IdLibro;
  const NuevoPrestamo({super.key, required this.IdLibro});

  @override
  State<NuevoPrestamo> createState() => _NuevoPrestamoState();
}

class _NuevoPrestamoState extends State<NuevoPrestamo> {
  TextEditingController editText_IdLEctor = TextEditingController();
  TextEditingController editText_fecha = TextEditingController();
  DateTime pickedDate = DateTime.now();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  List<dynamic>? libros = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Prestamo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                InputText(
                  hintText: "Id del lector",
                  label: "Id",
                  controller: editText_IdLEctor,
                  keyboardType: TextInputType.number,
                  icon: Icons.abc,
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "Este campo no puede ir vacio";
                    }
                    try {
                      int.parse(p0);
                    } catch (e) {
                      return "Ingresa un numerico";
                    }
                    return null;
                  },
                ),
                InputTextOnTap(
                  hintText: "Fecha limite",
                  controller: editText_fecha,
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "Este campo no puede ir vacio";
                    }
                  },
                  onTap: () async {
                    try {
                      pickedDate = (await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(), //get today's date
                          firstDate: DateTime(
                              2000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101)))!;
                    } catch (e) {}
                    String formattedDate = DateFormat('yyyy-MM-dd').format(
                        pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                    // ignore: unnecessary_null_comparison
                    if (pickedDate != null) {
                      setState(() {
                        editText_fecha.text = formattedDate;
                      });
                    } else {}
                  },
                ),
                PrincipalButton(
                    isload: false,
                    text: "Ejecutar",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {}
                    }),
              ],
            ),
          ),
          SingleChildScrollView(
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
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NuevoPrestamo(
                                        IdLibro: libros![index]["Id"])),
                              );
                            },
                            onPressedDelete: (p0) async {
                              await LibroController.eliminar(
                                      libros![index]["Id"])
                                  .then((value) {
                                print(value);
                                if (value["Code"] == 200 &&
                                    value["IsSuccess"]) {
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
          )
        ]),
      ),
    );
  }
}
