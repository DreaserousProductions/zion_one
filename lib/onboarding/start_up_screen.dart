import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zion_one/general_components/general_widgets.dart';

import 'package:zion_one/general_components/palette.dart';
import 'package:zion_one/general_components/variable_sizes.dart';

class StartUpScreen extends StatefulWidget {
  const StartUpScreen({super.key});

  @override
  State<StartUpScreen> createState() => _StartUpScreenState();
}

class _StartUpScreenState extends State<StartUpScreen> {
  bool isSignedIn = false;

  Future<void> _checkIfSignedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isSignedIn =
        prefs.getBool('isSignedIn') ?? false; // Default to false if not set
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Check if the user is signed in
    _checkIfSignedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/splash_screen/final_bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: tPaletteLight,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 80),
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Column(
                      children: [
                        SizedBox(
                          width: 80,
                          child: Image.asset("assets/splash_screen/logo.png"),
                        ),
                        const Text(
                          "National Institure of Technology Puducherry",
                          style: TextStyle(
                            fontFamily: 'Roboto Serif',
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 280,
                    child: Image.asset("assets/splash_screen/app_logo.png"),
                  ),
                  generalOutlineButton(
                    () {
                      cafeWidth = MediaQuery.sizeOf(context).width;
                      cafeHeight = MediaQuery.sizeOf(context).height;
                      initVars();
                      Navigator.pushReplacementNamed(context,
                          isSignedIn ? "/studentHomePage" : "/register");
                    },
                    tPaletteTomato,
                    paletteLight,
                    2,
                    20,
                    "Get Cooking",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
