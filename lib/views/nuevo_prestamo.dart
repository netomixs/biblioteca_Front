import 'package:biblioteca_temporal/controllers/LibroController.dart';
import 'package:biblioteca_temporal/controllers/PrestamoController.dart';
import 'package:biblioteca_temporal/views/editar_libro.dart';
import 'package:biblioteca_temporal/widgets/alert_windows.dart';
import 'package:biblioteca_temporal/widgets/eleemnto_libro.dart';
import 'package:biblioteca_temporal/widgets/elemento_prestamo.dart';
import 'package:biblioteca_temporal/widgets/input_Text.dart';
import 'package:biblioteca_temporal/widgets/input_text_on_tap.dart';
import 'package:biblioteca_temporal/widgets/principal_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                      if (_formKey.currentState!.validate()) {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        String? id = prefs.getString('id');
                        print(id);
                        await PrestamoController.insert(
                                editText_fecha.text,
                                "${widget.IdLibro}",
                                id!,
                                editText_IdLEctor.text)
                            .then((value) async {
                          print(value);
                          if (value["Code"] == 201) {
                            await AlertWindow.showSimpleDialog(context, "Exito",
                                "Registro completo\nSu id de prestamo es: ${value["Data"]}");
                            setState(() {});
                          }
                        });
                      }
                    }),
              ],
            ),
          ),
          Expanded(
              child: RefreshIndicator(
            onRefresh: (() {
              return LibroController.getPrestamoLibro(widget.IdLibro);
            }),
            child: FutureBuilder(
                future: LibroController.getPrestamoLibro(widget.IdLibro),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No images found'));
                  } else {
                    var respuesta = snapshot.data!["Data"] as dynamic;

                    libros = respuesta["prestamo"] as List<dynamic>;
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
                                  setState(() {
                            
                                  });
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
          ))
        ]),
      ),
    );
  }
}
