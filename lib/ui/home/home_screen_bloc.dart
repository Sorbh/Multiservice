import 'package:multiservice/base_bloc/base_bloc.dart';
import 'package:multiservice/base_bloc/base_event.dart';
import 'package:multiservice/base_bloc/base_state.dart';
import 'package:multiservice/ui/home/home_screen_state.dart';
import 'package:multiservice/ui/splash/splash_screen_state.dart';

class HomeScreenBloc extends BaseBloc{
  @override
  BaseState get initialState => HomeScreenInitState();

  @override
  Stream<BaseState> mapBaseEventToBaseState(BaseEvent event) {
    return null;
  }

}