import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:multiservice/base_bloc/base_bloc_builder.dart';
import 'package:multiservice/base_bloc/base_event.dart';
import 'package:multiservice/base_bloc/base_state.dart';
import 'package:multiservice/data/DataRepoImpl.dart';

abstract class BaseBloc<E extends BaseEvent, S extends BaseState>
    extends Bloc<BaseEvent, BaseState> {
  DataRepoImpl dataRepoImpl = DataRepoImpl();
  BaseEvent currentEvent;
  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (!BaseBlocBuilder.isBaseEvent(event)) {
      currentEvent = event;
    }

    if (event is ShowSnackBarEvent) {
      yield ShowSnackBarState(event.error);
    }

    if (event is PlaceHolderEvent) {
      yield PlaceHolderState();
    }

    if (event is LogoutEvent) {
      // dataRepoImpl.logout();
      yield LogoutState();
    }

    if (event is ShowDialogEvent) {
      yield ShowDialogState(
        title: event.title,
        titleWidget: event.titleWidget,
        message: event.message,
        child: event.child,
        positiveButtonLabel: event.positiveButtonLabel,
        onPositiveTap: event.onPositiveTap,
        negativeButtonLabel: event.negativeButtonLabel,
        onNegativeTap: event.onNegativeTap,
        hideCancelIcon: event.hideCancelIcon,
      );
    }
    // if (event is ShowDialogErrorEvent) {
    //   yield ShowDialogErrorState(event.error);
    // }

    yield* mapBaseEventToBaseState(event);
  }

  Stream<S> mapBaseEventToBaseState(E event);

  @override
  void onError(Object error, StackTrace stacktrace) {
    // print("mapBaseEventToBaseState Error");
    if (error is DioError) {
      errorHandler(error);
    }
    super.onError(error, stacktrace);
  }

  dispatch(BaseEvent event) {
    add(event);
  }

  errorHandler(DioError error) {
    if (error.type == DioErrorType.RESPONSE) {
      switch (error.response.statusCode) {
        case 500:
          dispatch(
            ShowDialogEvent(
              title: "Error",
              message: "${error.toString()}",
              positiveButtonLabel: "Retry",
              onPositiveTap: () {
                dispatch(currentEvent);
              },
            ),
          );
          break;
        case 401:
          dispatch(ShowDialogEvent(
              title: "Auth Error",
              message:
                  "Session Time out, you need to login again to access the app",
              positiveButtonLabel: "Login",
              onPositiveTap: () {
                // dataRepoImpl.logout();
                dispatch(LogoutEvent());
              }));
          break;
        default:
          // yield ShowDialogErrorState(error.toString());
          break;
      }
    }
    if (error.type == DioErrorType.CONNECT_TIMEOUT ||
        error.type == DioErrorType.RECEIVE_TIMEOUT ||
        error.type == DioErrorType.SEND_TIMEOUT) {
      // yield ShowDialogErrorState('Connection timeout !!');
      dispatch(ShowDialogEvent(
          title: "Connection Error",
          message: "Connect Timeout, please retry !!",
          positiveButtonLabel: "Retry",
          onPositiveTap: () {
            dispatch(currentEvent);
          }));
    }
    if (error.type == DioErrorType.DEFAULT) {
      dispatch(ShowDialogEvent(
          title: "Connection Error",
          message: error.message,
          positiveButtonLabel: "Retry",
          onPositiveTap: () {
            dispatch(currentEvent);
          }));
      // yield ShowDialogErrorState('Default Error !!');
    }
  }
}
