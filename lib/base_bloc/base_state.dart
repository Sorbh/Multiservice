import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class BaseState extends Equatable {
  BaseState([List props = const []]) : super(props);

  @override
  String toString() => runtimeType.toString();
}
class ShowSnackBarState extends BaseState {
  String message;
  ShowSnackBarState(this.message) : super([message]);
}

class PlaceHolderState extends BaseState {}

class ShowDialogState extends BaseState {
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
  ShowDialogState(
      {this.title,
      this.titleWidget,
      this.message,
      this.child,
      this.positiveButtonLabel,
      this.onPositiveTap,
      this.negativeButtonLabel,
      this.onNegativeTap,
      this.hideCancelIcon= true,
      this.closeAfterTap= true})
      : super([
          title,
          titleWidget,
          message,
          child,
          positiveButtonLabel,
          onPositiveTap,
          negativeButtonLabel,
          onNegativeTap,
          hideCancelIcon,
          closeAfterTap
        ]);
}

class LogoutState extends BaseState {}
