import 'package:flutter/material.dart';
import 'package:zion_one/general_components/palette.dart';
import 'package:zion_one/general_components/variable_sizes.dart';

class ScheduleMeals extends StatefulWidget {
  const ScheduleMeals({super.key});

  @override
  State<ScheduleMeals> createState() => _ScheduleMealsState();
}

class _ScheduleMealsState extends State<ScheduleMeals> {
  DateTime currentDate = DateTime.now();
  DateTime selectedDate = DateTime.now();
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: getMonthPageIndex(currentDate));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Function to calculate the correct page index based on current year/month
  int getMonthPageIndex(DateTime date) {
    return date.year * 12 +
        date.month -
        1; // Unique index for each month of any year
  }

  // Function to convert page index back to DateTime
  DateTime getDateFromPageIndex(int index) {
    int year = index ~/ 12;
    int month = index % 12 + 1;
    return DateTime(year, month);
  }

  void _onPageChanged(int page) {
    setState(() {
      currentDate = getDateFromPageIndex(page);
    });
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  // Calculate the number of rows for the calendar grid dynamically
  int calculateNumberOfRows(DateTime date) {
    DateTime firstDayOfMonth = DateTime(date.year, date.month, 1);
    DateTime lastDayOfMonth = DateTime(date.year, date.month + 1, 0);

    int totalDays = lastDayOfMonth.day;
    int startingWeekday = firstDayOfMonth.weekday % 7;

    // Total grid slots needed (days + empty slots at the start of the month)
    int numDaysGridSlots = totalDays + startingWeekday;
    int numRows =
        (numDaysGridSlots / 7).ceil() + 1; // +1 for the weekday row header
    return numRows;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cafeWidth * .8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: paletteLight,
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0 * screenFactor),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${getMonthName(currentDate.month)} ${currentDate.year}',
              style: TextStyle(
                fontFamily: "Zilla Slab HighBold",
                fontSize: 28 * screenFactor,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                8.0 * screenFactor,
                0,
                8.0 * screenFactor,
                8.0 * screenFactor,
              ),
              child: buildCalendar(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCalendar() {
    // Get number of rows dynamically for the current month
    int rows = calculateNumberOfRows(currentDate);
    double rowHeight =
        40.0 * screenFactor; // Customize row height based on your UI

    return Container(
      height: rowHeight *
          rows, // Dynamically set height based on the number of rows
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        itemBuilder: (context, pageIndex) {
          DateTime displayDate = getDateFromPageIndex(pageIndex);
          return buildMonthCalendar(displayDate);
        },
      ),
    );
  }

  Widget buildMonthCalendar(DateTime date) {
    DateTime firstDayOfMonth = DateTime(date.year, date.month, 1);
    DateTime lastDayOfMonth = DateTime(date.year, date.month + 1, 0);
    int totalDays = lastDayOfMonth.day;
    int startingWeekday = firstDayOfMonth.weekday % 7;

    List<Widget> dayWidgets = [];

    // Add day headers (Sun, Mon, etc.)
    for (int i = 0; i < 7; i++) {
      dayWidgets.add(Center(
        child: Text(
          getWeekdayName(i),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ));
    }

    // Add empty slots before the first day of the month
    for (int i = 0; i < startingWeekday; i++) {
      dayWidgets.add(Container());
    }

    // Add days of the month
    for (int day = 1; day <= totalDays; day++) {
      DateTime currentDay = DateTime(date.year, date.month, day);
      bool isToday = isSameDay(currentDay, DateTime.now());
      bool isSelected = isSameDay(currentDay, selectedDate);

      dayWidgets.add(GestureDetector(
        onTap: () {
          _onDateSelected(currentDay);
        },
        child: Container(
          margin: EdgeInsets.all(4),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.blueAccent
                : isToday
                    ? Colors.lightBlue
                    : Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(
              color: isSelected ? Colors.blue : Colors.black54,
              width: isSelected ? 2.0 : 1.0,
            ),
          ),
          child: Text(
            '$day',
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      ));
    }

    return GridView.count(
      crossAxisCount: 7,
      childAspectRatio: 1.2,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: dayWidgets,
    );
  }

  String getWeekdayName(int index) {
    const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return days[index];
  }

  String getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
