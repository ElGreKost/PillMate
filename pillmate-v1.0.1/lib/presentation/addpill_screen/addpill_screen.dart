import 'package:pillmate/widgets/custom_icon_button.dart';
import 'models/addpill_model.dart';
import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';
import 'provider/addpill_provider.dart';

class AddpillScreen extends StatefulWidget {
  const AddpillScreen({Key? key}) : super(key: key);

  @override
  AddpillScreenState createState() => AddpillScreenState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AddpillProvider(), child: AddpillScreen());
  }
}

class AddpillScreenState extends State<AddpillScreen> {
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
                          horizontal: 57.h, vertical: 16.v),
                      decoration: AppDecoration.outlineBlack.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder25),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Padding(
                            padding: EdgeInsets.only(right: 1.h),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("lbl_8_00_am".tr,
                                      style: CustomTextStyles.headlineLarge30),
                                  CustomImageView(
                                      imagePath: ImageConstant.imgTrash2,
                                      height: 24.adaptSize,
                                      width: 24.adaptSize,
                                      margin: EdgeInsets.only(
                                          top: 4.v, bottom: 7.v))
                                ])),
                        SizedBox(height: 21.v),
                        CustomImageView(
                            imagePath: ImageConstant.imgContrast,
                            height: 37.v,
                            width: 42.h),
                        SizedBox(height: 11.v),
                        Text("lbl_acetaminophen".tr,
                            style: theme.textTheme.headlineLarge),
                        SizedBox(height: 6.v),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 21.h),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("lbl_1_pill".tr,
                                      style: CustomTextStyles
                                          .headlineSmallGray900),
                                  Text("lbl_before_food".tr,
                                      style:
                                          CustomTextStyles.headlineSmallGray900)
                                ])),
                        SizedBox(height: 21.v),
                        Padding(
                            padding: EdgeInsets.only(right: 1.h),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.h, vertical: 20.v),
                                      decoration: AppDecoration.outlineBlack900
                                          .copyWith(
                                              borderRadius: BorderRadiusStyle
                                                  .circleBorder29),
                                      child: Text("lbl_take".tr,
                                          style: theme.textTheme.labelLarge)),
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 14.h, vertical: 20.v),
                                      decoration: AppDecoration.outlineBlack900
                                          .copyWith(
                                              borderRadius: BorderRadiusStyle
                                                  .circleBorder29),
                                      child: Text("lbl_edit".tr,
                                          style: theme.textTheme.labelLarge))
                                ]))
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
