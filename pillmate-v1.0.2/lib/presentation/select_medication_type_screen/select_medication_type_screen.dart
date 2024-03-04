import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';

import '../pickaudio_screen/pickaudio_screen.dart';

class SelectMedicationTypeScreen extends StatefulWidget {
  final List<String> medicationTypes;

  SelectMedicationTypeScreen({
    Key? key,
    this.medicationTypes = const [
      'Pill',
      'Solution',
      'Injection',
      'Powder',
      'Drops',
      'Inhaler',
      'Other',
    ],
  }) : super(key: key);

  @override
  _SelectMedicationTypeScreenState createState() => _SelectMedicationTypeScreenState();
}

class _SelectMedicationTypeScreenState extends State<SelectMedicationTypeScreen> {
  String? _selectedMedicationType;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: appTheme.whiteA700), onPressed: () => Navigator.pop(context)),
          backgroundColor: Colors.transparent,
          title: Text("Select Medication Type", style: theme.textTheme.titleMedium),
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
            ...widget.medicationTypes
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
