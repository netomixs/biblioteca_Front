import 'package:biblioteca_temporal/views/Editar_Perfil.dart';
import 'package:biblioteca_temporal/views/LectorEditor_Screen.dart';
import 'package:biblioteca_temporal/views/Libros_list_screen.dart';
import 'package:biblioteca_temporal/views/Usuarios_Screen.dart';
import 'package:biblioteca_temporal/views/login_screen.dart';
import 'package:biblioteca_temporal/views/nuevo_libro_screen.dart';
import 'package:biblioteca_temporal/views/prestamos_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends StatefulWidget {
  final Map usuario;
  const Menu({super.key, required this.usuario});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  String currelyText = "Libros";
  bool showFab = true;
  Widget scrennCuncurry = const LibrosListScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(currelyText),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.update))
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.book),
                title: const Text("Libros"),
                onTap: () {
                  if (currelyText != "Libros") {
                    setState(() {
                      showFab = true;
                      currelyText = "Libros";
                      scrennCuncurry = LibrosListScreen();
                    });

                    Navigator.pop(context);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.people),
                title: const Text("Lectores"),
                onTap: () {
                  if (currelyText != "Lectores") {
                    setState(() {
                      showFab = false;
                      currelyText = "Lectores";
                      scrennCuncurry = const LectorEditor_Screen();
                    });

                    Navigator.pop(context);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.add_box),
                title: const Text("Prestamos"),
                onTap: () {
                  if (currelyText != "Prestamos") {
                    setState(() {
                      showFab = false;
                      currelyText = "Prestamos";
                      scrennCuncurry = const PrestamosScreen();
                    });

                    Navigator.pop(context);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Usuarios"),
                onTap: () {
                  if (currelyText != "Usuarios") {
                    setState(() {
                      showFab = false;
                      currelyText = "Usuarios";
                      scrennCuncurry = const Usuario_Screen();
                    });

                    Navigator.pop(context);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.person_4_rounded),
                title: const Text("Perfil"),
                onTap: () {
                  if (currelyText != "Perfil") {
                    var id = widget.usuario["Id"];
                    if (id != null) {
                      setState(() {
                        showFab = false;
                        currelyText = "Perfil";
                        print(widget.usuario);
                        scrennCuncurry = EditarPerfil(
                          idUsuario: id,
                        );
                      });
                    }
                    Navigator.pop(context);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text("Cerrar sesión"),
                onTap: () async {
                  if (currelyText != "Cerrar sesión") {
                    currelyText = "Cerrar sesión";
                    //LoginController.logOut(context);
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.remove('id');
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) =>
                            LoginScreen(), // Redirige a la pantalla de inicio de sesión
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
        body: scrennCuncurry);
  }

  Future<void> _actualizarScrenn() async {
    setState(() {
      Key experimentoListKey = UniqueKey();
      scrennCuncurry = const Column();
      showFab = true;
      currelyText = "Libros";
      scrennCuncurry = LibrosListScreen(key: experimentoListKey);
    });
  }
}
