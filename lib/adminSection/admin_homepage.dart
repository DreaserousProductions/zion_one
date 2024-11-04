import 'package:admin_mess_app/general_components/palette.dart';
import 'package:admin_mess_app/general_components/variable_sizes.dart';
import 'package:flutter/material.dart';
import 'announcement_page.dart';
import 'meal_served_page.dart';
import 'update_menu.dart';
import 'rating.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: Text(
                "NITPY Cafeteria",
                style: TextStyle(
                  fontFamily: "ZillaSlabSemiBold",
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
                  //  _logout();
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
                image: AssetImage('assets/image.png'), // Add your background image here
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content with buttons
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  icon: Icons.announcement,
                  text: "Make announcements",
                  color: paletteRed,
                  onPressed: () {
                    // Navigate to announcement page when button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AnnouncementPage()),
                    );
                  },
                ),
                CustomButton(
                  icon: Icons.restaurant,
                  text: "Number of meals served",
                  color: paletteRed,
                  onPressed: () {
                                        Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MealsServedPage()), // Navigate to the new page
                    );
                  },
                ),
                CustomButton(
                  icon: Icons.star,
                  text: "Ratings and review",
                  color: paletteRed,
                  onPressed: () {Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RatingsAndReviewsPage()),
                    );
                  },
                ),
                CustomButton(
                  icon: Icons.menu_book,
                  text: "Update Menu",
                  color: paletteRed,
                  onPressed: () {
                                        Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UpdateMenuPage()),
                                        );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final VoidCallback onPressed;

  CustomButton({required this.icon, required this.text, required this.color, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        width: 300,
        height: 70,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color, 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: onPressed, 
          child: Row(
            children: [
              Icon(icon, size: 30, color: paletteLight),
              SizedBox(width: 20),
              Text(
                text,
                style:  TextStyle(
                  fontFamily: 'ZillaSlab',
                  fontSize: 20 * screenFactor,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// import 'package:admin_mess_app/general_components/palette.dart';
// import 'package:admin_mess_app/general_components/variable_sizes.dart';
// import 'package:flutter/material.dart';
// import 'announcement_page.dart';

// class AdminHomePage extends StatefulWidget {
//   const AdminHomePage({super.key});

//   @override
//   State<AdminHomePage> createState() => _AdminHomePageState();
// }

// class _AdminHomePageState extends State<AdminHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('NITPY Cafeteria',
//                   style: TextStyle(
//                   fontFamily: 'ZillaSlab',
//                   fontSize: 20 * screenFactor,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 )),
//         backgroundColor: Colors.black,
//       ),
//       body: Stack(
//         children: [
//           // Background image
//           Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/image.png'), // Add your background image here
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           // Content with buttons
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CustomButton(
//                   icon: Icons.announcement,
//                   text: "Make announcements",
//                   color: paletteRed,
//                   onPressed: () {
//                     // Navigate to announcement page when button is pressed
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => AnnouncementPage()),
//                     );
//                   },
//                 ),
//                 CustomButton(
//                   icon: Icons.restaurant,
//                   text: "Number of meals served",
//                   color: paletteRed,
//                 ),
//                 CustomButton(
//                   icon: Icons.star,
//                   text: "Ratings and review",
//                   color: paletteRed,
//                 ),
//                 CustomButton(
//                   icon: Icons.menu_book,
//                   text: "Update Menu",
//                   color: paletteRed,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CustomButton extends StatelessWidget {
//   final IconData icon;
//   final String text;
//   final Color color;
//   final VoidCallback onPressed;

//   CustomButton({required this.icon, required this.text, required this.color});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: SizedBox(
//         width: 300,
//         height: 70,
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: color, // Updated property
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),
//           ),
//           onPressed: (){},
//           child: Row(
//             children: [
//               Icon(icon, size: 30, color: paletteLight),
//               SizedBox(width: 20),
//               Text(
//                 text,
//                 style:  TextStyle(
//                   fontFamily: 'ZillaSlab',
//                   fontSize: 20 * screenFactor,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'NITPY Cafeteria',
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('NITPY Cafeteria',
//                   style: TextStyle(
//                   fontFamily: 'ZillaSlab',
//                   fontSize: 20 * ,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 )),
//         backgroundColor: Colors.black,
//       ),
//       body: Stack(
//         children: [
//           // Background image
//           Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/image.png'), // Add your background image here
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           // Content with buttons
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CustomButton(
//                   icon: Icons.announcement,
//                   text: "Make announcements",
//                   color: Colors.red,
//                 ),
//                 CustomButton(
//                   icon: Icons.restaurant,
//                   text: "Number of meals served",
//                   color: Colors.grey,
//                 ),
//                 CustomButton(
//                   icon: Icons.star,
//                   text: "Ratings and review",
//                   color: Colors.red,
//                 ),
//                 CustomButton(
//                   icon: Icons.menu_book,
//                   text: "Update Menu",
//                   color: Colors.red,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CustomButton extends StatelessWidget {
//   final IconData icon;
//   final String text;
//   final Color color;

//   CustomButton({required this.icon, required this.text, required this.color});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: SizedBox(
//         width: 300,
//         height: 70,
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: color, // Updated property
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),
//           ),
//           onPressed: () {
//             // Define the action here
//           },
//           child: Row(
//             children: [
//               Icon(icon, size: 30, color: Colors.white),
//               SizedBox(width: 20),
//               Text(
//                 text,
//                 style: const TextStyle(
//                   fontFamily: 'ZillaSlab',
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
