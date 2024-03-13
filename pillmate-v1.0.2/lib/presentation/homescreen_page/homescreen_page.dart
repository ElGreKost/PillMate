import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pillmate/widgets/bottom_navigation_bar.dart';
import 'package:pillmate/core/app_export.dart';
import 'package:pillmate/backend/app_state.dart';
import 'package:pillmate/widgets/app_bar/appbar_title_button.dart';
import '../../services/medication.dart';
import 'widgets/med_list_tile.dart';
import '../pickaudio_screen/pickaudio_screen.dart';

class HomescreenPage extends StatelessWidget {
  const HomescreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Medication> medications = _getAllMedications();

    print('All medications:');
    medications.forEach((medication) {
      print(medication.name);
    });

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 49.h,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.settingsScreen),
            icon: Icon(Icons.settings, color: appTheme.cyan500),
          ),
          centerTitle: true,
          title: AppbarTitleButton(),
          actions: [
            IconButton(
              onPressed: () => showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) => SizedBox(height: 340.h, child: AudioBottomSheet()),
              ),
              icon: Icon(Icons.campaign_outlined, color: appTheme.cyan500, size: 35.h),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.h, vertical: 4.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Good Morning \n", style: CustomTextStyles.titleLargeffffffff),
                    TextSpan(text: "Gracy", style: theme.textTheme.displaySmall),
                  ],
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 8),
              _buildMedList(context, medications),
              SizedBox(height: 20.v),
            ],
          ),
        ),
        bottomNavigationBar: GNavWidget(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.selectPillName),
          child: Icon(Icons.add, color: Colors.white, size: 35.v),
          backgroundColor: appTheme.cyan500,
        ),
      ),
    );
  }

  List<Medication> _getAllMedications() {
    Box box = Hive.box('medications');
    List<Medication> allMedications = [];
    for (var key in box.keys) {
      dynamic data = box.get(key);
      if (data is Map<dynamic, dynamic>) {
        print('data printed is: ${data['name']}');
        Medication medication = Medication(
          name: data['name'] ?? '',
          kind: data['type'] ?? '',
          specificDays: List<String>.from(data['days'] ?? []),
          betweenMeals: data['betweenMeals'] ?? '',
          scheduledTime: data['exactTime'] != null
              ? DateTime.parse(data['exactTime'])
              : DateTime.now(),
          icon: Icons.access_alarm, // You might need to set this appropriately based on your data
        );
        allMedications.add(medication);
        print('finished');
      }
      else print(data.runtimeType);
    }
    return allMedications;
  }

  Widget _buildMedList(BuildContext context, List<Medication> medications) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 8.h, right: 21.h),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => SizedBox(height: 40.v),
          itemCount: medications.length,
          itemBuilder: (context, index) => MedListTile(medication: medications[index]),
        ),
      ),
    );
  }
}
