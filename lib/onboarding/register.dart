import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Local Imports
import 'package:zion_one/general_components/palette.dart';
import 'package:zion_one/general_components/variable_sizes.dart';
import 'package:zion_one/onboarding/shared_component.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? emailError;
  String? passwordError;

  RegExp emailExp = RegExp(r"^\w+([.-]?\w+)*@nitpy\.ac\.in$");
  RegExp passExp = RegExp("^(?=.*[0-9])(?=.*[^a-zA-Z0-9/\\'\"`]).{6,}");

  Future<void> register() async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.30.151:7898/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': emailController.text,
          'password': passwordController.text,
        }),
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        // Registration successful
        Navigator.pushReplacementNamed(context, "/login");
      } else {
        // Handle error
        setState(() {
          if (!emailExp.hasMatch(emailController.text)) {
            emailError = "Invalid E-mail";
          } else {
            emailError = null;
          }
          if (!passExp.hasMatch(passwordController.text)) {
            passwordError = "Password must be at least 6 characters long";
          } else {
            passwordError = null;
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
            "Registration",
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
              vertical: 30.0 * screenFactor, horizontal: 30 * screenFactor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                          passExp.hasMatch(passwordController.text)) {
                        await register();
                      } else {
                        setState(() {
                          emailExp.hasMatch(emailController.text)
                              ? emailError = null
                              : emailError = "Invalid E-mail";
                          passExp.hasMatch(passwordController.text)
                              ? passwordError = null
                              : passwordError =
                                  "Password must be at least 6 characters long";
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
                        "Register",
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
                  SizedBox(
                    height: 5 * screenFactor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                          fontFamily: "Roboto Serif",
                          fontWeight: FontWeight.w900,
                          fontSize: 12 * screenFactor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/login");
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontFamily: "Roboto Serif",
                            fontWeight: FontWeight.w900,
                            fontSize: 12 * screenFactor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Note",
                    style: TextStyle(
                      fontFamily: "Zilla Slab SemiBold",
                      fontWeight: FontWeight.w900,
                      fontSize: 24 * screenFactor,
                    ),
                  ),
                  Text(
                    "Students should use their college e-mail id.\nEg: CS19B1001@nitpy.ac.in\n\nAccess your college mailbox at\nhttps://mail.nitpy.ac.in",
                    style: TextStyle(
                      fontFamily: "Zilla Slab",
                      fontSize: 16 * screenFactor,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
