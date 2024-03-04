import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';
import 'package:pillmate/widgets/bottom_navigation_bar.dart';

import '../pickaudio_screen/pickaudio_screen.dart';

class SelectDayScreen extends StatefulWidget {
  final List<String> dayLabels;

  SelectDayScreen({
    Key? key,
    this.dayLabels = const [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ],
  }) : super(key: key);

  @override
  _SelectDayScreenState createState() => _SelectDayScreenState();
}

class _SelectDayScreenState extends State<SelectDayScreen> {
  // Using a Set to keep track of selected days
  final Set<String> _selectedDays = {};
  Color audiobuttonColor = appTheme.whiteA700;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: appTheme.whiteA700), onPressed: () => Navigator.pop(context)),
          backgroundColor: Colors.transparent,
          title: Text("Select Medication Days", style: theme.textTheme.titleMedium),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () => showModalBottomSheet(
                    context: context,
                    useSafeArea: false,
                    backgroundColor: Colors.transparent,
                    builder: (BuildContext context) => SizedBox(height: 340.h, child: AudioBottomSheet())),
                icon: Icon(Icons.campaign_outlined, color: audiobuttonColor, size: 35.h))
          ],
        ),
        body: ListView(
          children: [
            ...widget.dayLabels
                .map((day) => CheckboxListTile(
                    title: Text(day, style: theme.textTheme.titleMedium),
                    checkboxShape: CircleBorder(),
                    checkColor: appTheme.whiteA700,
                    side: BorderSide(color: appTheme.whiteA700),
                    activeColor: appTheme.cyan400,
                    value: _selectedDays.contains(day),
                    onChanged: (bool? value) =>
                        setState(() => value == true ? _selectedDays.add(day) : _selectedDays.remove(day))))
                .toList(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  print('Selected days: $_selectedDays');
                  Navigator.pushNamed(context, AppRoutes.selectMedicationTypeScreen);
                },
                child: Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
