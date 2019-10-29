import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:multiservice/common_widget/common_button.dart';
import 'package:multiservice/res/app_colors.dart';
import 'package:multiservice/res/app_fonts.dart';

class GeneralDialog extends StatelessWidget {
  static Future show(BuildContext context,
      {String title,
      Widget titleWidget,
      String message,
      Widget child,
      String positiveButtonLabel,
      Function onPositiveTap,
      String negativeButtonLabel,
      Function onNegativeTap,
      bool hideCancelIcon= true,
      bool closeAfterTap= true}) async {
    return showDialog(
      context: context,
      builder: (_) => Material(
        type: MaterialType.transparency,
        child: GeneralDialog(
          title: title,
          titleWidget: titleWidget,
          message: message,
          child: child,
          positiveButtonLabel: positiveButtonLabel,
          onPositiveTap: onPositiveTap,
          negativeButtonLabel: negativeButtonLabel,
          onNegativeTap: onNegativeTap,
          hideCancelIcon: hideCancelIcon,
          closeAfterTap: closeAfterTap,
        ),
      ),
    );
  }

  String title;
  Widget titleWidget;
  String message;
  Widget child;
  Function onPositiveTap;
  String positiveButtonLabel;
  String negativeButtonLabel;
  Function onNegativeTap;
  bool hideCancelIcon;
  bool closeAfterTap;
  GeneralDialog(
      {this.title,
      this.titleWidget,
      this.message,
      this.child,
      this.positiveButtonLabel,
      this.onPositiveTap,
      this.negativeButtonLabel,
      this.onNegativeTap,
      this.hideCancelIcon = true,
      this.closeAfterTap = true})
      : assert(title != null || titleWidget != null);

  @override
  Widget build(BuildContext context) {
    // AppLocalization _appLocalization = AppLocalization.of(context);

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
      child: Container(
        color: AppColors.brownish_orange.withOpacity(.7),
//        padding: EdgeInsets.symmetric(horizontal: 18),
        child: Stack(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            !hideCancelIcon
                ? Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      iconSize: 36,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.white,
                    ),
                  )
                : Container(),
            Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    titleWidget ??
                        Text(
                          title.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: Poppins_Medium),
                        ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: AppColors.charcoal_grey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                top: 30, bottom: 30, left: 30, right: 30),
                            child: child ??
                                Text(
                                  message,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(.8),
                                      fontSize: 18,
                                      fontFamily: Poppins_Medium),
                                ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 40, right: 40, bottom: 30),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                negativeButtonLabel != null
                                    ? Expanded(
                                        child: Center(
                                          child: CommonButton(
                                            negativeButtonLabel,
                                            () {
                                              if (onNegativeTap != null) {
                                                onNegativeTap();
                                                if (closeAfterTap) {
                                                  Navigator.of(context).pop();
                                                }
                                              } else {
                                                Navigator.of(context).pop();
                                              }
                                            },
                                            width: 140,
                                          ),
                                        ),
                                      )
                                    : Container(),
                                Expanded(
                                  child: Center(
                                    child: CommonButton(
                                      positiveButtonLabel ?? "OK",
                                      () {
                                        if (onPositiveTap != null) {
                                          onPositiveTap();
                                          if (closeAfterTap) {
                                            Navigator.of(context).pop();
                                          }
                                        } else {
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      width: 140,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
