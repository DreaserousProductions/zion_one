import 'package:flutter/material.dart';
import 'package:admin_mess_app/general_components/palette.dart';
import 'package:admin_mess_app/general_components/variable_sizes.dart';
import 'package:intl/intl.dart';

class RatingsAndReviewsPage extends StatefulWidget {
  @override
  _RatingsAndReviewsPageState createState() => _RatingsAndReviewsPageState();
}

class _RatingsAndReviewsPageState extends State<RatingsAndReviewsPage> {
  DateTime selectedDate = DateTime.now();
  String selectedMeal = "Breakfast";

  // Sample reviews data grouped by date and meal
  final Map<DateTime, Map<String, List<Map<String, dynamic>>>> reviewsByDateAndMeal = {
    DateTime(2024, 11, 2): {
      "Breakfast": [
        {'user': 'CS22B10__', 'rating': 5, 'comment': 'Great breakfast, very satisfying!'},
        {'user': 'EE22B10__', 'rating': 4, 'comment': 'Tasty and fresh!'},
        {'user': 'ME22B10__', 'rating': 4, 'comment': 'Average experience.'},
      ],
      "Lunch": [
        {'user': 'ME22B10__', 'rating': 3, 'comment': 'Decent lunch.'},
        {'user': 'CS22B10__', 'rating': 5, 'comment': 'Loved the lunch!'},
      ],
    },
    DateTime(2024, 11, 3): {
      "Breakfast": [
        {'user': 'ME22B10__', 'rating': 1, 'comment': 'Not good.'},
        {'user': 'EC22B10__', 'rating': 5, 'comment': 'Loved it!'},
      ],
      "Dinner": [
        {'user': 'CS22B10__', 'rating': 4, 'comment': 'Tasty dinner.'},
        {'user': 'EC22B10__', 'rating': 3, 'comment': 'Could be better.'},
      ],
    },
  };

  double _calculateAverageRating(List<Map<String, dynamic>> reviews) {
    if (reviews.isEmpty) return 0.0;
    int totalRating = reviews.fold(0, (sum, review) => sum + review['rating'] as int);
    return totalRating / reviews.length;
  }

  Map<int, double> _calculateRatingDistribution(List<Map<String, dynamic>> reviews) {
    Map<int, int> ratingCounts = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
    for (var review in reviews) {
      ratingCounts[review['rating']] = (ratingCounts[review['rating']] ?? 0) + 1;
    }

    int totalRatings = reviews.length;
    return {
      for (int star = 1; star <= 5; star++)
        star: totalRatings == 0 ? 0.0 : ratingCounts[star]! / totalRatings,
    };
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024, 1),
      lastDate: DateTime(2024, 12),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        selectedMeal = "Breakfast"; // Reset the meal selection
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> reviews =
        reviewsByDateAndMeal[selectedDate]?[selectedMeal] ?? [];
    double averageRating = _calculateAverageRating(reviews);
    int totalRatings = reviews.length;
    Map<int, double> ratingDistribution = _calculateRatingDistribution(reviews);

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
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Text(
                    "Ratings & Reviews",
                    style: TextStyle(
                      fontFamily: "ZillaSlab",
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    selectedMeal.toUpperCase(),
                    style: TextStyle(
                      fontFamily: "ZillaSlab",
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Average Rating Display
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            reviews.isEmpty ? "0.0" : averageRating.toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: List.generate(5, (index) {
                              return Icon(
                                Icons.star,
                                color: index < averageRating ? Colors.green : Colors.grey,
                              );
                            }),
                          ),
                          Text(
                            "$totalRatings ratings",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20),
                      // Rating Breakdown
                      Expanded(
                        child: Column(
                          children: List.generate(5, (index) {
                            int star = 5 - index;
                            return Row(
                              children: [
                                Text("$star"),
                                SizedBox(width: 8),
                                Expanded(
                                  child: LinearProgressIndicator(
                                    value: ratingDistribution[star],
                                    color: Colors.green,
                                    backgroundColor: Colors.grey[300],
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Reviews List
                  Column(
                    children: reviews.map((review) {
                      return Card(
                        color: Colors.red[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    review['user'],
                                    style: TextStyle(
                                      fontFamily: "ZillaSlab",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Row(
                                    children: List.generate(5, (index) {
                                      return Icon(
                                        Icons.star,
                                        color: index < review['rating'] ? Colors.green : Colors.grey,
                                        size: 16,
                                      );
                                    }),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                review['comment'],
                                style: TextStyle(
                                  fontFamily: "ZillaSlab",
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  // Date Button
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
                      DateFormat('dd/MM/yy').format(selectedDate),
                      style: TextStyle(
                        fontFamily: "ZillaSlab",
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
          // Meal Dropdown with red background
          DropdownButtonHideUnderline(
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 244, 2, 36), // Set background color to red
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: DropdownButton<String>(
                value: selectedMeal,
                dropdownColor: Color.fromARGB(255, 244, 2, 36), // Background color of the dropdown menu items
                items: ["Breakfast", "Lunch", "Snacks", "Dinner"].map((String meal) {
                  return DropdownMenuItem<String>(
                    value: meal,
                    child: Text(
                      meal,
                      style: TextStyle(
                        fontFamily: "ZillaSlab",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Text color
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newMeal) {
                  if (newMeal != null) {
                    setState(() {
                      selectedMeal = newMeal;
                    });
                  }
                },
              //  icon: Icon(Icons.arrow_drop_down, color: Colors.white), // Dropdown icon color
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
