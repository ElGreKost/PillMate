import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pillmate/core/app_export.dart';
import 'package:provider/provider.dart';
import '../../services/medication_data_provider.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_field.dart';
import 'package:flutter/services.dart' show rootBundle;

class SelectPillName extends StatefulWidget {
  @override
  State<SelectPillName> createState() => _SelectPillNameState();
}


class _SelectPillNameState extends State<SelectPillName> {
  List<String> _medicationNames = [];
  bool _isValidSelection = false;

  @override
  void initState() {
    super.initState();
    loadMedicationNames();
  }

  Future<void> loadMedicationNames() async {
    String medicationNamesString =
    await rootBundle.loadString('assets/medication_names1.txt');
    setState(() {
      _medicationNames =
          medicationNamesString.split('\n').map((name) => name.trim()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(titleText: 'Select Medication'),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Autocomplete<String>(
              optionsMaxHeight: 200,
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<String>.empty();
                }
                return _medicationNames.where((String option) {
                  return option
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (String selection) {
                setState(() => _isValidSelection = true);
                debugPrint('You selected $selection');
                Provider.of<MedicationProvider>(context, listen: false)
                    .setSelectedPillName(selection);
              },
              fieldViewBuilder: (
                  BuildContext context,
                  TextEditingController fieldTextEditingController,
                  FocusNode fieldFocusNode,
                  VoidCallback onFieldSubmitted,
                  ) {
                fieldTextEditingController.addListener(() {
                  final currentText = fieldTextEditingController.text;
                  if (_medicationNames.contains(currentText)) {
                    if (!_isValidSelection) {
                      setState(() => _isValidSelection = true);
                    }
                  } else {
                    if (_isValidSelection) {
                      setState(() => _isValidSelection = false);
                    }
                  }
                });

                return CustomTextField(
                  autofocus: true,
                  controller: fieldTextEditingController,
                  focusNode: fieldFocusNode,
                  name: "Medication Name",
                  prefixIcon: LineIcons.pills,
                  inputType: TextInputType.text,
                  onChanged: (value) {},
                );
              },
              optionsViewBuilder: (BuildContext context,
                  AutocompleteOnSelected<String> onSelected,
                  Iterable<String> options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 4.0,
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                          color: appTheme.grey700,
                          borderRadius: BorderRadiusStyle.circleBorder29),
                      width: 300,
                      height: 200,
                      child: ListView.builder(
                        padding: EdgeInsets.all(10.0),
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          final String t9Medication = options.elementAt(index);
                          return ListTile(
                              title: Text(t9Medication,
                                  style: TextStyle(color: appTheme.grey100)),
                              onTap: () => onSelected(t9Medication));
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            Visibility(
              visible: _isValidSelection,
              child: CustomElevatedButton(
                onPressed: () => Navigator.pushNamed(
                    context, AppRoutes.selectMedicationTypeScreen),
                text: 'Next',
                width: 110.h,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

