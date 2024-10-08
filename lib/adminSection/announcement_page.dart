import 'package:flutter/material.dart';
import 'package:admin_mess_app/general_components/palette.dart';
import 'package:admin_mess_app/general_components/variable_sizes.dart';

class AnnouncementPage extends StatelessWidget {
  final TextEditingController announcementController = TextEditingController();

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
              // actions: [
              //   IconButton(
              //     icon: const Icon(Icons.logout),
              //     color: paletteLight,
              //     onPressed: () {
              //     //  _logout();
              //       Navigator.pushReplacementNamed(context, "/");
              //     },
              //   ),
              // ],
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
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image.png'), // Add your background image here
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
                  height: 200,
                  decoration: BoxDecoration(
                    color: paletteRed,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: announcementController,
                      decoration: InputDecoration(
                        hintText: 'Type announcement...',
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
                        SnackBar(content: Text('Announcement Posted: $announcement')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please type an announcement')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow[600], // Button color based on your screenshot
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'POST',
                    style: TextStyle(
                      fontFamily: "ZillaSlab",
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
