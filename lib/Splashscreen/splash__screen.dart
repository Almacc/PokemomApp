import 'dart:async';

import 'package:poke_app_beta/Authenticator/auth_screen.dart';
import 'package:flutter/material.dart';




class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}


class _MySplashScreenState extends State<MySplashScreen> {

  startTimer(){
    Timer(Duration(seconds: 5), ()async{
      Navigator.push(context, MaterialPageRoute(builder: (c)=>const AuthScreen()));
    });
  }
  @override
  void initState() {
    super.initState();

    startTimer();
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           ///Image.asset("images/back1.jpg"),

            const SizedBox(height: 10,),

            const Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                  "Pokemon",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 40,
                    fontFamily: "Signatra",
                    letterSpacing: 3,
                  ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
