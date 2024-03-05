import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';

import '../pickaudio_screen/pickaudio_screen.dart';

class SelectMealTimeScreen extends StatefulWidget {
  final List<String> timeOfDay;
  final List<String> mealTime;

  SelectMealTimeScreen(
      {Key? key,
      this.timeOfDay = const ['Morning', 'Afternoon', 'Evening', 'Night'],
      this.mealTime = const ['before meal', 'after meal', 'anytime']})
      : super(key: key);

  @override
  _SelectMealTimeScreenState createState() => _SelectMealTimeScreenState();
}

class _SelectMealTimeScreenState extends State<SelectMealTimeScreen> {
  String? _selectedTimeOfDay;
  String? _selectedMealTime;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: appTheme.whiteA700), onPressed: () => Navigator.pop(context)),
          backgroundColor: Colors.transparent,
          title: Text("Medication-Meal Relation", style: theme.textTheme.titleMedium),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () => showModalBottomSheet(
                    context: context,
                    useSafeArea: false,
                    backgroundColor: Colors.transparent,
                    builder: (BuildContext context) => SizedBox(height: 340.h, child: AudioBottomSheet())),
                icon: Icon(Icons.campaign_outlined, color: appTheme.whiteA700, size: 35.h))
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListView(
                children: [
                  ...widget.mealTime
                      .map((type) => RadioListTile<String>(
                            title: Text(type, style: theme.textTheme.titleMedium),
                            value: type,
                            fillColor: MaterialStateColor.resolveWith((states) => appTheme.cyan400),
                            groupValue: _selectedMealTime,
                            onChanged: (value) => setState(() => _selectedMealTime = value),
                          ))
                      .toList(),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, AppRoutes.selectTimeScreen),
                      child: Text('Next'),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
