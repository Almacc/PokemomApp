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
        child: Stack(
          children: [
            Image.asset(
              "images/pokemonintro.jpg",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "images/pokelogo.png", // Replace with your image path
                  height: 150, // Adjust the height as needed
                  width: 150, // Adjust the width as needed
                ),
                const SizedBox(height: 10,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
