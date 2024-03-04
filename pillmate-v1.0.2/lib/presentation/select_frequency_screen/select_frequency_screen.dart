import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pillmate/core/app_export.dart';

import '../pickaudio_screen/pickaudio_screen.dart';

class SelectFrequencyScreen extends StatefulWidget {
  SelectFrequencyScreen({Key? key}) : super(key: key);

  @override
  _SelectFrequencyScreenState createState() => _SelectFrequencyScreenState();
}

class _SelectFrequencyScreenState extends State<SelectFrequencyScreen> {
  String? _selectedMedicationType;
  final String _currentDay = DateFormat('EEEE').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    List<String> repeatPatterns = [
      'Daily',
      'Weekly on $_currentDay',
      'Once a Week',
      '2 days a Week',
      '3 days a Week',
      '4 days a Week',
      '5 days a Week',
      '6 days a Week',
      'Custom',
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: appTheme.whiteA700), onPressed: () => Navigator.pop(context)),
          backgroundColor: Colors.transparent,
          title: Text("Select Medication Frequency", style: theme.textTheme.titleMedium),
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
        body: ListView(
          children: [
            ...repeatPatterns
                .map((type) => RadioListTile<String>(
                      title: Text(type, style: theme.textTheme.titleMedium),
                      value: type,
                      fillColor: MaterialStateColor.resolveWith((states) => appTheme.cyan400),
                      groupValue: _selectedMedicationType,
                      onChanged: (value) => setState(() => _selectedMedicationType = value),
                    ))
                .toList(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  print('Selected medication type: $_selectedMedicationType');
                  Navigator.pushNamed(context, AppRoutes.selectFrequencyScreen);
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
