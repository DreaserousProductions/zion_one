import 'package:flutter/material.dart';
import 'package:zion_one/general_components/palette.dart';
import 'package:zion_one/general_components/variable_sizes.dart';

class MealsServedPage extends StatelessWidget {
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
                    'assets/image.png'), // Add your background image here
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Text(
                  "Friday",
                  style: TextStyle(
                    fontFamily: "ZillaSlab",
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "02/08/24",
                  style: TextStyle(
                    fontFamily: "ZillaSlabSemiBold",
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "NO. OF MEALS SERVED",
                  style: TextStyle(
                    fontFamily: "ZillaSlab",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                MealsCard(
                  iconPath: 'assets/breakfast.png',
                  mealType: 'BREAKFAST',
                  mealsServed: '150',
                  backgroundColor: paletteRed,
                ),
                MealsCard(
                  iconPath: 'assets/lunch.png',
                  mealType: 'LUNCH',
                  mealsServed: '200',
                  backgroundColor: paletteRed,
                ),
                MealsCard(
                  iconPath: 'assets/coffee-break.png',
                  mealType: 'SNACKS',
                  mealsServed: '250',
                  backgroundColor: paletteRed,
                ),
                MealsCard(
                  iconPath: 'assets/dinner.png',
                  mealType: 'DINNER',
                  mealsServed: '200',
                  backgroundColor: paletteRed,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Optionally handle button click here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    '02/08/24',
                    style: TextStyle(
                      fontFamily: "ZillaSlab",
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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

class MealsCard extends StatelessWidget {
  final String iconPath;
  final String mealType;
  final String mealsServed;
  final Color backgroundColor;

  MealsCard({
    required this.iconPath,
    required this.mealType,
    required this.mealsServed,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Image.asset(iconPath, width: 50, height: 50),
          title: Text(
            mealType,
            style: TextStyle(
              fontFamily: "ZillaSlab",
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          trailing: Text(
            mealsServed,
            style: TextStyle(
              fontFamily: "ZillaSlab",
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
