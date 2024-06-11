import 'dart:ui';

import 'package:biblioteca_temporal/controllers/LectorConroller.dart';
import 'package:biblioteca_temporal/controllers/LibroController.dart';
import 'package:biblioteca_temporal/controllers/PersonaController.dart';
import 'package:biblioteca_temporal/controllers/UsuarioController.dart';
 
import 'package:biblioteca_temporal/widgets/alert_windows.dart';
import 'package:biblioteca_temporal/widgets/drop_down.dart';
import 'package:biblioteca_temporal/widgets/drop_down_sexo.dart';
import 'package:biblioteca_temporal/widgets/input_Text.dart';
import 'package:biblioteca_temporal/widgets/input_text_on_tap.dart';
import 'package:biblioteca_temporal/widgets/principal_button.dart';
import 'package:biblioteca_temporal/widgets/secundary_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditarPerfil extends StatefulWidget {
  final int idUsuario;
  const EditarPerfil({super.key, required this.idUsuario});

  @override
  State<EditarPerfil> createState() => _EditarPerfil_ScreenState();
}

class _EditarPerfil_ScreenState extends State<EditarPerfil> {
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
  var usuario = Map();
  var persona = Map();
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                    child: FutureBuilder(
                  future: UsuarioController.getUsuario(widget.idUsuario),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      try {
                        var usuario = snapshot.data?["Data"] as dynamic;
                        print(usuario);
                        PersonaController.getPersona(usuario["Id_Persona"])
                            .then((value) {
                          persona = value["Data"];
                          editText_Nombre.text = persona["Nombre"];
                          editText_Apellido_P.text = persona["Apellido_P"];
                          editText_Apellido_M.text = persona["Apellido_M"];
                          editText_Nacimiento.text = persona["Nacimiento"];
                          editText_Sexo.text = "F";
                          editText_Usuario.text = usuario["Usuario"];
                          editText_ClaveEmpleado.text =
                              usuario["Clave_Empleado"];
                          print(persona);
                        });
                      } catch (e) {
                        print(e);
                      }

                      return Column(children: [
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
                          identificadorInicial: persona["Sexo"] ?? "M",
                          onSeleccion: (sexo) {
                            editText_Sexo.text = sexo;
                          },
                          opciones: const [
                            {"Identificador": "M", "Nombre": "Masculino"},
                            {"Identificador": "F", "Nombre": "Femenino"},
                            {
                              "Identificador": "O",
                              "Nombre": "39 tipos de gays"
                            },
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
                        PrincipalButton(
                            isload: isLoad,
                            text: "Actualizar",
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isLoad = true;
                                });
                                try {
                                  PersonaController.actualizar(
                                          snapshot.data?["Data"]["Id_Persona"],
                                          editText_Nombre.text,
                                          editText_Apellido_P.text,
                                          editText_Apellido_M.text,
                                          editText_Nacimiento.text,
                                          editText_Sexo.text)
                                      .then(
                                    (value) {
                                      print(value);
                                      var id = value["Data"];
                                      UsuarioController.actualizar(
                                              snapshot.data?["Data"]["Id"],
                                              editText_Usuario.text,
                                              editText_ClaveEmpleado.text,
                                              idNivel)
                                          .then((response) async {
                                        print(response);
                                        if (response["Code"] == 201) {
                                          await AlertWindow.showSimpleDialog(
                                              context,
                                              "Exito",
                                              "Actulizacion correcto");
                                              setState(() {
                                                
                                              });
                                        } else {
                                          AlertWindow.showSimpleDialog(context,
                                              "Error", "Ocurrio un error");
                                        }
                                      });
                                    },
                                  );
                                } catch (e) {
                                  AlertWindow.showSimpleDialog(
                                      context, "Error", "Ocurrio un error: $e");
                                }

                                setState(() {
                                  isLoad = false;
                                });
                              }
                            })
                      ]);
                    }
                  },
                )))));
  }
}
