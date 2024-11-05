import 'package:flutter/material.dart';
import 'package:admin_mess_app/general_components/palette.dart';
import 'package:admin_mess_app/general_components/variable_sizes.dart';
import 'package:intl/intl.dart';

class MealsServedPage extends StatefulWidget {
  @override
  _MealsServedPageState createState() => _MealsServedPageState();
}

class _MealsServedPageState extends State<MealsServedPage> {
  DateTime _selectedDate = DateTime.now();

  // Sample data for meals served on specific dates
  final Map<DateTime, Map<String, int>> mealsDataByDate = {
    DateTime(2024, 11, 2): {'BREAKFAST': 150, 'LUNCH': 200, 'SNACKS': 250, 'DINNER': 200},
    DateTime(2024, 11, 3): {'BREAKFAST': 180, 'LUNCH': 220, 'SNACKS': 300, 'DINNER': 210},
    DateTime(2024, 11, 4): {'BREAKFAST': 160, 'LUNCH': 210, 'SNACKS': 270, 'DINNER': 230},
  };

  // Method to format date
  String get formattedDate => DateFormat('dd/MM/yy').format(_selectedDate);
  String get dayOfWeek => DateFormat('EEEE').format(_selectedDate);

  // Get meals data for the selected date, or default values if date not present
  Map<String, int> get mealsServedForDate {
    return mealsDataByDate[_selectedDate] ?? {'BREAKFAST': 0, 'LUNCH': 0, 'SNACKS': 0, 'DINNER': 0};
  }

  @override
  Widget build(BuildContext context) {
    Map<String, int> mealsServed = mealsServedForDate;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "NITPY Cafeteria",
          style: TextStyle(
            fontFamily: "ZillaSlabSemiBold",
            fontSize: 28 * screenFactor,
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
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image.png'),
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
                  dayOfWeek,
                  style: TextStyle(
                    fontFamily: "ZillaSlab",
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  formattedDate,
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
                  mealsServed: mealsServed['BREAKFAST'].toString(),
                  backgroundColor: paletteRed,
                ),
                MealsCard(
                  iconPath: 'assets/lunch.png',
                  mealType: 'LUNCH',
                  mealsServed: mealsServed['LUNCH'].toString(),
                  backgroundColor: paletteRed,
                ),
                MealsCard(
                  iconPath: 'assets/coffee-break.png',
                  mealType: 'SNACKS',
                  mealsServed: mealsServed['SNACKS'].toString(),
                  backgroundColor: paletteRed,
                ),
                MealsCard(
                  iconPath: 'assets/dinner.png',
                  mealType: 'DINNER',
                  mealsServed: mealsServed['DINNER'].toString(),
                  backgroundColor: paletteRed,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (newDate != null && newDate != _selectedDate) {
                      setState(() {
                        _selectedDate = newDate;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    formattedDate,
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
