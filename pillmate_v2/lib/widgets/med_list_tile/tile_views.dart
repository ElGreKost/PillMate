// tile_views.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import '../../core/app_export.dart';
import '../../services/medication.dart';
import '../../services/notifications_scheduler.dart';
import 'tile_utils.dart';
import 'tile_manager.dart';

class DefaultView extends StatelessWidget {
  final Medication medication;
  final double fillRatio;
  final DateTime? scheduleTime;

  const DefaultView({Key? key, required this.medication, required this.fillRatio, required this.scheduleTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (scheduleTime == null) {
      return Visibility(visible: false, child: SizedBox()); // If no scheduled time is found within the next 12 hours, return an empty widget
    }
    return Container(
      key: ValueKey('defaultView'),
      decoration: AppDecoration.white,
      child: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: fillRatio,
                child: Container(
                  decoration: BoxDecoration(
                      color: appTheme.cyan500.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30.h)),
                ),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.h),
                child: Icon(getIconForMedicationType(medication.type),
                    size: 48.h, color: appTheme.cyan500),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.v),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(DateFormat('HH:mm').format(scheduleTime!),
                          style: TextStyle(
                              fontSize: 12.v, color: appTheme.grey100)),
                      Text(medication.name,
                          style: CustomTextStyles.headlineSmallBold),
                      SizedBox(height: 4.v),
                      Text(
                          "1 ${medication.type} \t ${medication.betweenMeals}",
                          style: theme.textTheme.titleMedium),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LongPressView extends StatelessWidget {
  final Medication medication;

  const LongPressView({Key? key, required this.medication}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tileManager = Provider.of<TileManager>(context, listen: false);
    return GestureDetector(
      onLongPress: () => tileManager.toggleLongPress(),
      child: Container(
        key: ValueKey('longPressView'),
        padding: EdgeInsets.fromLTRB(12.h, 6.v, 13.h, 7.v),
        decoration: AppDecoration.white,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 8.v),
              child: Text(medication.name,
                  style:
                  TextStyle(fontSize: 18.h, fontWeight: FontWeight.bold)),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildIconButton(Icons.check_circle, "Take", Colors.green, () {
                    NotificationUtils.cancelTodayMedicationNotifications(medication);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Medication marked as taken!', style: TextStyle(color: appTheme.whiteA700)),
                        backgroundColor: appTheme.teal500,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                    );
                  }),
                  SizedBox(width: 16.h),
                  _buildIconButton( LineIcons.medicalNotes, "Edit", Colors.blue, () => tileManager.toggleEditPress()),
                  SizedBox(width: 16.h),
                  _buildIconButton(Icons.info, "Info", Colors.amber, () {
                    searchMedication(medication.name);
                    _showMedicationInfoModal(context);
                  }),
                  SizedBox(width: 16.h),
                  _buildIconButton(Icons.delete, "Delete", Colors.red, () {
                    tileManager.deleteMedicationFromBox(medication);
                    NotificationUtils.cancelAllMedicationNotifications(medication);
                  }),
                ]),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String tooltip, Color color, VoidCallback onPressed) {
    return IconButton(
        icon: Icon(icon, size: 40.h),
        color: color,
        tooltip: tooltip,
        onPressed: onPressed);
  }

  void _showMedicationInfoModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return _buildMedicationInfo(context);
      },
    );
  }

  FutureBuilder _buildMedicationInfo(BuildContext context) {
    return FutureBuilder<String>(
      future: searchMedication(medication.name),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: Colors.cyan),
          );
        } else {
          return Container(
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.h),
                topRight: Radius.circular(20.h),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.h),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Detailed Medication Information",
                      style: TextStyle(
                        fontSize: 20.h,
                        fontWeight: FontWeight.bold,
                        color: appTheme.cyan500,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      snapshot.data ?? 'No data available',
                      style: TextStyle(fontSize: 14.h, color: appTheme.grey900),
                    ),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appTheme.cyan500,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.h),
                        ),
                      ),
                      child: Text(
                        'Close',
                        style: TextStyle(color: appTheme.whiteA700),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class ExpandedView extends StatelessWidget {
  final Medication medication;

  const ExpandedView({Key? key, required this.medication}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tileManager = Provider.of<TileManager>(context, listen: false);
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      key: ValueKey('expandedView'),
      padding: EdgeInsets.all(12.h),
      decoration: AppDecoration.white,
      height: 300.h,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.h),
                  child: Icon(getIconForMedicationType(medication.type),
                      size: 48.h, color: appTheme.cyan500),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.v),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(DateFormat('HH:mm').format(DateTime.now()),
                            style: TextStyle(fontSize: 12.v, color: Colors.grey)),
                        Text(medication.name,
                            style: CustomTextStyles.headlineSmallBold),
                        SizedBox(height: 4.v),
                        Text(
                            "1 ${medication.type} \t ${medication.betweenMeals}",
                            style: theme.textTheme.titleMedium),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                  hintText: "Write notes about this treatment..."),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    tileManager.toggleEditPress();
                  },
                  child: Text('Save'),
                ),
                TextButton(
                  onPressed: () {
                    tileManager.toggleEditPress();
                  },
                  child: Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InfoView extends StatelessWidget {
  final Medication medication;

  const InfoView({Key? key, required this.medication}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tileManager = Provider.of<TileManager>(context, listen: false);
    return GestureDetector(
      onTap: () => _showMedicationInfoModal(context),
      child: Container(
        key: ValueKey('infoView'),
        padding: EdgeInsets.all(12.h),
        decoration: BoxDecoration(
          color: appTheme.grey500,
          borderRadius: BorderRadius.circular(20.h),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Medication Information",
                    style: TextStyle(
                      fontSize: 18.h,
                      fontWeight: FontWeight.bold,
                      color: appTheme.cyan500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, size: 24.h, color: appTheme.grey500),
                  onPressed: () => tileManager.toggleInfoPress(),
                )
              ],
            ),
            Text(
              "Tap for more details",
              style: TextStyle(fontSize: 14.h, color: appTheme.grey500),
            ),
          ],
        ),
      ),
    );
  }

  void _showMedicationInfoModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return _buildMedicationInfo(context);
      },
    );
  }

  FutureBuilder _buildMedicationInfo(BuildContext context) {
    return FutureBuilder<String>(
      future: searchMedication(medication.name),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: Colors.cyan),
          );
        } else {
          return Container(
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.h),
                topRight: Radius.circular(20.h),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.h),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Detailed Medication Information",
                      style: TextStyle(
                        fontSize: 20.h,
                        fontWeight: FontWeight.bold,
                        color: appTheme.cyan500,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      snapshot.data ?? 'No data available',
                      style: TextStyle(fontSize: 14.h, color: appTheme.grey900),
                    ),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appTheme.cyan500,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.h),
                        ),
                      ),
                      child: Text(
                        'Close',
                        style: TextStyle(color: appTheme.whiteA700),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
