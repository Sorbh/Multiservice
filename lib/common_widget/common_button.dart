import 'package:flutter/material.dart';
import 'package:multiservice/res/app_colors.dart';
import 'package:multiservice/res/app_fonts.dart';

class CommonButton extends StatelessWidget {
  String title;
  VoidCallback onTap;
  double width;
  Widget prefixWidget;
  CommonButton(this.title, this.onTap, {this.width, this.prefixWidget});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onTap,
      child: Container(
        width: this.width ?? 240,
        height: 40,
        decoration: new BoxDecoration(
          color: AppColors.brownish_orange,
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
                color: AppColors.brownish_orange.withOpacity(.4),
                offset: Offset(0, 0),
                blurRadius: 20,
                spreadRadius: 0)
          ],
        ),
        child: Container(
          alignment: AlignmentDirectional.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              prefixWidget??Container(),
              SizedBox(width: 10,),
              Text(
                title,
                style: TextStyle(
                  fontFamily: Poppins_Medium,
                  color: Colors.white,
                  fontSize: 12,
                  letterSpacing: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
