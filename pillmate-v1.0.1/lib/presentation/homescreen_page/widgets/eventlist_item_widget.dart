import '../models/eventlist_item_model.dart';
import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';

// ignore: must_be_immutable
class EventlistItemWidget extends StatelessWidget {
  EventlistItemWidget(
    this.eventlistItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  EventlistItemModel eventlistItemModelObj;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12.h, 6.v, 13.h, 7.v),
      decoration: AppDecoration.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            eventlistItemModelObj.time!,
            style: CustomTextStyles.headlineSmallTealA200,
          ),
          SizedBox(height: 12.v),
          Padding(
            padding: EdgeInsets.only(right: 65.h),
            child: Row(
              children: [
                CustomImageView(
                  imagePath: eventlistItemModelObj?.am,
                  height: 37.v,
                  width: 34.h,
                  margin: EdgeInsets.only(
                    top: 8.v,
                    bottom: 9.v,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 24.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          eventlistItemModelObj.acetaminophen!,
                          style: CustomTextStyles.headlineSmallBold,
                        ),
                        SizedBox(height: 5.v),
                        Padding(
                          padding: EdgeInsets.only(right: 15.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                eventlistItemModelObj.pillCounter!,
                                style: theme.textTheme.titleMedium,
                              ),
                              Text(
                                eventlistItemModelObj.beforeFood!,
                                style: theme.textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.v),
        ],
      ),
    );
  }
}
