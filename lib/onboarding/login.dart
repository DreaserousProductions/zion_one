import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// Local Imports
import 'package:zion_one/general_components/palette.dart';
import 'package:zion_one/general_components/variable_sizes.dart';
import 'package:zion_one/onboarding/shared_component.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? emailError;
  String? passwordError;

  RegExp emailExp = RegExp(r"^\w+([.-]?\w+)*@nitpy\.ac\.in$");

  Future<void> login() async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.30.151:7898/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': emailController.text,
          'password': passwordController.text,
        }),
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isSignedIn', true); // Set sign-in status
        await prefs.setString(
            'userEmail', emailController.text); // Set email status
      }

      if (!mounted) return;

      if (response.statusCode == 200) {
        // Login successful
        Navigator.pushReplacementNamed(context, "/studentHomePage");
      } else {
        print(response.statusCode);
        // Handle error
        setState(() {
          if (!emailExp.hasMatch(emailController.text)) {
            emailError = "Invalid E-mail";
          } else {
            emailError = null;
          }
          if (passwordController.text.isEmpty) {
            passwordError = "Password cannot be empty";
          } else {
            passwordError = "Incorrect password";
          }
        });
      }
    } catch (e) {
      // Handle network or other errors
      if (!mounted) return;
      setState(() {
        emailError = "An error occurred. Please try again.";
        passwordError = null;
      });
    }
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
        appBar: AppBar(
          title: Text(
            "Login",
            style: TextStyle(
              fontFamily: "Zilla Slab SemiBold",
              fontSize: (30 * screenFactor),
              color: paletteLight,
            ),
          ),
          centerTitle: true,
          backgroundColor: paletteDark,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 8.0 * screenFactor, horizontal: 30 * screenFactor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30 * screenFactor,
              ),
              buildInputField(
                emailController,
                paletteTomato,
                paletteDark,
                16,
                "E-Mail",
                emailError,
                false,
              ),
              buildInputField(
                passwordController,
                paletteTomato,
                paletteDark,
                16,
                "Password",
                passwordError,
                true,
              ),
              SizedBox(
                height: 30 * screenFactor,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (emailExp.hasMatch(emailController.text) &&
                      passwordController.text.isNotEmpty) {
                    await login();
                  } else {
                    setState(() {
                      emailExp.hasMatch(emailController.text)
                          ? emailError = null
                          : emailError = "Invalid E-mail";
                      passwordController.text.isNotEmpty
                          ? passwordError = null
                          : passwordError = "Password cannot be empty";
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0 * screenFactor),
                    side: const BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  backgroundColor: tPaletteTomato,
                  shadowColor: Colors.transparent,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 5, vertical: 10.0 * screenFactor),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontFamily: "Zilla Slab",
                      fontWeight: FontWeight.w100,
                      fontSize: 18 * screenFactor,
                      letterSpacing: 2 * screenFactor,
                      color: paletteLight,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
