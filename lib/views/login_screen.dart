import 'package:biblioteca_temporal/controllers/LoginController.dart';
import 'package:biblioteca_temporal/views/Menu.dart';
import 'package:biblioteca_temporal/widgets/alert_windows.dart';
import 'package:biblioteca_temporal/widgets/input_password.dart';
import 'package:biblioteca_temporal/widgets/principal_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/input_Text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoad = false;
  late FocusNode _focusNode1;
  late FocusNode _focusNode2;
  @override
  void initState() {
    super.initState();
    _focusNode1 = FocusNode();
    _focusNode2 = FocusNode();
  }

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 16,right: 16,bottom: 16,top: 128),
        child: Column(
          children: [
            Container(),
            InputText(
              controller: emailController,
              hintText: "Correo",
              keyboardType: TextInputType.emailAddress,
              icon: Icons.email,
              focusNode: _focusNode1,
              onEditingComplete: () {},
            ),
            InputPassword(
              controller: passwordController,
              hintText: "Contraseña",
              focusNode: _focusNode2,
              icon: Icons.password,
              keyboardType: TextInputType.visiblePassword,
            ),
            PrincipalButton(
                isload: isLoad,
                text: "Iniciar sesión",
                onPressed: () async {
                  if (emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    setState(() {
                      isLoad = true;
                    });

                    await LoginController.Login(
                            /*emailController.text, passwordController.text*/ "netomix",
                            "123456")
                        .then((value) async {
                      print(value);
                      setState(() {
                        isLoad = false;
                      });
                      if (value["Data"] != null) {
                        try {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString('id', "${value["Data"]["Id"]}");
                   
                          print(prefs.get('id'));
                          print("Exito:-------------------------------");
                        } catch (e) {
                          print("Error:--------------------------------");
                          print(e);
                        }
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Menu(usuario: value["Data"])),
                        );

                        print(value["Data"]);
                      } else {
                        print("No login");
                      }
                    }).whenComplete(() => {});

                    ///Lama al controlador de incio de sesion
                  } else {
                    AlertWindow.showSimpleDialog(
                        context, "Alerta", "Completa todos los campos");
                    isLoad = false;
                  }
                }),
          ],
        ),
      ),
    );
  }
}
