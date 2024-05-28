import 'package:biblioteca_temporal/controllers/AutorController.dart';
import 'package:biblioteca_temporal/controllers/EditorialesController.dart';
import 'package:biblioteca_temporal/controllers/GeneroController.dart';
import 'package:biblioteca_temporal/controllers/LibroController.dart';
import 'package:biblioteca_temporal/widgets/alert_windows.dart';
import 'package:biblioteca_temporal/widgets/drop_down.dart';
import 'package:biblioteca_temporal/widgets/drop_down_autores.dart';
import 'package:biblioteca_temporal/widgets/input_Text.dart';
import 'package:biblioteca_temporal/widgets/input_number.dart';
import 'package:biblioteca_temporal/widgets/input_text_on_tap.dart';
import 'package:biblioteca_temporal/widgets/principal_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NuevoLibroScreen extends StatefulWidget {
  const NuevoLibroScreen({super.key});

  @override
  State<NuevoLibroScreen> createState() => _NuevoLibroScreenState();
}

class _NuevoLibroScreenState extends State<NuevoLibroScreen> {
  TextEditingController editText_Titulo = TextEditingController();
  TextEditingController editText_Descripcion = TextEditingController();
  TextEditingController editText_ISBN = TextEditingController();
  final TextEditingController editText_Publicacion = TextEditingController();
  final TextEditingController editText_Adquicicion = TextEditingController();
  TextEditingController editText_Existncias = TextEditingController();
  TextEditingController editText_Codigo = TextEditingController();
  TextEditingController editText_URL = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime pickedDate = DateTime.now();
  int IdEditorial = 0;
  int IdGenero = 0;
  int IdAutor = 0;
  bool isLoad = false;
  @override
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Libro'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                InputText(
                  hintText: "Titulo",
                  label: "Titulo",
                  controller: editText_Titulo,
                  icon: Icons.abc,
                  validator: (p0) => validacionVacia(p0),
                ),
                InputText(
                  hintText: "Url imagen",
                  label: "Imagen",
                  controller: editText_URL,
                  keyboardType: TextInputType.url,
                  icon: Icons.abc,
                  validator: (p0) => validacionVacia(p0),
                ),
                InputText(
                  hintText: "ISBN",
                  label: "ISBN",
                  maxLength: 13,
                  controller: editText_ISBN,
                  icon: Icons.abc,
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "Este campo no puede ir vacio";
                    }
                    if (p0.length != 13) {
                      return "Este campo debe de tener 13 caarcteres";
                    }
                    return null;
                  },
                ),
                InputText(
                  hintText: "Descripcion",
                  label: "Descripcion",
                  controller: editText_Descripcion,
                  icon: Icons.abc,
                  validator: (p0) => validacionVacia(p0),
                ),
                //Calendarion
                InputTextOnTap(
                  hintText: "Fecha de publicacion",
                  controller: editText_Publicacion,
                  validator: (p0) => validacionVacia(p0),
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
                        editText_Publicacion.text = formattedDate;
                      });
                    } else {}
                  },
                ),
                //Input de existencia
                InputText(
                  hintText: "Existencias",
                  controller: editText_Existncias,
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "Este campo no puede ir vacio";
                    }
                    try {
                      int a = int.parse(p0);
                      return null;
                    } catch (e) {
                      return "Ingresa un valor numerico";
                    }
                  },
                ),
                //Lista deplegable de editoriales
                FutureBuilder(
                  future: EditorialController.getEditoriales(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      var editoriales = snapshot.data!["Data"] as List<dynamic>;
                      IdEditorial = editoriales[0]["Id"];
                      return CustomDropdown(
                        onSeleccion: (int) {
                          IdEditorial = editoriales[int]["Id"];
                          print(IdEditorial);
                        },
                        opciones: editoriales,
                        hintText: 'Editorial',
                      );
                    }
                  },
                ),
                InputText(
                  hintText: "Codigo de rastreo",
                  controller: editText_Codigo,
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "Este campo no puede ir vacio";
                    }

                    return null;
                  },
                ),
                //Lista deplegable de Genero
                FutureBuilder(
                  future: GeneroController.getGeneros(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      var generos = snapshot.data!["Data"] as List<dynamic>;
                      IdGenero = generos[0]["Id"];
                      return CustomDropdown(
                        onSeleccion: (int) {
                          IdGenero = generos[int]["Id"];
                          print(IdGenero);
                        },
                        opciones: generos,
                        hintText: 'Genero del libro',
                      );
                    }
                  },
                ),
                //Lista deplegable de Genero
                FutureBuilder(
                  future: AutorController.getAutores(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      var autores = snapshot.data!["Data"] as List<dynamic>;
                      print(autores[0]["persona"]["Nombre"]);
                      IdAutor = autores[0]["Id"];
                      return CustomDropdownAutor(
                        onSeleccion: (int) {
                          IdAutor = autores[int]["Id"];
                          print(IdAutor);
                        },
                        opciones: autores,
                        hintText: 'Autor',
                      );
                    }
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
                        }
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static validacionVacia(String? valor) {
    if (valor!.isEmpty) {
      return "Este campo no puede ir vacio";
    }
    return null;
  }
}
