import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pillmate/core/app_export.dart';
import 'package:pillmate/widgets/custom_text_field.dart';
import '../../services/medication_data_provider.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../pickaudio_screen/pickaudio_screen.dart';

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
            appBar: CustomAppBar(titleText: 'Which medication to add'),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                CustomTextField(
                    controller: pillNameController,
                    name: "Medication Name",
                    prefixIcon: LineIcons.pills,
                    inputType: TextInputType.text),
                CustomElevatedButton(
                    onPressed: () {
                      Provider.of<MedicationProvider>(context, listen: false)
                          .setSelectedPillName(pillNameController.text);
                      Navigator.pushNamed(context, AppRoutes.selectMedicationTypeScreen);
                    },
                    text: 'Next',
                    width: 100.h),
              ]),
            )));
  }
}
