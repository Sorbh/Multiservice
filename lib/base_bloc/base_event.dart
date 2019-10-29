import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class BaseEvent extends Equatable {
  BaseEvent([List props = const []]) : super(props);

  @override
  String toString() => "$runtimeType";
}

class ShowSnackBarEvent extends BaseEvent {
  String error = "";
  ShowSnackBarEvent(this.error) : super([error]);
}

class ShowDialogEvent extends BaseEvent {
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
  ShowDialogEvent(
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

class PlaceHolderEvent extends BaseEvent {}

class LogoutEvent extends BaseEvent {}


