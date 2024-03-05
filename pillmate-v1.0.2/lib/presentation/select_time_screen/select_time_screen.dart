import 'package:flutter/material.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:pillmate/widgets/custom_elevated_button.dart';

import '../../routes/app_routes.dart';
import '../../theme/theme_helper.dart';

class SelectTimeScreen extends StatelessWidget {
  var _time = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('What time will you take meds?', style: theme.textTheme.titleMedium),
          backgroundColor: Colors.transparent,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: appTheme.whiteA700), onPressed: () => Navigator.pop(context))),
      body: Center(
        child: Column(
          children: [
            TextButton(
                onPressed: () => Navigator.of(context).push(showPicker(
                    context: context,
                    value: Time(hour: 7, minute: 32),
                    onChange: (p0) => print('changed value is $p0'))),
                child: Text("Open time picker", style: TextStyle(color: appTheme.whiteA700))),
            CustomElevatedButton(text: 'Next', onPressed: () => Navigator.pushNamed(context, AppRoutes.homescreenPage))
          ],
        ),
      ),
    );
  }
}
