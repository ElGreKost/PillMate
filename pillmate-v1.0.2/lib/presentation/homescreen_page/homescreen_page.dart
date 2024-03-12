import 'package:pillmate/widgets/app_bar/appbar_title_button.dart';
import 'package:provider/provider.dart';
import '../../backend/app_state.dart';
import '../../services/medication.dart';
import '../../widgets/bottom_navigation_bar.dart';
import '../pickaudio_screen/pickaudio_screen.dart';
import 'widgets/med_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';

class HomescreenPage extends StatelessWidget {
  const HomescreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          leadingWidth: 49.h,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.settingsScreen),
              icon: Icon(Icons.settings, color: appTheme.cyan500)),
          centerTitle: true,
          title: AppbarTitleButton(),
          actions: [
            IconButton(
                onPressed: () => showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (BuildContext context) => SizedBox(height: 340.h, child: AudioBottomSheet())),
                icon: Icon(Icons.campaign_outlined, color: appTheme.cyan500, size: 35.h))
          ]),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.h, vertical: 4.v),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            RichText(
                text: TextSpan(children: [
                  TextSpan(text: "Good Morning \n", style: CustomTextStyles.titleLargeffffffff),
                  TextSpan(text: "Gracy", style: theme.textTheme.displaySmall)
                ]),
                textAlign: TextAlign.left),
            SizedBox(height: 8),
            _buildMedList(context),
            SizedBox(height: 20.v),
          ])),
      bottomNavigationBar: GNavWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.selectPillName),
        child: Icon(Icons.add, color: Colors.white, size: 35.v),
        backgroundColor: appTheme.cyan500,
      ),
    ));
  }

  /// Section Widget
  Widget _buildMedList(BuildContext context) {

    List<Medication> medList = Provider.of<AppState>(context).medList;

    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 8.h, right: 21.h),
        child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) => SizedBox(height: 40.v),
            itemCount: medList.length,
            // make it as big as the length of the medications the user has to take
            itemBuilder: (context, index) => MedListTile(medication: medList[index])),
      ),
    );
  }
}
