import 'package:flutter/material.dart';
import 'package:multiservice/base_bloc/base_bloc_builder.dart';
import 'package:multiservice/base_bloc/base_bloc_listener.dart';
import 'package:multiservice/base_bloc/base_state.dart';
import 'package:multiservice/data/local/DbHelper.dart';
import 'package:multiservice/data/prefs/PreferencesManager.dart';
import 'package:multiservice/ui/home/home_screen_bloc.dart';
import 'package:multiservice/ui/home/home_screen_state.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State {
  HomeScreenBloc _bloc = HomeScreenBloc();

  @override
  void initState() {
    super.initState();

    PreferencesManager.init();
    DbHelper.getDb();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseBlocListener(
        bloc: _bloc,
        listener: (context, state) {
           print("BaseBlocListener $runtimeType");
        },
        child: BaseBlocBuilder(
          bloc: _bloc,
          condition: (previousState, currentState) {
            return true;
          },
          builder: (context, state) {
             print("BaseBlocBuilder $runtimeType");
            return _getBody(state);
          },
        ),
      ),
    );
  }

  Widget _getBody(BaseState state) {
    if(state is HomeScreenInitState){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
