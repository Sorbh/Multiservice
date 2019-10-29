import 'package:multiservice/base_bloc/base_event.dart';

abstract class SplashScreenEvent extends BaseEvent{
  SplashScreenEvent([List props = const []]) : super(props);
}

class UserAuthEvent extends  SplashScreenEvent{
  
}