import 'package:flutter/material.dart';
import 'package:zion_one/general_components/palette.dart';
import 'package:zion_one/general_components/variable_sizes.dart';

class UpdateMenuPage extends StatefulWidget {
  @override
  _UpdateMenuPageState createState() => _UpdateMenuPageState();
}

class _UpdateMenuPageState extends State<UpdateMenuPage> {
  String selectedDay = "Select day"; // Default value for day selection
  String selectedMeal = "Select meal"; // Default value for meal selection

  // Function to show modal bottom sheet with days of the week
  void _selectDay(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
            height: 300,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    title: Text('Monday'),
                    onTap: () {
                      setState(() {
                        selectedDay = 'Monday';
                      });
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Tuesday'),
                    onTap: () {
                      setState(() {
                        selectedDay = 'Tuesday';
                      });
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Wednesday'),
                    onTap: () {
                      setState(() {
                        selectedDay = 'Wednesday';
                      });
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Thursday'),
                    onTap: () {
                      setState(() {
                        selectedDay = 'Thursday';
                      });
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Friday'),
                    onTap: () {
                      setState(() {
                        selectedDay = 'Friday';
                      });
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Saturday'),
                    onTap: () {
                      setState(() {
                        selectedDay = 'Saturday';
                      });
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Sunday'),
                    onTap: () {
                      setState(() {
                        selectedDay = 'Sunday';
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ));
      },
    );
  }

  // Function to show modal bottom sheet with meal options
  void _selectMeal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
            height: 250,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    title: Text('Breakfast'),
                    onTap: () {
                      setState(() {
                        selectedMeal = 'Breakfast';
                      });
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Lunch'),
                    onTap: () {
                      setState(() {
                        selectedMeal = 'Lunch';
                      });
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Snacks'),
                    onTap: () {
                      setState(() {
                        selectedMeal = 'Snacks';
                      });
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Dinner'),
                    onTap: () {
                      setState(() {
                        selectedMeal = 'Dinner';
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ));
      },
    );
  }

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
                image: AssetImage(
                    "assets/splash_screen/final_bg.png"), // Add your background image here
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Main content
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "UPDATE MENU",
                    style: TextStyle(
                      fontFamily: "ZillaSlabSemiBold",
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 30),

                  // Select Day Button (Updated to display selected day)
                  CustomButton(
                    text: selectedDay, // Displays the selected day
                    color: paletteRed,
                    onPressed: () {
                      _selectDay(context); // Show day selection modal
                    },
                  ),

                  // Select Meal Button (Updated to display selected meal)
                  CustomButton(
                    text: selectedMeal, // Displays the selected meal
                    color: paletteRed,
                    onPressed: () {
                      _selectMeal(context); // Show meal selection modal
                    },
                  ),

                  // Type updated meal text input
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: 300,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Type the updated meal...',
                          filled: true,
                          fillColor: paletteRed,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Update button
                  ElevatedButton(
                    onPressed: () {
                      // Handle update button click here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFC9DB45),
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'UPDATE',
                      style: TextStyle(
                        fontFamily: "ZillaSlabSemiBold",
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom button widget for Select day and Select meal
class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;

  CustomButton({
    required this.text,
    required this.color,
    required this.onPressed,
  });

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
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
