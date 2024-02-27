import 'package:pillmate/widgets/custom_icon_button.dart';
import 'package:pillmate/widgets/custom_elevated_button.dart';
import 'models/pickaudio_model.dart';
import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';
import 'provider/pickaudio_provider.dart';

class PickaudioScreen extends StatefulWidget {
  const PickaudioScreen({Key? key}) : super(key: key);

  @override
  PickaudioScreenState createState() => PickaudioScreenState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => PickaudioProvider(), child: PickaudioScreen());
  }
}

class PickaudioScreenState extends State<PickaudioScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
                width: 376.h,
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.only(right: 3.h),
                      child: CustomIconButton(
                          height: 32.adaptSize,
                          width: 32.adaptSize,
                          padding: EdgeInsets.all(2.h),
                          alignment: Alignment.centerRight,
                          onTap: () {
                            onTapBtnIconButton(context);
                          },
                          child: CustomImageView(
                              imagePath: ImageConstant.imgXCircle))),
                  SizedBox(height: 1.v),
                  Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 55.h, vertical: 25.v),
                      decoration: AppDecoration.outlineBlack.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder25),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Text("lbl_audio".tr,
                            style: theme.textTheme.headlineLarge),
                        SizedBox(height: 36.v),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 22.v),
                                  child: Text("lbl_off".tr,
                                      style:
                                          CustomTextStyles.titleMediumGray900)),
                              Expanded(
                                  child: Container(
                                      margin: EdgeInsets.only(left: 9.h),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 11.h, vertical: 4.v),
                                      decoration: AppDecoration.fillWhiteA
                                          .copyWith(
                                              borderRadius: BorderRadiusStyle
                                                  .roundedBorder33),
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(height: 1.v),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    left: 108.h),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16.h,
                                                    vertical: 17.v),
                                                decoration: AppDecoration
                                                    .outlineBlack900
                                                    .copyWith(
                                                        borderRadius:
                                                            BorderRadiusStyle
                                                                .circleBorder29),
                                                child: Text("lbl_on".tr,
                                                    style: CustomTextStyles
                                                        .titleMediumTealA200))
                                          ]))),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 9.h, top: 22.v, bottom: 22.v),
                                  child: Text("lbl_on".tr,
                                      style:
                                          CustomTextStyles.titleMediumGray900))
                            ]),
                        SizedBox(height: 37.v),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomElevatedButton(
                                  height: 33.v,
                                  width: 104.h,
                                  text: "lbl_english".tr,
                                  buttonStyle: CustomButtonStyles.fillWhiteA,
                                  buttonTextStyle:
                                      CustomTextStyles.titleMediumGray900_1),
                              CustomElevatedButton(
                                  height: 28.v,
                                  width: 48.h,
                                  text: "lbl_change".tr,
                                  margin: EdgeInsets.only(
                                      left: 12.h, top: 2.v, bottom: 2.v),
                                  buttonStyle: CustomButtonStyles.outlineBlack,
                                  buttonTextStyle: theme.textTheme.labelMedium!)
                            ]),
                        SizedBox(height: 32.v)
                      ]))
                ]))));
  }

  /// Navigates to the iphone11ProMaxThreeScreen when the action is triggered.
  onTapBtnIconButton(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.iphone11ProMaxThreeScreen,
    );
  }
}
