import 'package:biblioteca_temporal/views/Menu.dart';
import 'package:biblioteca_temporal/views/login_screen.dart';
import 'package:biblioteca_temporal/views/nuevo_libro_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biblioteca',
      theme: ThemeData(),
      home: const MyHomePage(title: 'Biblioteca'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    // Revisa si hay una clave 'id' almacenada localmente
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('id');
    // Redirige a la pantalla adecuada según si existe la clave 'id' o no
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) =>
            id != null ? Menu(usuario: {"Id": int.parse(id)}) : LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Puedes mostrar un indicador de carga mientras se realiza la verificación
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
