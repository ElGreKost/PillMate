import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';
import 'package:pillmate/widgets/app_bar/appbar_title_button.dart';
import 'utils/fetch_meds.dart';
import '../pickaudio_screen/pickaudio_screen.dart';

class HomescreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 49.h,
          // backgroundColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          elevation: 1,
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
        body: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                // tileMode: TileMode.mirror,
                // center: Alignment(0.7, -0.6), // near the top right
                focal: AlignmentDirectional(1, -2),
                focalRadius: 3,
                // focal: ,
                radius: 0.2.h,
                colors: [
                  appTheme.grey900.withOpacity(1),
                  appTheme.purple100.withOpacity(0.8),
                ],
                stops: [0.5, 1.0], // Adjust stops for desired effect
              ),
            ),
            child: buildMedList(context)),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              Navigator.pushNamed(context, AppRoutes.selectPillName),
          child: Icon(Icons.add, color: Colors.white, size: 35.v),
          backgroundColor: appTheme.cyan500,
        ),
      ),
    );
  }
}
