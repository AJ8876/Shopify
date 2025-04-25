import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Athentication_module/Login.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
      });

      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                  children: [
            Image.asset("asset/applogo.png",height: 200,width: 200),
            SizedBox(height: 25),
            Text(
              "E Commerce",
              style: TextStyle(
                  color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            if(isLoading)
            CircularProgressIndicator(
             valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
                  ],
                ),
        ),
        );
  }
}
