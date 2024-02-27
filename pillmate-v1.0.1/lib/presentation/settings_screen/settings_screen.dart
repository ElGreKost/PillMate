import 'package:pillmate/widgets/app_bar/custom_app_bar.dart';
import 'package:pillmate/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'models/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';
import 'provider/settings_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  SettingsScreenState createState() => SettingsScreenState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => SettingsProvider(), child: SettingsScreen());
  }
}

class SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 48.h, vertical: 21.v),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: 173.h,
                          margin: EdgeInsets.only(left: 15.h),
                          child: Text("msg_profile_measur".tr,
                              maxLines: 15,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium)),
                      SizedBox(height: 15.v),
                      Divider(color: appTheme.cyan40001.withOpacity(0.32)),
                      SizedBox(height: 23.v),
                      Container(
                          width: 141.h,
                          margin: EdgeInsets.only(left: 15.h),
                          child: Text("msg_change_language_theme".tr,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium)),
                      SizedBox(height: 25.v),
                      Divider(color: appTheme.cyan40001.withOpacity(0.32)),
                      SizedBox(height: 22.v),
                      Padding(
                          padding: EdgeInsets.only(left: 21.h, right: 65.h),
                          child: Row(children: [
                            Padding(
                                padding: EdgeInsets.only(top: 4.v, bottom: 2.v),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomImageView(
                                          imagePath: ImageConstant.imgShare2,
                                          height: 16.adaptSize,
                                          width: 16.adaptSize,
                                          alignment: Alignment.center),
                                      SizedBox(height: 21.v),
                                      CustomImageView(
                                          imagePath: ImageConstant.imgUserPlus,
                                          height: 17.adaptSize,
                                          width: 17.adaptSize,
                                          alignment: Alignment.centerRight),
                                      SizedBox(height: 27.v),
                                      CustomImageView(
                                          imagePath:
                                              ImageConstant.imgAlignCenter,
                                          height: 18.adaptSize,
                                          width: 18.adaptSize,
                                          alignment: Alignment.center)
                                    ])),
                            Expanded(
                                child: Container(
                                    width: 194.h,
                                    margin: EdgeInsets.only(left: 20.h),
                                    child: Text(
                                        "msg_share_your_progress_invite".tr,
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                        style: theme.textTheme.titleMedium)))
                          ])),
                      SizedBox(height: 27.v),
                      Divider(color: appTheme.cyan40001.withOpacity(0.32)),
                      SizedBox(height: 27.v),
                      Container(
                          width: 110.h,
                          margin: EdgeInsets.only(left: 15.h),
                          child: Text("msg_customer_service_help".tr,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleSmall)),
                      SizedBox(height: 5.v)
                    ]))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: double.maxFinite,
        leading: AppbarLeadingIconbutton(
            imagePath: ImageConstant.imgCloseTealA200,
            margin: EdgeInsets.fromLTRB(28.h, 12.v, 354.h, 12.v),
            onTap: () {
              onTapClose(context);
            }));
  }

  /// Navigates to the iphone11ProMaxThreeScreen when the action is triggered.
  onTapClose(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.iphone11ProMaxThreeScreen,
    );
  }
}
