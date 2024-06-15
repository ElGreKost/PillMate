import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pillmate/widgets/buttons/custom_elevated_button.dart';
import 'package:pillmate/core/app_export.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppbarTitleButton extends StatelessWidget {
  AppbarTitleButton({
    Key? key,
    this.margin,
    this.onTap,
  }) : super(key: key);

  EdgeInsetsGeometry? margin;
  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CustomElevatedButton(
          height: 30.v,
          width: 160.h,
          text: "BOOK APPOINTMENT",
          buttonStyle: CustomButtonStyles.fillCyan,
          buttonTextStyle: theme.textTheme.labelSmall!,
          onPressed: () async {
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isFirstVisit', true);
            print(prefs.getBool('isFirstVisit'));

            // Clear Hive box
            final Box medicationsBox = await Hive.openBox('medications');
            await medicationsBox.clear();
            print('Hive box cleared');
          },
        ),
      ),
    );
  }
}
