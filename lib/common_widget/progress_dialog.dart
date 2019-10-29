import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiservice/res/app_colors.dart';
import 'package:multiservice/res/app_fonts.dart';

String _dialogMessage = "Loading...";

bool _isShowing = false;

class ProgressDialog {
  _MyDialog _dialog;

  BuildContext _context;

  ProgressDialog(BuildContext context) {
    _context = context;
  }

  void setMessage(String mess) {
    _dialogMessage = mess;
    debugPrint("ProgressDialog message changed: $mess");
  }

  bool isShowing() {
    return _isShowing;
  }

  void hide() {
    _isShowing = false;
    
    Navigator.of(_context).pop();
    print('ProgressDialog dismissed');
  }

  void show() {
    _dialog = new _MyDialog();
    _isShowing = true;
    print('ProgressDialog shown');
    showDialog<dynamic>(
      context: _context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        _context = context;
        return Dialog(
            elevation: 10.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0))),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: _dialog,
            ));
      },
    );
  }
}

// ignore: must_be_immutable
class _MyDialog extends StatefulWidget {
  var _dialog = new _MyDialogState();

  update() {
    _dialog.changeState();
  }

  @override
  // ignore: must_be_immutable
  State<StatefulWidget> createState() {
    return _dialog;
  }
}

class _MyDialogState extends State<_MyDialog> {
  changeState() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _isShowing = false;
    print('ProgressDialog dismissed by back button');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Row(children: <Widget>[
      SizedBox(
        child: CircularProgressIndicator(),
      ),
      const SizedBox(width: 15.0),
      Expanded(
        child: Text(
          _dialogMessage,
          textAlign: TextAlign.justify,
          style: TextStyle(
            color: AppColors.charcoal_grey,
            fontFamily: Poppins_Medium,
            fontSize: 16,
          ),
        ),
      ),
    ]));
  }
}

//class MessageBox {
//
//  BuildContext buildContext;
//  String message = " ", title = " ";
//
//  MessageBox(this.buildContext, this.message, this.title);
//
//  void show() {
//    _showDialog();
//  }
//
//  Future _showDialog() {
//    showDialog(
//      context: buildContext,
//      barrierDismissible: false,
//      builder: (BuildContext context) {
//        return CupertinoAlertDialog(
//          title: Text('$title'),
//          actions: <Widget>[
//            FlatButton(
//              child: Text('Ok'),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            )
//          ],
//          content: SizedBox(
//            height: 45.0,
//            child: Center(
//              child: Row(
//                children: <Widget>[
//                  SizedBox(width: 10.0),
//                  Expanded(
//                    child: Text(
//                      message,
//                      textAlign: TextAlign.center,
//                      style: TextStyle(color: Colors.black, fontSize: 18.0),
//                    ),
//                  ),
//                  SizedBox(width: 10.0),
//                ],
//              ),
//            ),
//          ),
//        );
//      },
//    );
//    return null;
//  }
//}
