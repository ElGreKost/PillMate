import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pillmate/core/app_export.dart';
import 'package:provider/provider.dart';
import '../backend/app_state.dart';

// todo upon click make the transition smooth
class GNavWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Accessing the provider for navigation model
    final appState = Provider.of<AppState>(context);
    return GNav(
      rippleColor: appTheme.cyan40001,
      hoverColor: appTheme.cyan40001,
      gap: 8,
      activeColor: appTheme.whiteA700,
      iconSize: 24,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      duration: Duration(milliseconds: 400),
      tabBackgroundColor: appTheme.cyan400,
      color: Colors.white,
      tabs: [
        GButton(icon: LineIcons.home, text: 'Home'),
        GButton(icon: LineIcons.heart, text: 'Likes'),
        GButton(icon: LineIcons.search, text: 'Search'),
        GButton(icon: LineIcons.user, text: 'Profile'),
      ],
      selectedIndex: appState.navIdx,
      onTabChange: (index) {
        Provider.of<AppState>(context, listen: false).setNavigatorIndex(index, context);
      },
    );
  }
}

