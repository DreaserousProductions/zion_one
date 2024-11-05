import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zion_one/general_components/general_widgets.dart';
import 'package:zion_one/general_components/palette.dart';
import 'package:zion_one/general_components/variable_sizes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:zion_one/studentSection/schedule_meals.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  List<String> announcements = [];
  double currentPage = 0;
  final PageController _pageController = PageController(viewportFraction: 1);
  String mealItems = '';

  // Get the current time
  DateTime now = DateTime.now();
  String? mealOfDay;

  // Rating Variables
  bool ratedR = false;
  String dateR = '';
  String dayR = '';
  String mealR = '';
  int mealIdR = 0;
  double valueR = 0;

  // Display Menu
  bool displayMenu = false;
  final PageController _menuPageController =
      PageController(viewportFraction: 0.9);
  int currentMenu = 0;

  // Display Schedule
  bool displaySchedule = false;

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isSignedIn', false); // Default to false if not set
  }

  @override
  void initState() {
    super.initState();
    fetchAnnouncements();
    fetchMeal();
    fetchLastRating();
    // Automatically slide the announcements
    autoScroll();

    // Define the time boundaries for each meal
    DateTime breakfastEnd = DateTime(now.year, now.month, now.day, 9, 30);
    DateTime lunchEnd = DateTime(now.year, now.month, now.day, 14, 30);
    DateTime snacksEnd = DateTime(now.year, now.month, now.day, 18, 30);
    DateTime dinnerEnd = DateTime(now.year, now.month, now.day, 21, 30);

    // Determine the meal of the day based on the current time
    if (now.isBefore(breakfastEnd)) {
      mealOfDay = 'Breakfast';
    } else if (now.isBefore(lunchEnd)) {
      mealOfDay = 'Lunch';
    } else if (now.isBefore(snacksEnd)) {
      mealOfDay = 'Snacks';
    } else if (now.isBefore(dinnerEnd)) {
      mealOfDay = 'Dinner';
    } else {
      mealOfDay = 'No specific meal time';
    }
  }

  Future<void> fetchAnnouncements() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.30.151:7898/announcements'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        setState(() {
          announcements = data.map((item) => item['announ'] as String).toList();
        });
      } else {
        // Handle server error
        print("Failed to load announcements");
      }
    } catch (e) {
      // Handle network error
      print("Error: $e");
    }
  }

  Future<void> fetchMeal() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.30.151:7898/meal'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          mealItems =
              "➤ ${data.toString().replaceAll(", ", "\n➤ ").split(' ').map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase()).join(' ')}";
        });
      } else {
        // Handle server error
        print("Failed to load meals");
      }
    } catch (e) {
      // Handle network error
      print("Error: $e");
    }
  }

  Future<void> fetchLastRating() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final response = await http.post(
        Uri.parse('http://192.168.30.151:7898/last_meal_rating/get_rating'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String?>{
          'email': prefs.getString("userEmail"),
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["status"]) {
          setState(() {
            ratedR = true;
            mealIdR = data["mealId"];
            dateR = data["date"]
                .toString()
                .split('T')[0]
                .split('-')
                .reversed
                .toList()
                .join('/');
            dayR = data["day"].toString();
            mealR = data["meal"].toString();
          });
        }
      } else {
        // Handle server error
        print("Failed to load meals");
      }
    } catch (e) {
      // Handle network error
      print("Error: $e");
    }
  }

  Future<void> setLastRating() async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.30.151:7898/last_meal_rating/set_rating'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            'mealId': mealIdR,
            'rating': valueR,
          },
        ),
      );
      if (response.statusCode == 200) {
        ratedR = false;
      } else {
        // Handle server error
        print("Failed to load meals");
      }
    } catch (e) {
      // Handle network error
      print("Error: $e");
    }
  }

  void autoScroll() {
    Future.delayed(const Duration(seconds: 10), () {
      if (announcements.isNotEmpty) {
        int nextPage =
            (_pageController.page!.toInt() + 1) % announcements.length;
        _pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        setState(() {
          currentPage = nextPage.toDouble();
        });
        // Continue auto-scrolling
        autoScroll();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: tPaletteLight,
            resizeToAvoidBottomInset: false,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                setState(() {
                  displayMenu = !displayMenu;
                });
              },
              shape: const CircleBorder(
                side: BorderSide(
                  color: paletteDark,
                ),
              ),
              child: Image.asset(
                "assets/splash_screen/large_logo.png",
              ),
            ),
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
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 20 * screenFactor, horizontal: 20 * screenFactor),
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: tPaletteLight,
                          border: Border.all(color: paletteDark),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10 * screenFactor),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0 * screenFactor),
                          child: Column(
                            children: [
                              Text(
                                "Announcements",
                                style: TextStyle(
                                  fontFamily: "Zilla Slab HighBold",
                                  fontSize: 22 * screenFactor,
                                ),
                              ),
                              SizedBox(
                                height: 100 * screenFactor,
                                width: double.infinity,
                                child: PageView.builder(
                                  controller: _pageController,
                                  itemCount: announcements.length,
                                  onPageChanged: (int page) {
                                    setState(() {
                                      currentPage = page.toDouble();
                                    });
                                  },
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 25.0 * screenFactor,
                                          vertical: 5.0 * screenFactor),
                                      child: SingleChildScrollView(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "➤ ",
                                              style: TextStyle(
                                                fontFamily: "Zilla Slab",
                                                fontSize: 16 * screenFactor,
                                                color: paletteDark,
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                "${announcements[index]}",
                                                softWrap: true,
                                                style: TextStyle(
                                                  fontFamily: "Zilla Slab",
                                                  fontSize: 16 * screenFactor,
                                                  color: paletteDark,
                                                ),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              DotsIndicator(
                                dotsCount: announcements.isEmpty
                                    ? 1
                                    : announcements.length,
                                position: currentPage.toInt(),
                                decorator: DotsDecorator(
                                  color: paletteDark,
                                  activeColor: paletteRed,
                                  size: Size.square(6.0),
                                  activeSize: Size(16.0, 6.0),
                                  activeShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10 * screenFactor,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: tPaletteGold,
                          border: Border.all(color: paletteDark),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10 * screenFactor),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0 * screenFactor),
                          child: Column(
                            children: [
                              Text(
                                "$mealOfDay|Menu",
                                style: TextStyle(
                                  fontFamily: "Zilla Slab HighBold",
                                  fontSize: 22 * screenFactor,
                                ),
                              ),
                              SizedBox(
                                height: 120 * screenFactor,
                                width: double.infinity,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25.0 * screenFactor,
                                      vertical: 5.0 * screenFactor),
                                  child: SingleChildScrollView(
                                    child: Text(
                                      mealItems,
                                      softWrap: true,
                                      style: TextStyle(
                                        fontFamily: "Zilla Slab",
                                        fontSize: 16 * screenFactor,
                                        color: paletteDark,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ratedR
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 10 * screenFactor,
                                ),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: tPaletteTomato,
                                    border: Border.all(color: paletteDark),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10 * screenFactor),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.0 * screenFactor),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Rate|Your|Meal",
                                          style: TextStyle(
                                            fontFamily: "Zilla Slab HighBold",
                                            fontSize: 22 * screenFactor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                              25.0 * screenFactor,
                                              0,
                                              25.0 * screenFactor,
                                              5 * screenFactor,
                                            ),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "$dayR - $mealR",
                                                    softWrap: true,
                                                    style: TextStyle(
                                                      fontFamily: "Zilla Slab",
                                                      fontSize:
                                                          30 * screenFactor,
                                                      color: paletteDark,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Text(
                                                    dateR,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                      fontFamily: "Zilla Slab",
                                                      fontSize:
                                                          16 * screenFactor,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: paletteDark,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  SizedBox(
                                                    height: 2.5 * screenFactor,
                                                  ),
                                                  StarRating(
                                                    rating: valueR,
                                                    onRatingChanged: (rating) {
                                                      setState(() {
                                                        valueR = rating;
                                                        ratedR = false;
                                                        setLastRating();
                                                      });
                                                    },
                                                    color: paletteGold,
                                                    size: 30,
                                                    spacing: 4.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      SizedBox(
                        height: 10 * screenFactor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          generalOutlineButton(
                            () {},
                            tPaletteGreen,
                            paletteDark,
                            0,
                            16 * screenFactor,
                            "Previous Meals",
                          ),
                          generalOutlineButton(
                            () {
                              setState(() {
                                displaySchedule = !displaySchedule;
                              });
                            },
                            tPaletteGreen,
                            paletteDark,
                            0,
                            16 * screenFactor,
                            "Schedule Meals",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          displayMenu
              ? Scaffold(
                  backgroundColor: tPaletteDark,
                  resizeToAvoidBottomInset: false,
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        displayMenu = !displayMenu;
                        currentMenu = 0;
                      });
                    },
                    shape: const CircleBorder(
                      side: BorderSide(
                        color: paletteDark,
                      ),
                    ),
                    child: Image.asset(
                      "assets/splash_screen/large_logo.png",
                    ),
                  ),
                  body: Center(
                    child: Container(
                      width: cafeWidth * .7,
                      height: cafeHeight * .75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: paletteLight,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            width: cafeWidth * .7,
                            height: cafeHeight * .7,
                            child: PageView.builder(
                              controller: _menuPageController,
                              itemCount: 7,
                              onPageChanged: (int page) {
                                setState(() {
                                  currentMenu = page;
                                });
                              },
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25.0 * screenFactor,
                                      vertical: 5.0 * screenFactor),
                                  child: Image.asset(
                                    "assets/home_screen_student/menu${index + 1}.jpg",
                                  ),
                                );
                              },
                            ),
                          ),
                          DotsIndicator(
                            dotsCount: 7,
                            position: currentMenu,
                            decorator: DotsDecorator(
                              color: tPaletteDark,
                              activeColor: tPaletteRed,
                              size: Size.square(6.0),
                              activeSize: Size(16.0, 6.0),
                              activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : const SizedBox(
                  height: 0,
                  width: 0,
                ),
          displaySchedule
              ? Scaffold(
                  backgroundColor: tPaletteDark,
                  body: Stack(
                    children: [
                      // This GestureDetector captures taps outside ScheduleMeals
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            displaySchedule = false; // Close the schedule
                          });
                        },
                        child: Container(
                          color: Colors.transparent, // Transparent background
                        ),
                      ),
                      // Main content
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            // Prevent closing when tapping on ScheduleMeals
                          },
                          child: ScheduleMeals(),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(
                  height: 0,
                  width: 0,
                ),
        ],
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final ValueChanged<double> onRatingChanged;
  final Color color;
  final double size;
  final double spacing;

  const StarRating({
    super.key,
    this.starCount = 5,
    this.rating = 0.0,
    required this.onRatingChanged,
    this.color = paletteGold,
    this.size = 40.0,
    this.spacing = 4.0,
  });

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = Icon(
        Icons.star_border,
        color: color,
        size: size,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = Icon(
        Icons.star_half,
        color: color,
        size: size,
      );
    } else {
      icon = Icon(
        Icons.star,
        color: color,
        size: size,
      );
    }
    return GestureDetector(
      onTap: () => onRatingChanged(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        starCount,
        (index) => Padding(
          padding: EdgeInsets.only(right: index < starCount - 1 ? spacing : 0),
          child: buildStar(context, index),
        ),
      ),
    );
  }
}
