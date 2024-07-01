import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../core/app_export.dart';
import '../../../services/medication.dart';
import '../../../widgets/med_list_tile/tile.dart';

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

Widget buildMedList(BuildContext context) {
  return FutureBuilder<String?>(
    future: getNameFromUserData(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        String userName = snapshot.data ?? 'User';
        return ValueListenableBuilder<Box>(
          valueListenable: Hive.box('medications').listenable(),
          builder: (context, box, _) {
            List<Medication> medications = getAllMedications(box);

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

List<Medication> getAllMedications(Box box) {
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

      Medication medication = Medication(
        name: data['name'] ?? '',
        type: data['type'] ?? '',
        betweenMeals: data['betweenMeals'] ?? '',
        scheduledTimes: retrieveScheduledTimes(data),
        icon: Icons.medication,
        repeatUntil: DateTime.fromMillisecondsSinceEpoch(data['repeatUntil'] ?? null),
      );
      allMedications.add(medication);
    } else {
      print(data.runtimeType);
    }
  }
  return allMedications;
}
