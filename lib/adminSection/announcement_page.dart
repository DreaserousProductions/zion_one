import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zion_one/general_components/palette.dart';
import 'package:zion_one/general_components/variable_sizes.dart';

class AnnouncementPage extends StatefulWidget {
  const AnnouncementPage({super.key});

  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  final TextEditingController announcementController = TextEditingController();

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isSignedIn', false); // Default to false if not set
  }

  Future<void> announce() async {
    // Format the date
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    try {
      final response = await http.post(
        Uri.parse('http://192.168.30.151:7898/announcements'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'body': announcementController.text,
          'date': formattedDate,
        }),
      );

      print(response.statusCode);

      if (!mounted) return;

      if (response.statusCode == 200) {
        // Login successful
        Navigator.pushReplacementNamed(context, "/adminHomePage");
      } else {
        print(response.statusCode);
        // Handle error
        // setState(() {
        //   if (!emailExp.hasMatch(emailController.text)) {
        //     emailError = "Invalid E-mail";
        //   } else {
        //     emailError = null;
        //   }
        //   if (passwordController.text.isEmpty) {
        //     passwordError = "Password cannot be empty";
        //   } else {
        //     passwordError = "Incorrect password";
        //   }
        // });
      }
    } catch (e) {
      // Handle network or other errors
      if (!mounted) return;
      // setState(() {
      //   emailError = "An error occurred. Please try again.";
      //   passwordError = null;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "NITPY Cafeteria",
          style: TextStyle(
            fontFamily: "Zilla Slab SemiBold",
            fontSize: (28 * screenFactor),
            color: paletteLight,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            color: paletteLight,
            onPressed: () {
              _logout();
              Navigator.pushReplacementNamed(context, "/");
            },
          ),
        ],
        backgroundColor: paletteDark,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/splash_screen/final_bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Announcement box
                Container(
                  width: 300,
                  height: 250,
                  decoration: BoxDecoration(
                    color: paletteRed,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: announcementController,
                      decoration: InputDecoration(
                        hintText: 'Type announcement',
                        border: InputBorder.none,
                      ),
                      maxLines: 5,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Post button
                ElevatedButton(
                  onPressed: () {
                    // Handle the announcement post action
                    final announcement = announcementController.text;
                    if (announcement.isNotEmpty) {
                      // Process the announcement, e.g., send it to the server
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text('Announcement Posted: $announcement')),
                      );
                      announce();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please type an announcement')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors
                        .yellow[600], // Button color based on your screenshot
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'POST',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class AnnouncementPage extends StatelessWidget {
//   final TextEditingController announcementController = TextEditingController();

//   Future<void> _logout() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setBool('isSignedIn', false); // Default to false if not set
//   }

//   Future<void> login() async {
//     try {
//       final response = await http.post(
//         Uri.parse('http://192.168.30.151:7898/login'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(<String, String>{
//           'body': announcementController.text,
//         }),
//       );

//       print(response.statusCode);

//       if (!mounted) return;

//       if (response.statusCode == 200) {
//         // Login successful
//         Navigator.pushReplacementNamed(context, "/studentHomePage");
//       } else if (response.statusCode == 201) {
//         // Login successful
//         Navigator.pushReplacementNamed(context, "/adminHomePage");
//       } else {
//         print(response.statusCode);
//         // Handle error
//         setState(() {
//           if (!emailExp.hasMatch(emailController.text)) {
//             emailError = "Invalid E-mail";
//           } else {
//             emailError = null;
//           }
//           if (passwordController.text.isEmpty) {
//             passwordError = "Password cannot be empty";
//           } else {
//             passwordError = "Incorrect password";
//           }
//         });
//       }
//     } catch (e) {
//       // Handle network or other errors
//       if (!mounted) return;
//       setState(() {
//         emailError = "An error occurred. Please try again.";
//         passwordError = null;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "NITPY Cafeteria",
//           style: TextStyle(
//             fontFamily: "Zilla Slab SemiBold",
//             fontSize: (28 * screenFactor),
//             color: paletteLight,
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             color: paletteLight,
//             onPressed: () {
//               _logout();
//               Navigator.pushReplacementNamed(context, "/");
//             },
//           ),
//         ],
//         backgroundColor: paletteDark,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(10),
//             bottomRight: Radius.circular(10),
//           ),
//         ),
//       ),
//       body: Stack(
//         children: [
//           // Background image
//           Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage("assets/splash_screen/final_bg.png"),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // Announcement box
//                 Container(
//                   width: 300,
//                   height: 250,
//                   decoration: BoxDecoration(
//                     color: paletteRed,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: TextField(
//                       controller: announcementController,
//                       decoration: InputDecoration(
//                         hintText: 'Type announcement',
//                         border: InputBorder.none,
//                       ),
//                       maxLines: 5,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 // Post button
//                 ElevatedButton(
//                   onPressed: () {
//                     // Handle the announcement post action
//                     final announcement = announcementController.text;
//                     if (announcement.isNotEmpty) {
//                       // Process the announcement, e.g., send it to the server
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                             content:
//                                 Text('Announcement Posted: $announcement')),
//                       );
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Please type an announcement')),
//                       );
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors
//                         .yellow[600], // Button color based on your screenshot
//                     padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                   child: Text(
//                     'POST',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
