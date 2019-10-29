import 'package:multiservice/base_bloc/base_bloc.dart';
import 'package:multiservice/base_bloc/base_event.dart';
import 'package:multiservice/base_bloc/base_state.dart';
import 'package:multiservice/ui/splash/splash_screen_event.dart';
import 'package:multiservice/ui/splash/splash_screen_state.dart';

class SplashScreenBloc extends BaseBloc{
  
  @override
  BaseState get initialState => SplashScreenInitState();

  @override
  Stream<BaseState> mapBaseEventToBaseState(BaseEvent event) async* {
    if(event is UserAuthEvent){
      bool isLogin = dataRepoImpl.isUserLogin();
      if(isLogin){
        yield OpenHomeScreenState();
      }else{
        yield OpenLoginScreenState();
      }
    }
  }

}