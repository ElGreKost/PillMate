import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';
import 'package:pillmate/widgets/custom_elevated_button.dart';

import '../routes/app_routes.dart';
import '../theme/theme_helper.dart';

class ModernSelectDay extends StatelessWidget {
  List<DayInWeek> _days = [
    DayInWeek("Mon", dayKey: '1'),
    DayInWeek("Tue", isSelected: true, dayKey: '2'),
    DayInWeek("Wed", dayKey: '3'),
    DayInWeek("Thu", dayKey: '4'),
    DayInWeek("Fri", dayKey: '5'),
    DayInWeek("Sat", dayKey: '6'),
    DayInWeek("Sun", dayKey: '7'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Select Medication Frequency', style: theme.textTheme.titleMedium),
          backgroundColor: Colors.transparent,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: appTheme.whiteA700), onPressed: () => Navigator.pop(context))),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(onPressed: () {}, child: Text('Repeat Weekly')),
                CustomElevatedButton(
                  text: 'Next',
                  onPressed: () => Navigator.of(context).push(
                    showPicker(
                        context: context,
                        value: Time(hour: 7, minute: 32),
                        onChange: (p0) => print('changed value is $p0')),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
