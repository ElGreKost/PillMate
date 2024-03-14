import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';
import 'package:pillmate/theme/theme_helper.dart';

import '../../presentation/pickaudio_screen/pickaudio_screen.dart'; // Assuming the theme_helper contains the appTheme

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  final String titleText;
  final VoidCallback? onBackTap;

  CustomAppBar({required this.titleText, this.onBackTap});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(titleText),
      leading: IconButton(
          icon: Icon(Icons.arrow_back, color: appTheme.whiteA700), onPressed: onBackTap ?? () => Navigator.pop(context)),
        actions: [
          IconButton(
              onPressed: () => showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext context) => SizedBox(height: 340.h, child: AudioBottomSheet())),
              icon: Icon(Icons.campaign_outlined, color: appTheme.whiteA700, size: 35.h))
        ]
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight); // default AppBar height
}
