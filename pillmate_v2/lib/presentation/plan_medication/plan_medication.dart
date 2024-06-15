import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';
import 'package:pillmate/core/utils/size_utils.dart';
import 'package:pillmate/services/medication.dart';
import 'package:pillmate/widgets/buttons/custom_elevated_button.dart';
import '../../services/medication_data_provider.dart';
import 'package:provider/provider.dart';
import '../../routes/app_routes.dart';
import '../../theme/theme_helper.dart';
import '../../services/notifications_scheduler.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/med_list_tile/tile.dart';
import 'widgets/custom_button_panel.dart';

class PlanMedicationScreen extends StatefulWidget {
  @override
  State<PlanMedicationScreen> createState() => _PlanMedicationScreenState();
}

class _PlanMedicationScreenState extends State<PlanMedicationScreen> {
  List<DayInWeek> _days = [
    DayInWeek("Mon", dayKey: 'Monday'),
    DayInWeek("Tue", dayKey: 'Tuesday'),
    DayInWeek("Wed", dayKey: 'Wednesday'),
    DayInWeek("Thu", dayKey: 'Thursday'),
    DayInWeek("Fri", dayKey: 'Friday'),
    DayInWeek("Sat", dayKey: 'Saturday'),
    DayInWeek("Sun", dayKey: 'Sunday'),
  ];

  List<String> mealTimes = [
    'Before Meal',
    'During Meal',
    'After Meal',
    'Anytime'
  ];

  int _mealTimeIndex = 3; // default for 'Anytime'

  TimeOfDay _time = TimeOfDay.now();
  final Map<String, List<TimeOfDay>> _scheduledTimes = {};
  DateTime? _repeatUntil;

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
            Align(
                alignment: Alignment.bottomLeft,
                child: Text('Days of Week', style: theme.textTheme.displayMedium)),
            SizedBox(height: 8),
            SelectWeekDays(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              days: _days,
              border: false,
              daysFillColor: appTheme.teal100.withOpacity(0.2),
              selectedDayTextColor: appTheme.grey100,
              unSelectedDayTextColor: appTheme.grey100,
              boxDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                gradient: LinearGradient(
                    colors: [appTheme.grey900, appTheme.cyan900]),
              ),
              onSelect: (selectedDays) {
                List<String> selectedDaysList = [];
                for (var day in selectedDays) {
                  selectedDaysList.add(day);
                }
                Provider.of<MedicationProvider>(context, listen: false)
                    .setSelectedDays(selectedDaysList);
                String? name = medicationProvider.selectedPillName;
                String? type = medicationProvider.selectedPillType;
                print('name is $name and type is: $type');
              },
            ),
            SizedBox(height: 24.v),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    onPressed: () => _showDatePicker(context),
                    child: Text('Set End Date',
                        style: TextStyle(color: appTheme.grey100)),
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
                        Text("Select Time",
                            style: TextStyle(
                                color: appTheme.cyan900,
                                fontWeight: FontWeight.bold)),
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
                  Provider.of<MedicationProvider>(context, listen: false)
                      .setBetweenMeals(mealTimes[index]);
                  setState(() => _mealTimeIndex = index);
                }),
            SizedBox(height: 24.v),
            ElevatedButton(
              onPressed: _addAnotherTime,
              child: Text('Add Another Time'),
            ),
            SizedBox(height: 24.v),
            MedListTile(
              medication: Medication(
                  name: medicationProvider.selectedPillName ?? "Pill Name",
                  type: medicationProvider.selectedPillType ?? "Pill Type",
                  icon: medicationProvider.selectedPillIconData ?? Icons.medication,
                  betweenMeals: medicationProvider.betweenMeals ?? "Meal Preference",
                  scheduledTimes: medicationProvider.scheduledTimes,
                  repeatUntil: medicationProvider.repeatUntil ?? null),
            ),
            SizedBox(height: 24.v),
            Center(
                child: CustomElevatedButton(
                    text: 'Launch Therapy',
                    width: 250,
                    onPressed: () => _onSavePressed()))
          ],
        ),
      ),
    );
  }

  void _showTimePickerDialog() {
    Navigator.of(context).push(
      showPicker(
        context: context,
        okStyle: TextStyle(
            color: appTheme.grey500, fontWeight: FontWeight.bold, fontSize: 24),
        cancelStyle: TextStyle(
            color: appTheme.grey500, fontWeight: FontWeight.bold, fontSize: 24),
        okText: 'Set',
        blurredBackground: true,
        is24HrFormat: true,
        value: Time(hour: _time.hour, minute: _time.minute),
        onChange: (Time newTime) {
          var now = DateTime.now();
          TimeOfDay timeOfDay = TimeOfDay(hour: newTime.hour, minute: newTime.minute);

          List<String> selectedDays = Provider.of<MedicationProvider>(context, listen: false).selectedDays;
          for (var day in selectedDays) {
            if (_scheduledTimes[day] == null) {
              _scheduledTimes[day] = [];
            }
            _scheduledTimes[day]!.add(timeOfDay);
            Provider.of<MedicationProvider>(context, listen: false).setScheduledTimes(day, _scheduledTimes[day]!);
          }

          setState(() => _time = TimeOfDay(hour: newTime.hour, minute: newTime.minute));
        },
      ),
    );
  }

  void _showDatePicker(BuildContext context) async {
    DateTime? pickedDate = await buildShowDatePicker(context);
    if (pickedDate != null) {
      setState(() => _repeatUntil = pickedDate);
      Provider.of<MedicationProvider>(context, listen: false).setRepeatUntil(pickedDate);
      print('');
    }
  }


  Future<DateTime?> buildShowDatePicker(BuildContext context) async {
    return await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.dark(
              primary: appTheme.grey700, // Background & activated & selected
              onPrimary: appTheme.teal500, // Activated num Color
              onSurface: appTheme.grey100, // divider line
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: appTheme.teal900, // button text color
              ),
            ),
            textTheme: TextTheme(
              titleMedium: TextStyle(color: appTheme.cyan900),
              // day number style
              labelLarge: TextStyle(color: appTheme.cyan500), // day name style
            ),
          ),
          child: child ?? Text(''),
        );
      },
    );
  }

  Future<void> _onSavePressed() async {
    final medicationProvider =
    Provider.of<MedicationProvider>(context, listen: false);
    medicationProvider.setBetweenMeals(mealTimes[_mealTimeIndex]);
    print('value from med_prov rU before saving: ${medicationProvider.repeatUntil}');

    Medication newMedication = Medication(
        name: medicationProvider.selectedPillName!,
        type: medicationProvider.selectedPillType!,
        icon: medicationProvider.selectedPillIconData!,
        betweenMeals: medicationProvider.betweenMeals!,
        scheduledTimes: medicationProvider.scheduledTimes,
        repeatUntil: medicationProvider.repeatUntil);  // Ensure repeatUntil is set here

    print('argument medication data $newMedication');  // Debug print

    NotificationUtils.scheduleMedicationNotifications(newMedication);
    newMedication.saveAndIncrementGlobalNotificationIdCounter();

    await medicationProvider.addMedication(); // Add medication to Hive
    Navigator.pushNamed(context, AppRoutes.homescreenPage);
  }


  void _addAnotherTime() {
    _showTimePickerDialog();
  }
}
