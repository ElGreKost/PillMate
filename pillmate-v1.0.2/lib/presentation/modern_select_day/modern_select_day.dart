import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';
import 'package:pillmate/core/utils/size_utils.dart';
import 'package:pillmate/services/medication.dart';
import 'package:pillmate/widgets/custom_elevated_button.dart';
import '../../backend/app_state.dart';
import '../../services/medication_data_provider.dart';
import 'package:provider/provider.dart';
import '../../routes/app_routes.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/buttons_panel.dart';

class ModernSelectDay extends StatefulWidget {
  @override
  State<ModernSelectDay> createState() => _ModernSelectDayState();
}

class _ModernSelectDayState extends State<ModernSelectDay> {
  // todo make the provider that saves the days save them in the form of day in week maybe
  List<DayInWeek> _days = [
    DayInWeek("Mon", dayKey: '1'),
    DayInWeek("Tue", isSelected: true, dayKey: '2'),
    DayInWeek("Wed", dayKey: '3'),
    DayInWeek("Thu", dayKey: '4'),
    DayInWeek("Fri", dayKey: '5'),
    DayInWeek("Sat", dayKey: '6'),
    DayInWeek("Sun", dayKey: '7'),
  ];

  int _mealTimeIndex = 2;

  @override
  Widget build(BuildContext context) {
    final String? selectedPillName = Provider.of<MedicationProvider>(context).selectedPillName;
    final String? selectedPillType = Provider.of<MedicationProvider>(context).selectedPillType;

    var buttonsPanel = ButtonsPanel(
      onTap: (index) => setState(() => _mealTimeIndex = index),
      currentIndex: _mealTimeIndex,
      children: [Text('Before\nMeal'), Text('After\nMeal'), Text('Anytime')],
      size: Size(300, 50),
      backgroundColor: Colors.blueGrey,
      selectedItemBackgroundColor: appTheme.cyan500,
      selectedTextStyle: TextStyle(color: Colors.white),
      unselectedTextStyle: TextStyle(color: appTheme.grey500),
      direction: Axis.horizontal,
      borderRadius: BorderRadius.circular(40),
    );

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('Select Medication Frequency', style: theme.textTheme.titleMedium),
          backgroundColor: Colors.transparent,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: appTheme.whiteA700), onPressed: () => Navigator.pop(context))),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SelectWeekDays(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              days: _days,
              border: false,
              boxDecoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: Colors.blueGrey),
              onSelect: (values) {
                print('selected days: $values');
              },
            ),
            SizedBox(height: 24.v),
            buttonsPanel,
            SizedBox(height: 24.v),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(onPressed: () {}, child: Text('Repeat Weekly')),
                CustomElevatedButton(
                  text: 'Time',
                  width: 100,
                  onPressed: () => Navigator.of(context).push(showPicker(
                      context: context,
                      value: Time(hour: 7, minute: 32),
                      onChange: (p0) => Provider.of<MedicationProvider>(context, listen: false).setExactTime(p0))),
                  rightIcon: Icon(Icons.access_time_outlined, color: appTheme.grey500),
                ),
              ],
            ),
            SizedBox(height: 24.v),
            Center(child: CustomElevatedButton(text: 'Save Medication', width: 300, onPressed: () => _onSavePressed()))
          ],
        ),
      ),
    );
  }

  Future<void> _onSavePressed() async {
    final medicationProvider = Provider.of<MedicationProvider>(context, listen: false);
    final List<String> selectedDays = _days.where((day) => day.isSelected).map((day) => day.dayName).toList();
    medicationProvider.setSelectedDays(selectedDays);
    medicationProvider.setBetweenMeals(_mealTimeIndex == 0
        ? 'Before Meal'
        : _mealTimeIndex == 1
            ? 'After Meal'
            : 'Anytime');
    final timeOfDay = medicationProvider.exactTime;
    print('Time to be taken is: $timeOfDay');

    // Add new medication to local list for homescreen
    var newMedication = Medication(
        name: medicationProvider.selectedPillName!,
        kind: medicationProvider.selectedPillType!,
        icon: medicationProvider.selectedPillIconData!,
        specificDays: medicationProvider.selectedDays,
        betweenMeals: medicationProvider.betweenMeals!,
        scheduledTime: medicationProvider.exactTime!);
    Provider.of<AppState>(context, listen: false).addMedication(newMedication);

    await medicationProvider.addMedication();
    Navigator.pushNamed(context, AppRoutes.homescreenPage);
  }
}
