import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pillmate/core/app_export.dart';
import 'package:pillmate/widgets/cutom_text_field.dart';

import '../../theme/theme_helper.dart';
import '../../widgets/custom_elevated_button.dart';

class SelectPillName extends StatefulWidget {
  @override
  State<SelectPillName> createState() => _SelectPillNameState();
}

class _SelectPillNameState extends State<SelectPillName> {
  var pillNameController = TextEditingController();

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
                CustomTextField(
                    controller: pillNameController,
                    name: "Medication Name",
                    prefixIcon: LineIcons.pills,
                    inputType: TextInputType.text),
                CustomElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.selectMedicationTypeScreen),
                  text: 'Next',
                  width: 100.h,
                ),
              ]),
            )));
  }
}
