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
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/med_list_tile.dart';
import 'widgets/custom_button_panel.dart';

class PlanMedicationScreen extends StatefulWidget {
  @override
  State<PlanMedicationScreen> createState() => _PlanMedicationScreenState();
}

class _PlanMedicationScreenState extends State<PlanMedicationScreen> {
  // make the provider that saves the days save them in the form of day in week maybe
  List<DayInWeek> _days = [
    DayInWeek("Mon", dayKey: '1'),
    DayInWeek("Tue", isSelected: true, dayKey: '2'),
    DayInWeek("Wed", dayKey: '3'),
    DayInWeek("Thu", dayKey: '4'),
    DayInWeek("Fri", dayKey: '5'),
    DayInWeek("Sat", dayKey: '6'),
    DayInWeek("Sun", dayKey: '7'),
  ];



  List<String> mealTimes = ['Before Meal', 'After Meal', 'Anytime'];

  int _mealTimeIndex = 2;

  TimeOfDay _time = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    Provider.of<MedicationProvider>(context, listen: false).setBetweenMeals(mealTimes[_mealTimeIndex]);
  }

  void _showTimePickerDialog() {
    Navigator.of(context).push(
      showPicker(
        context: context,
        okStyle: TextStyle(color: appTheme.grey500, fontWeight: FontWeight.bold, fontSize: 24),
        cancelStyle: TextStyle(color: appTheme.grey500, fontWeight: FontWeight.bold, fontSize: 24),
        okText: 'Set',
        blurredBackground: true,
        value: Time(hour: _time.hour, minute: _time.minute),
        onChange: (Time newTime) {
          Provider.of<MedicationProvider>(context, listen: false).setExactTime(newTime);
          setState(() => _time = TimeOfDay(hour: newTime.hour, minute: newTime.minute));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final medicationProvider = Provider.of<MedicationProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(titleText: 'Plan Your Treatment'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(alignment: Alignment.bottomLeft, child: Text('Days of Week', style: theme.textTheme.displayMedium)),
            SizedBox(height: 8),
            SelectWeekDays(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              days: _days,
              border: false,
              boxDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                gradient: LinearGradient(colors: [appTheme.grey900, appTheme.cyan900]),
              ),
              onSelect: (values) => print('selected days: $values'),
            ),
            SizedBox(height: 24.v),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    onPressed: () {},
                    child: Text('Repeat Weekly', style: TextStyle(color: appTheme.grey100)),
                  ),
                ),
                InkWell(
                  onTap: _showTimePickerDialog,
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: appTheme.grey700.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.access_time, color: appTheme.cyan900),
                        SizedBox(width: 8),
                        Text("Select Time", style: TextStyle(color: appTheme.cyan900, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 24.v),
            CustomButtonPanel(
                labels: mealTimes,
                selectedIndex: _mealTimeIndex,
                onSelected: (index) {
                  Provider.of<MedicationProvider>(context, listen: false).setBetweenMeals(mealTimes[index]);
                  setState(() => _mealTimeIndex = index);
                }),
            SizedBox(height: 24.v),
            MedListTile(
              medication: Medication(
                name: medicationProvider.selectedPillName ?? "Pill Name",
                kind: medicationProvider.selectedPillType ?? "Pill Type",
                icon: medicationProvider.selectedPillIconData ?? Icons.medication,
                // Default icon if null
                specificDays: medicationProvider.selectedDays,
                betweenMeals: medicationProvider.betweenMeals ?? "Meal Preference",
                scheduledTime: medicationProvider.exactTime ?? DateTime.now(),
              ),
            ),
            SizedBox(height: 24.v),
            Center(child: CustomElevatedButton(text: 'Launch Therapy', width: 250, onPressed: () => _onSavePressed()))
          ],
        ),
      ),
    );
  }

  Future<void> _onSavePressed() async {
    final medicationProvider = Provider.of<MedicationProvider>(context, listen: false);
    final List<String> selectedDays = _days.where((day) => day.isSelected).map((day) => day.dayName).toList();
    medicationProvider.setSelectedDays(selectedDays);
    medicationProvider.setBetweenMeals(mealTimes[_mealTimeIndex]);
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

    await medicationProvider.addMedicationToFirestore(); // Add medication to Firestore
    Navigator.pushNamed(context, AppRoutes.homescreenPage);
  }
}
