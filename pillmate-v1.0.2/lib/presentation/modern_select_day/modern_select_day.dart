import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';
import 'package:pillmate/core/utils/size_utils.dart';
import 'package:pillmate/widgets/custom_elevated_button.dart';

import '../../routes/app_routes.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/buttons_panel.dart';

class ModernSelectDay extends StatefulWidget {
  @override
  State<ModernSelectDay> createState() => _ModernSelectDayState();
}

class _ModernSelectDayState extends State<ModernSelectDay> {
  List<DayInWeek> _days = [
    DayInWeek("Mon", dayKey: '1'),
    DayInWeek("Tue", isSelected: true, dayKey: '2'),
    DayInWeek("Wed", dayKey: '3'),
    DayInWeek("Thu", dayKey: '4'),
    DayInWeek("Fri", dayKey: '5'),
    DayInWeek("Sat", dayKey: '6'),
    DayInWeek("Sun", dayKey: '7'),
  ];

  int _mealTimeIndex = 2;

  @override
  Widget build(BuildContext context) {
    var buttonsPanel = ButtonsPanel(
      onTap: (index) {
        print("Button at $index tapped");
        setState(() {
          _mealTimeIndex = index; // Update the selected index on tap
        });
      },
      currentIndex: _mealTimeIndex,
      children: [
        Text('Before\nMeal'),
        Text('After\nMeal'),
        Text('Anytime'),
      ],
      size: Size(300.h, 50.v),
      backgroundColor: Colors.blueGrey,
      selectedItemBackgroundColor: appTheme.cyan400,
      selectedTextStyle: TextStyle(color: Colors.white),
      unselectedTextStyle: TextStyle(color: appTheme.gray900),
      direction: Axis.horizontal,
      borderRadius: BorderRadius.circular(40),
    );

    return Scaffold(
      appBar: AppBar(
          title: Text('Select Medication Frequency', style: theme.textTheme.titleMedium),
          backgroundColor: Colors.transparent,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: appTheme.whiteA700), onPressed: () => Navigator.pop(context))),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectWeekDays(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              days: _days,
              border: false,
              boxDecoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: Colors.blueGrey),
              onSelect: (values) {
                print(values);
              },
            ),
            SizedBox(height: 24.v),
            buttonsPanel,
            SizedBox(height: 24.v),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(onPressed: () {}, child: Text('Repeat Weekly')),
                CustomElevatedButton(
                  text: 'Time',
                  width: 100,
                  onPressed: () => Navigator.of(context).push(showPicker(
                      context: context,
                      value: Time(hour: 7, minute: 32),
                      onChange: (p0) => print('changed value is $p0'))),
                  rightIcon: Icon(Icons.access_time_outlined, color: appTheme.gray900),
                ),
              ],
            ),
            SizedBox(height: 24.v),
            Center(
                child: CustomElevatedButton(
              text: 'Save Medication',
              width: 300,
              onPressed: () => Navigator.pushNamed(context, AppRoutes.homescreenPage),
            ))
          ],
        ),
      ),
    );
  }
}
