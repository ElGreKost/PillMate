import 'package:pillmate/widgets/app_bar/custom_app_bar.dart';
import 'package:pillmate/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:pillmate/widgets/app_bar/appbar_title_button.dart';
import 'package:pillmate/widgets/app_bar/appbar_trailing_image.dart';
import 'widgets/eventlist_item_widget.dart';
import 'package:pillmate/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';

class HomescreenPage extends StatelessWidget {
  const HomescreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 32.h, vertical: 4.v),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 18.v),
                      SizedBox(
                          width: 126.h,
                          child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "Good Morning \n",
                                    style: CustomTextStyles.titleLargeffffffff),
                                TextSpan(
                                    text: "Gracy",
                                    style: theme.textTheme.displaySmall)
                              ]),
                              textAlign: TextAlign.left)),
                      SizedBox(height: 30.v),
                      _buildEventList(context),
                      SizedBox(height: 34.v),
                      _buildFooter(context)
                    ]))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 49.h,
        leading: AppbarLeadingIconbutton(
            margin: EdgeInsets.only(left: 21.h, top: 12.v, bottom: 12.v),
            onTap: () {
              onTapMegaphone(context);
            }),
        centerTitle: true,
        title: AppbarTitleButton(),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgUser,
              margin: EdgeInsets.fromLTRB(21.h, 16.v, 21.h, 15.v),
              onTap: () {
                onTapUser(context);
              })
        ]);
  }

  /// Section Widget
  Widget _buildEventList(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h, right: 21.h),
        child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return SizedBox(height: 49.v);
            },
            itemCount: 4,
            itemBuilder: (context, index) {
              return EventlistItemWidget();
            }));
  }

  /// Section Widget
  Widget _buildFooter(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.h),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          CustomImageView(
              imagePath: ImageConstant.imgCombinedShape,
              height: 38.v,
              width: 34.h),
          CustomIconButton(
              height: 38.adaptSize,
              width: 38.adaptSize,
              onTap: () {
                onTapBtnCombinedShape(context);
              },
              child: CustomImageView())
        ]));
  }

  /// Navigates to the iphone11ProMaxThirtyScreen when the action is triggered.
  onTapMegaphone(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.iphone11ProMaxThirtyScreen);
  }

  /// Navigates to the pickaudioScreen when the action is triggered.
  onTapUser(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.pickaudioScreen);
  }

  /// Navigates to the addmedicationScreen when the action is triggered.
  onTapBtnCombinedShape(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.addmedicationScreen);
  }
}
