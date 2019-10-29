import 'package:multiservice/base_bloc/base_bloc.dart';
import 'package:multiservice/base_bloc/base_event.dart';
import 'package:multiservice/base_bloc/base_state.dart';
import 'package:multiservice/ui/login/login_screen_state.dart';

class LoginScreenBloc extends BaseBloc{
  @override
  BaseState get initialState => LoginScreenInitState();

  @override
  Stream<BaseState> mapBaseEventToBaseState(BaseEvent event) {
    return null;
  }

}