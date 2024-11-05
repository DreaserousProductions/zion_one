import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:zion_one/adminSection/admin_homepage.dart';

import 'package:zion_one/onboarding/login.dart';
import 'package:zion_one/onboarding/start_up_screen.dart';
import 'package:zion_one/onboarding/register.dart';
import 'package:zion_one/studentSection/student_home_page.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Future.delayed(const Duration(milliseconds: 100), () {
    FlutterNativeSplash.remove();
  });

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      "/": (context) => const StartUpScreen(),
      "/register": (context) => const Register(),
      "/login": (context) => const Login(),
      "/studentHomePage": (context) => const StudentHomePage(),

      // Admin Imports
      "/adminHomePage": (context) => const AdminHomePage(),
    },
  ));
}

// import 'package:flutter/material.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:zion_one/onboarding/login.dart';

// // Local Imports
// import 'package:zion_one/onboarding/start_up_screen.dart';
// import 'package:zion_one/onboarding/register.dart';
// import 'package:zion_one/studentSection/student_home_page.dart';

// void main() async {
//   WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
//   FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

//   await Future.delayed(const Duration(seconds: 3), () {
//     FlutterNativeSplash.remove();
//   });

//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     routes: {
//       "/": (context) => const StartUpScreen(),
//       "/register": (context) => const Register(),
//       "/login": (context) => const Login(),
//       "/studentHomePage": (context) => const StudentHomePage(),
//     },
//   ));
// }
