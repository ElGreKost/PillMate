import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pillmate/core/app_export.dart';
import 'package:provider/provider.dart';
import 'package:pillmate/services/medication_data_provider.dart';
import '../../widgets/custom_elevated_button.dart';
import '../pickaudio_screen/pickaudio_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class SelectMedicationTypeScreen extends StatefulWidget {
  final List<Map<String, dynamic>> medicationTypes;

  SelectMedicationTypeScreen({
    Key? key,
    this.medicationTypes = const [
      {'type': 'Pill', 'icon': FontAwesomeIcons.pills},
      {'type': 'Drink', 'icon': Ionicons.flask},
      {'type': 'Injection', 'icon': FontAwesomeIcons.syringe},
      {'type': 'Powder', 'icon': Icons.scatter_plot},
      {'type': 'Drops', 'icon': Icons.water_drop},
      {'type': 'Other', 'icon': Icons.medical_services},
    ],
  }) : super(key: key);

  @override
  _SelectMedicationTypeScreenState createState() => _SelectMedicationTypeScreenState();
}

class _SelectMedicationTypeScreenState extends State<SelectMedicationTypeScreen> {
  Map<String, dynamic>? _selectedMedicationTypeData;

  @override
  Widget build(BuildContext context) {
    final medicationProvider = Provider.of<MedicationProvider>(context);

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
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Wrap(
                  spacing: 8, // horizontal space between cards
                  runSpacing: 8, // vertical space between cards
                  children: widget.medicationTypes.map((iTypeData) {
                    bool isSelected = _selectedMedicationTypeData == iTypeData;
                    return Card(
                      color: isSelected ? appTheme.cyan900 : appTheme.grey700,
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        width: 150.h,
                        child: InkWell(
                          onTap: () => setState(() => _selectedMedicationTypeData = iTypeData),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min, // Make the column take up minimal space
                              children: [
                                Icon(
                                  iTypeData['icon'],
                                  size: 30,
                                  color: isSelected ? appTheme.teal500 : appTheme.teal100,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  iTypeData['type'],
                                  style: TextStyle(
                                    color: isSelected ? appTheme.teal100 : appTheme.grey100,
                                    fontSize: theme.textTheme.displayMedium?.fontSize,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 16),
              Visibility(
                visible: _selectedMedicationTypeData != null,
                child: CustomElevatedButton(
                  onPressed: () {
                    Provider.of<MedicationProvider>(context, listen: false)
                        .setSelectedPillType(_selectedMedicationTypeData!["type"]);
                    Provider.of<MedicationProvider>(context, listen: false)
                        .setSelectedPillIconData(_selectedMedicationTypeData!["icon"]);
                    Navigator.pushNamed(context, AppRoutes.modernSelectDay);
                  },
                  text: 'Next',
                  width: 100.h,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
