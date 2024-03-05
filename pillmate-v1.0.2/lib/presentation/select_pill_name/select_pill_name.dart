import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';

import '../../theme/theme_helper.dart';

class SelectPillName extends StatefulWidget {
  @override
  State<SelectPillName> createState() => _SelectPillNameState();
}

class _SelectPillNameState extends State<SelectPillName> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: appTheme.whiteA700), onPressed: () => Navigator.pop(context)),
              backgroundColor: Colors.transparent,
              title: Text('What medication do you want to add', style: theme.textTheme.titleMedium),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                TextField(
                  decoration: InputDecoration(
                    // filled: true,
                    //   fillColor: Colors.white,
                    labelText: 'Medication Name',
                    focusColor: appTheme.cyan400,
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),

                    hintStyle: TextStyle(color: appTheme.cyan400), // Adjust color to match the theme
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: appTheme.cyan400, width: 2, style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(30)), // Adjust radius to match the picture
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 18), // Adjust padding to match the picture
                  ),
                ),
                ElevatedButton(onPressed: () => Navigator.pushNamed(context, AppRoutes.selectMedicationTypeScreen), child: Text('Next'))
              ]),
            )));
  }
}
