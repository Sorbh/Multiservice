import 'package:multiservice/base_bloc/base_state.dart';

abstract class HomeScreenState extends BaseState{
  HomeScreenState([List props = const []]) : super(props);
}

class HomeScreenInitState extends HomeScreenState{
  
}

class OpenLoginScreenState extends HomeScreenState{
  
}

class OpenHomeScreenState extends HomeScreenState{
  
}