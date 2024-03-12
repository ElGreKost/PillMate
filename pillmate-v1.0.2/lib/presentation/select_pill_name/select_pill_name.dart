import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pillmate/core/app_export.dart';
import 'package:pillmate/widgets/custom_text_field.dart';
import '../../services/medication_data_provider.dart';
import 'package:provider/provider.dart';

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
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: appTheme.whiteA700), onPressed: () => Navigator.pop(context)),
              backgroundColor: Colors.transparent,
              title: Text("Which medication to add", style: theme.textTheme.titleMedium),
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
