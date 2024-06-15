import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pillmate/core/app_export.dart';
import 'package:pillmate/widgets/app_bar/appbar_title_button.dart';
import '../../services/medication.dart';
import '../../widgets/med_list_tile/tile.dart';
import '../pickaudio_screen/pickaudio_screen.dart';

Future<String?> getNameFromUserData() async {
  try {
    final Box userDataBox = await Hive.openBox('userdata');
    Map<dynamic, dynamic>? userData = userDataBox.values.first;

    if (userData != null) {
      String? name = userData['name'];
      return name;
    } else {
      print('No data available in the userdata box.');
      return null;
    }
  } catch (e) {
    print('Error retrieving name from userdata box: $e');
    return null;
  }
}

class HomescreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 49.h,
          backgroundColor: appTheme.grey900,
          foregroundColor: appTheme.grey900,
          leading: IconButton(
            onPressed: () {}
            // Navigator.pushNamed(context, AppRoutes.settingsScreen)
            ,
            icon: Icon(Icons.settings, color: appTheme.cyan500),
          ),
          centerTitle: true,
          title: AppbarTitleButton(),
          actions: [
            IconButton(
              onPressed: () => showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) =>
                    SizedBox(height: 340.h, child: AudioBottomSheet()),
              ),
              icon: Icon(Icons.campaign_outlined,
                  color: appTheme.cyan500, size: 35.h),
            )
          ],
        ),
        body: _buildMedList(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              Navigator.pushNamed(context, AppRoutes.selectPillName),
          child: Icon(Icons.add, color: Colors.white, size: 35.v),
          backgroundColor: appTheme.cyan500,
        ),
      ),
    );
  }

  Widget _buildMedList(BuildContext context) {
    return FutureBuilder<String?>(
      future: getNameFromUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          String userName = snapshot.data ?? 'User';
          // todo _getAllMedication is called 3 times for some reason. fix it
          return ValueListenableBuilder<Box>(
            valueListenable: Hive.box('medications').listenable(),
            builder: (context, box, _) {
              List<Medication> medications = _getAllMedications(box);

              DateTime? closestTime(
                  Map<String, List<TimeOfDay>> scheduledTimes) {
                DateTime now = DateTime.now();
                DateTime closestDateTime =
                    DateTime(now.year, now.month, now.day, 23, 59);
                DateTime? closestTime;

                scheduledTimes.forEach((day, times) {
                  for (var time in times) {
                    DateTime scheduledDateTime = DateTime(
                        now.year, now.month, now.day, time.hour, time.minute);
                    if (scheduledDateTime.isAfter(now) &&
                        scheduledDateTime.isBefore(closestDateTime)) {
                      closestDateTime = scheduledDateTime;
                      closestTime = scheduledDateTime;
                    }
                  }
                });

                return closestTime;
              }

              medications.sort((a, b) {
                DateTime? aClosest = closestTime(a.scheduledTimes);
                DateTime? bClosest = closestTime(b.scheduledTimes);

                if (aClosest == null && bClosest == null) return 0;
                if (aClosest == null) return 1;
                if (bClosest == null) return -1;

                return aClosest.compareTo(bClosest);
              });

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.h, vertical: 4.v),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Good Morning, \n",
                            style: CustomTextStyles.titleLargeffffffff,
                          ),
                          TextSpan(
                              text: userName,
                              style: theme.textTheme.displayMedium)
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 8),
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 40.v),
                        itemCount: medications.length,
                        itemBuilder: (context, index) =>
                            MedListTile(medication: medications[index]),
                      ),
                    ),
                    SizedBox(height: 20.v),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }

  List<Medication> _getAllMedications(Box box) {
    List<Medication> allMedications = [];

    for (var key in box.keys) {
      dynamic data = box.get(key);

      if (data is Map) {
        Map<String, List<TimeOfDay>> retrieveScheduledTimes(
            Map<dynamic, dynamic> data) {
          final dynamic scheduledTimesDynamic = data['scheduledTimes'];

          if (scheduledTimesDynamic == null) return {};

          final Map<String, dynamic> scheduledTimesMap =
              Map<String, dynamic>.from(scheduledTimesDynamic);

          return scheduledTimesMap.map((day, times) {
            return MapEntry(
              day,
              (times as List<dynamic>).map((time) {
                final timeParts = (time as String).split(':');
                return TimeOfDay(
                    hour: int.parse(timeParts[0]),
                    minute: int.parse(timeParts[1]));
              }).toList(),
            );
          });
        }

        // todo why does it get printed 3 times?
        print('data printed is: ${data['name']}');
        Medication medication = Medication(
          name: data['name'] ?? '',
          type: data['type'] ?? '',
          betweenMeals: data['betweenMeals'] ?? '',
          scheduledTimes: retrieveScheduledTimes(data),
          icon: Icons.medication,
          repeatUntil: DateTime.fromMillisecondsSinceEpoch(data['repeatUntil'] ?? null),
        );
        allMedications.add(medication);
        print('finished');
      } else {
        print(data.runtimeType);
      }
    }
    return allMedications;
  }
}
