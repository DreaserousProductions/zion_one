import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:admin_mess_app/general_components/palette.dart';
import 'package:admin_mess_app/general_components/variable_sizes.dart';

class PreviousMealsPage extends StatefulWidget {
  @override
  _PreviousMealsPageState createState() => _PreviousMealsPageState();
}

class _PreviousMealsPageState extends State<PreviousMealsPage> {
  DateTime selectedDate = DateTime.now();

  // Sample meal data for specific dates
  final Map<DateTime, Map<String, String>> mealsStatus = {
    DateTime(2024, 11, 2): {
      'Breakfast': 'COLLECTED','Lunch': 'SKIPPED','Snacks': 'COLLECTED','Dinner': 'COLLECTED'},
    DateTime(2024, 11, 3): {
      'Breakfast': 'SKIPPED','Lunch': 'COLLECTED','Snacks': 'COLLECTED','Dinner': 'SKIPPED' },
  };

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024, 1),
      lastDate: DateTime(2024, 12),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yy').format(selectedDate);
    String dayOfWeek = DateFormat('EEEE').format(selectedDate);

    // Get meal status for the selected date
    Map<String, String> selectedMealsStatus = mealsStatus[selectedDate] ?? {
      'Breakfast': 'COLLECTED','Lunch': 'COLLECTED','Snacks': 'COLLECTED','Dinner': 'COLLECTED'
    };

    return Scaffold(
           appBar: AppBar(
              title: Text(
                "Previous Meals",
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
                    //_logout();
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
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.1),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  dayOfWeek,
                  style: TextStyle(
                    fontFamily: "ZillaSlab",
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontFamily: "ZillaSlabSemiBold",
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    children: selectedMealsStatus.entries.map((entry) {
                      return MealStatusCard(
                        mealType: entry.key,
                        status: entry.value,
                        onCollected: () {
                          // Navigate to review page when COLLECTED button is pressed
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => REviewPage(mealType: entry.key),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 20),
                // Date Selector Button
                ElevatedButton(
                  onPressed: () => _selectDate(context),
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

class MealStatusCard extends StatelessWidget {
  final String mealType;
  final String status;
  final VoidCallback onCollected;

  MealStatusCard({
    required this.mealType,
    required this.status,
    required this.onCollected,
  });

  // Method to select the correct icon based on meal type
  String _getMealIcon(String mealType) {
    switch (mealType) {
      case 'Breakfast':
        return 'assets/breakfast.png';
      case 'Lunch':
        return 'assets/lunch.png';
      case 'Snacks':
        return 'assets/coffee-break.png';
      case 'Dinner':
        return 'assets/dinner.png';
      default:
        return 'assets/breakfast.png'; // default image if meal type is unknown
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isCollected = status == 'COLLECTED';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Image.asset(
            _getMealIcon(mealType),
            width: 50,
            height: 50,
          ),
          title: Text(
            mealType,
            style: TextStyle(
              fontFamily: "ZillaSlab",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          trailing: isCollected
              ? ElevatedButton(
                  onPressed: onCollected,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: paletteDark,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontFamily: "ZillaSlab",
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontFamily: "ZillaSlab",
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class REviewPage extends StatefulWidget {
  final String mealType;

  REviewPage({required this.mealType});

  @override
  _REviewPageState createState() => _REviewPageState();
}

class _REviewPageState extends State<REviewPage> {
  // Track selected options
  String _mealServiceRating = '';
  String _foodQualityRating = '';
  int _starRating = 0;

  // Controller for comments
  final TextEditingController _commentsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            color: paletteTomato,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Meal type title
              Text(
                widget.mealType,
                style: TextStyle(
                  fontFamily: 'ZillaSlab',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),

              // Meal Service Rating
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Meal Service",
                  style: TextStyle(
                    fontFamily: 'ZillaSlab',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),
              RatingOptions(
                options: ['Poor', 'Good', 'Excellent'],
                selectedOption: _mealServiceRating,
                onSelected: (rating) {
                  setState(() {
                    _mealServiceRating = rating;
                  });
                },
              ),
              SizedBox(height: 20),

              // Food Quality Rating
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Food Quality",
                  style: TextStyle(
                    fontFamily: 'ZillaSlab',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),
              RatingOptions(
                options: ['Poor', 'Good', 'Excellent'],
                selectedOption: _foodQualityRating,
                onSelected: (rating) {
                  setState(() {
                    _foodQualityRating = rating;
                  });
                },
              ),
              SizedBox(height: 20),

              // Comments text field
              TextField(
                controller: _commentsController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Type your comments',
                  hintStyle: TextStyle(color: paletteDark),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Star rating
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < _starRating ? Icons.star : Icons.star_border,
                      color: Colors.yellow,
                    ),
                    onPressed: () {
                      setState(() {
                        _starRating = index + 1;
                      });
                    },
                  );
                }),
              ),
              SizedBox(height: 20),

              // Submit button
              ElevatedButton(
                onPressed: () {
                  // Submit review logic can be added here
                  Navigator.pop(context); // Close the review page after submission
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: paletteGold,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      fontFamily: 'ZillaSlab',
                      fontSize: 18,
                      color: Colors.black,
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

class RatingOptions extends StatelessWidget {
  final List<String> options;
  final String selectedOption;
  final Function(String) onSelected;

  RatingOptions({
    required this.options,
    required this.selectedOption,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: options.map((option) {
        bool isSelected = option == selectedOption;
        return GestureDetector(
          onTap: () => onSelected(option),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.lime[700] : Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              option,
              style: TextStyle(
                fontFamily: 'ZillaSlab',
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
