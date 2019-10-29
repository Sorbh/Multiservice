import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiservice/base_bloc/base_bloc.dart';
import 'package:multiservice/base_bloc/base_event.dart';
import 'package:multiservice/base_bloc/base_state.dart';
import 'package:multiservice/common_widget/general_dialog.dart';

class BaseBlocListener<E extends BaseEvent, S extends BaseState>
    extends BlocListenerBase with Copyable {
  /// The [Bloc] whose state will be listened to.
  /// Whenever the bloc's state changes, `listener` will be invoked.
  final Bloc<E, S> bloc;

  /// The [BlocWidgetListener] which will be called on every state change (including the `initialState`).
  /// This listener should be used for any code which needs to execute
  /// in response to a state change (`Transition`).
  /// The state will be the `nextState` for the most recent `Transition`.
//  final BlocWidgetListener<S> listener;

  /// The [Widget] which will be rendered as a descendant of the [BlocListener].
  final Widget child;

  BaseBlocListener({
    Key key,
    @required this.bloc,
    @required BlocWidgetListener<S> listener,
    this.child,
  })  : assert((bloc is BaseBloc), "Bloc should be instance of BaseBlock !!"),
        super(
            key: key,
            bloc: bloc,
            listener: (context, state) {
              listener(context, state);
              
              if (state is ShowDialogState) {
                 print("BaseBlocListener - ${state.toString()}");
                GeneralDialog.show(
                  context,
                  title: state.title,
                  titleWidget: state.titleWidget,
                  message: state.message,
                  child: state.child,
                  positiveButtonLabel: state.positiveButtonLabel,
                  onPositiveTap: state.onPositiveTap,
                  negativeButtonLabel: state.negativeButtonLabel,
                  onNegativeTap: state.onNegativeTap,
                  hideCancelIcon: state.hideCancelIcon,
                );
                (bloc as BaseBloc).dispatch(PlaceHolderEvent());
              }

              if (state is ShowSnackBarState) {
                print("BaseBlocListener - ${state.toString()}");
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    duration: Duration(seconds: 3),
                  ),
                );
                (bloc as BaseBloc).dispatch(PlaceHolderEvent());
              }

              if (state is LogoutState) {
                print("BaseBlocListener - ${state.toString()}");
                // Navigator.of(context).pushNamedAndRemoveUntil(
                //     SplashScreen.ROUTE_NAME, (route) => false);
              }

              
            });

  /// Clones the current [BlocListener] with a new child [Widget].
  /// All other values, including `key`, `bloc` and `listener` are preserved.
  /// preserved.
  @override
  BlocListener copyWith(Widget child) {
    return BlocListener(
      key: key,
      bloc: bloc,
      listener: listener,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) => child;
}

/// A mixin on `Widget` which exposes a `copyWith` method.
mixin Copyable on Widget {
  /// `copyWith` takes a child `Widget` and must create a copy of itself with the new child.
  /// All values except child (including [Key]) should be preserved.
  Widget copyWith(Widget child);
}
