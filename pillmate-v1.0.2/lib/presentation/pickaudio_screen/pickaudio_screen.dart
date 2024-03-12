import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart'; // Ensure this contains necessary imports

class AudioBottomSheet extends StatefulWidget {
  @override
  _AudioBottomSheetState createState() => _AudioBottomSheetState();
}

class _AudioBottomSheetState extends State<AudioBottomSheet> {
  bool isOn = true; // Toggle state

  @override
  Widget build(BuildContext context) {
    // Increased font size for better readability
    final textStyle = TextStyle(fontSize: 24.h, color: Colors.black, fontWeight: FontWeight.bold);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 55.h, vertical: 25.v),
      decoration: AppDecoration.outlineBlack.copyWith(borderRadius: BorderRadiusStyle.roundedBorder25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(child: Text("AUDIO", style: theme.textTheme.headlineLarge)),
          SizedBox(height: 36.v),
          // Transform.scale to make the switch larger
          Transform.scale(
            scale: 2.0, // Adjust the scale factor to make the switch larger
            child: Switch(
              value: isOn,
              onChanged: (bool value) {
                setState(() {
                  isOn = value;
                });
              },
              activeColor: appTheme.whiteA700, // Customize to match your theme
              inactiveThumbColor: appTheme.grey500, // Customize to match your theme
              inactiveTrackColor: appTheme.cyan500, // Customize to match your theme
            ),
          ),
          SizedBox(height: 37.v),
          Center(child: Text(isOn ? "Sound On" : "Sound Off", style: theme.textTheme.headlineLarge)),
          SizedBox(height: 37.v),
        ],
      ),
    );
  }
}
