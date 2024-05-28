import 'dart:ui';

import 'package:biblioteca_temporal/controllers/LectorConroller.dart';
import 'package:biblioteca_temporal/controllers/LibroController.dart';
import 'package:biblioteca_temporal/controllers/PersonaController.dart';
import 'package:biblioteca_temporal/widgets/alert_windows.dart';
import 'package:biblioteca_temporal/widgets/drop_down_sexo.dart';
import 'package:biblioteca_temporal/widgets/input_Text.dart';
import 'package:biblioteca_temporal/widgets/input_text_on_tap.dart';
import 'package:biblioteca_temporal/widgets/principal_button.dart';
import 'package:biblioteca_temporal/widgets/secundary_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LectorEditor_Screen extends StatefulWidget {
  const LectorEditor_Screen({super.key});

  @override
  State<LectorEditor_Screen> createState() => _LectorEditor_ScreenState();
}

class _LectorEditor_ScreenState extends State<LectorEditor_Screen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController editText_Nombre = TextEditingController();
  TextEditingController editText_Id = TextEditingController();
  TextEditingController editText_Apellido_P = TextEditingController();
  TextEditingController editText_Apellido_M = TextEditingController();
  TextEditingController editText_Sexo = TextEditingController();
  TextEditingController editText_UDI = TextEditingController();
  final TextEditingController editText_Nacimiento = TextEditingController();
  DateTime pickedDate = DateTime(2017, 9, 7, 17, 30);
  bool isLoad = false;
  bool isSearch = false;
  int idPersona=0;
  @override
  Widget build(BuildContext context) {
    editText_Sexo.text = "M";
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: InputText(
                            hintText: "Id del lector",
                            controller: editText_Id,
                            icon: Icons.person,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(200, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              isSearch = true;
                            });
                            if (editText_Id.text != null ||
                                editText_Id.text.isNotEmpty) {
                              try {
                                await LectorController.getLector(
                                        int.parse(editText_Id.text))
                                    .then((value) {
                                  setState(() {
                                    isSearch = false;
                                  });
                                  print(value);
                                  var lector = value["Data"];
                                  editText_UDI.text = lector["UDI"];
                                  editText_Nombre.text = lector["persona"]["Nombre"];
                                  editText_Apellido_P.text = lector["persona"]["Apellido_P"];
                                  editText_Apellido_M.text  = lector["persona"]["Apellido_M"];
                                  editText_Nacimiento.text  = lector["persona"]["Nacimiento"];
                                  idPersona=  lector["persona"]["Id"];
                                });
                              } catch (e) {
                                print(e);
                                setState(() {
                                  isSearch = false;
                                });
                                AlertWindow.showSimpleDialog(context,
                                    "Ocurrio un error", "Registro completo");
                              }
                            } else {}
                          },
                          child: Text("Buscar"),
                        ),
                      ],
                    ),
                    InputText(
                      hintText: "Nombre",
                      label: "Nombre",
                      controller: editText_Nombre,
                      icon: Icons.abc,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return "Este campo no puede ir vacio";
                        }

                        return null;
                      },
                    ),
                    InputText(
                      hintText: "Apellido paterno",
                      controller: editText_Apellido_P,
                      icon: Icons.abc,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return "Este campo no puede ir vacio";
                        }

                        return null;
                      },
                    ),
                    InputText(
                      hintText: "Apellido materno",
                      controller: editText_Apellido_M,
                      icon: Icons.abc,
                      validator: (p0) {
                        return null;
                      },
                    ),
                    InputTextOnTap(
                      hintText: "Fecha de nacimiento",
                      controller: editText_Nacimiento,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return "Este campo no puede ir vacio";
                        }
                        return null;
                      },
                      onTap: () async {
                        try {
                          pickedDate = (await showDatePicker(
                              context: context,
                              initialDate: pickedDate, //get today's date
                              firstDate: DateTime(
                                  1900), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2201)))!;
                        } catch (e) {}
                        String formattedDate = DateFormat('yyyy-MM-dd').format(
                            pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                        // ignore: unnecessary_null_comparison
                        if (pickedDate != null) {
                          setState(() {
                            editText_Nacimiento.text = formattedDate;
                          });
                        } else {}
                      },
                    ),
                    SexoDropdown(
                      hintText: 'Sexo',
                      identificadorInicial: editText_Sexo.text,
                      onSeleccion: (sexo) {
                        editText_Sexo.text = sexo;
                      },
                      opciones: const [
                        {"Identificador": "M", "Nombre": "Masculino"},
                        {"Identificador": "F", "Nombre": "Femenino"},
                        {"Identificador": "O", "Nombre": "39 tipos de gays"},
                      ],
                    ),
                    InputText(
                      hintText: "UDI",
                      maxLength: 18,
                      controller: editText_UDI,
                      icon: Icons.abc,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return "Este campo no puede ir vacio";
                        }
                        if (p0.length != 18) {
                          return "Este campo deberia tener 18 caracteres";
                        }
                        return null;
                      },
                    ),
                    PrincipalButton(
                        isload: isLoad,
                        text: "Agregar",
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoad = true;
                            });
                            try {
                              await PersonaController.insert(
                                      editText_Nombre.text,
                                      editText_Apellido_P.text,
                                      editText_Apellido_M.text,
                                      editText_Nacimiento.text,
                                      editText_Sexo.text)
                                  .then((value) {
                                if (value["Code"] == 201) {
                                  LectorController.insert(
                                          editText_UDI.text, value["Data"])
                                      .then((valor) async {
                                    setState(() {
                                      isLoad = false;
                                    });
                                    if (valor["Code"] == 201) {
                                      try {
                                        editText_Id.text =
                                            valor["Data"].toString();
                                      } catch (e) {
                                        print(e);
                                      }

                                      AlertWindow.showSimpleDialog(context,
                                          "Exito", "Registro completo");
                                    } else {
                                      await PersonaController.eliminar(
                                              value["Data"])
                                          .then((value) {});
                                      AlertWindow.showSimpleDialog(
                                          context, "Error", "Ocurrio un error");
                                    }
                                  }).onError((error, stackTrace) async {
                                    await PersonaController.eliminar(
                                            value["Data"])
                                        .then((value) {});
                                    AlertWindow.showSimpleDialog(
                                        context, "Error", "Ocurrio un error");
                                    setState(() {
                                      isLoad = false;
                                    });
                                  });
                                }
                                print(value);
                              });
                            } catch (e) {
                              AlertWindow.showSimpleDialog(
                                  context, "Error", "Ocurrio un error");
                            }
                            /*try {
                          await LibroController.insert(
                                  editText_Titulo.text,
                                  editText_ISBN.text,
                                  editText_URL.text,
                                  editText_Descripcion.text,
                                  editText_Publicacion.text,
                                  int.parse(editText_Existncias.text),
                                  IdEditorial,
                                  editText_Codigo.text,
                                  IdGenero,
                                  IdAutor)
                              .then((value) {
                            print(value);
                            if (value["Code"] == 201) {
                              AlertWindow.showSimpleDialog(
                                  context, "Exito", "Registro completo");
                            } else {
                              AlertWindow.showSimpleDialog(
                                  context, "Error", "Ocurrio un error");
                            }
                            setState(() {
                              isLoad = false;
                            });
                          });
                        } catch (e) {
                          print(e);
                        } */
                          }
                        }),
                  ],
                ))));
  }
}
