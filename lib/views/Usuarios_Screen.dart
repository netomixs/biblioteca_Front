import 'dart:ui';

import 'package:biblioteca_temporal/controllers/LectorConroller.dart';
import 'package:biblioteca_temporal/controllers/LibroController.dart';
import 'package:biblioteca_temporal/controllers/PersonaController.dart';
import 'package:biblioteca_temporal/controllers/UsuarioController.dart';
import 'package:biblioteca_temporal/widgets/alert_windows.dart';
import 'package:biblioteca_temporal/widgets/drop_down_sexo.dart';
import 'package:biblioteca_temporal/widgets/input_Text.dart';
import 'package:biblioteca_temporal/widgets/input_text_on_tap.dart';
import 'package:biblioteca_temporal/widgets/principal_button.dart';
import 'package:biblioteca_temporal/widgets/secundary_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Usuario_Screen extends StatefulWidget {
  const Usuario_Screen({super.key});

  @override
  State<Usuario_Screen> createState() => _Usuario_Screen_ScreenState();
}

class _Usuario_Screen_ScreenState extends State<Usuario_Screen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController editText_Nombre = TextEditingController();
  TextEditingController editText_Id = TextEditingController();
  TextEditingController editText_Apellido_P = TextEditingController();
  TextEditingController editText_Apellido_M = TextEditingController();
  TextEditingController editText_Sexo = TextEditingController();
  TextEditingController editText_ClaveEmpleado = TextEditingController();
  TextEditingController editText_Password = TextEditingController();
  TextEditingController editText_Password2 = TextEditingController();
  TextEditingController editText_Usuario = TextEditingController();
  final TextEditingController editText_Nacimiento = TextEditingController();
  DateTime pickedDate = DateTime(2017, 9, 7, 17, 30);
  bool isLoad = false;
  bool isSearch = false;
  int idPersona = 0;
  int idNivel = 1;
  @override
  Widget build(BuildContext context) {
    editText_Sexo.text = "M";
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SexoDropdown(
                        hintText: 'Nivel',
                        identificadorInicial: "${idNivel}",
                        onSeleccion: (id) {
                          idNivel = int.parse(id);
                        },
                        opciones: const [
                          {"Identificador": "1", "Nombre": "Administrador"},
                          {"Identificador": "2", "Nombre": "Empleado"},
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
                        hintText: "Clave empelado",
                        maxLength: 10,
                        controller: editText_ClaveEmpleado,
                        icon: Icons.abc,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "Este campo no puede ir vacio";
                          }
                          if (p0.length != 10) {
                            return "Este campo deberia tener 10 caracteres";
                          }
                          return null;
                        },
                      ),
                      InputText(
                        hintText: "Usuario",
                        controller: editText_Usuario,
                        icon: Icons.abc,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "Este campo no puede ir vacio";
                          }

                          return null;
                        },
                      ),
                      InputText(
                        hintText: "Contraseña",
                        controller: editText_Password,
                        icon: Icons.abc,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "Este campo no puede ir vacio";
                          }

                          return null;
                        },
                      ),
                      InputText(
                        hintText: "Repita contraseña",
                        controller: editText_Password2,
                        icon: Icons.abc,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "Este campo no puede ir vacio";
                          }
                          if (p0 == (editText_Password.text)) {
                            return null;
                          } else {
                            return "Las contraseños deben de ser iguales";
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
                                PersonaController.insert(
                                        editText_Nombre.text,
                                        editText_Apellido_P.text,
                                        editText_Apellido_M.text,
                                        editText_Nacimiento.text,
                                        editText_Sexo.text)
                                    .then(
                                  (value) {
                                    print(value);
                                    var id = value["Data"];
                                    UsuarioController.insert(
                                            editText_Usuario.text,
                                            editText_Password.text,
                                            editText_ClaveEmpleado.text,
                                            id,
                                            idNivel)
                                        .then((response) {
                                      if (response["Code"] == 201) {
                                        AlertWindow.showSimpleDialog(context,
                                            "Exito", "Registro correcto");
                                      }else{
                                             AlertWindow.showSimpleDialog(context,
                                            "Error", "Ocurrio un error");
                                      }
                                    });
                                  },
                                );
                              } catch (e) {
                                AlertWindow.showSimpleDialog(
                                    context, "Error", "Ocurrio un error");
                              }

                              setState(() {
                                isLoad = false;
                              });
                            }
                          })
                    ],
                  ),
                ))));
  }
}
