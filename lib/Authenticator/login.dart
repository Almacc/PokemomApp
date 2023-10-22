import 'package:poke_app_beta/Widget/customTextField.dart';
import 'package:flutter/material.dart';

import '../Widget/error_dialog.dart';
import '../mainscreens/home_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Image.asset("images/pokelogo.png", height: 270,),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  data: Icons.email,
                  controller: emailcontroller,
                  hintText: "Email",
                  isObsecre: false,
                ),
                CustomTextField(
                  data: Icons.lock,
                  controller: passwordcontroller,
                  hintText: "Password",
                  isObsecre: false,
                )
              ],

            ),

          ),
          ElevatedButton(
            child: Text("Login",
              style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
            style: ElevatedButton.styleFrom(
                primary: Colors.purple,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10)
            ),
            onPressed: (){
              if (emailcontroller.text.isNotEmpty && passwordcontroller.text.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              } else {
                showDialog(
                    context: context,
                    builder: (c){
                  return ErrorDialog( message: "Missing information.",
                  );
                });
              }
            },
          ),
          const SizedBox(height: 30),        ],
      )
    );
  }
}
