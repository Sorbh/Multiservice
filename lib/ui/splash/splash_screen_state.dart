import 'package:multiservice/base_bloc/base_state.dart';

abstract class SplashScreenState extends BaseState{
  SplashScreenState([List props = const []]) : super(props);
}

class SplashScreenInitState extends SplashScreenState{
  
}

class OpenLoginScreenState extends SplashScreenState{
  
}

class OpenHomeScreenState extends SplashScreenState{
  
}