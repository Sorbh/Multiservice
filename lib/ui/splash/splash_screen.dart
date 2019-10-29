import 'package:flutter/material.dart';
import 'package:multiservice/base_bloc/base_bloc_builder.dart';
import 'package:multiservice/base_bloc/base_bloc_listener.dart';
import 'package:multiservice/base_bloc/base_state.dart';
import 'package:multiservice/data/local/DbHelper.dart';
import 'package:multiservice/data/prefs/PreferencesManager.dart';
import 'package:multiservice/ui/home/home_screen.dart';
import 'package:multiservice/ui/login/login_screen.dart';
import 'package:multiservice/ui/splash/splash_screen_bloc.dart';
import 'package:multiservice/ui/splash/splash_screen_event.dart';
import 'package:multiservice/ui/splash/splash_screen_state.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State {
  SplashScreenBloc _bloc = SplashScreenBloc();

  @override
  void initState() {
    super.initState();

    Future.wait([PreferencesManager.init(), DbHelper.getDb()]).then((_) {
      _bloc.dispatch(UserAuthEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseBlocListener(
        bloc: _bloc,
        listener: (context, state) {
          print("BaseBlocListener $runtimeType");
          if (state is OpenHomeScreenState) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) {
              return HomeScreen();
            }), (_) => false);
          }
          if (state is OpenLoginScreenState) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) {
              return LoginScreen();
            }), (_) => false);
          }
        },
        child: BaseBlocBuilder(
          bloc: _bloc,
          condition: (previousState, currentState) {
            return !(BaseBlocBuilder.isBaseState(currentState) ||
                currentState is OpenHomeScreenState ||
                currentState is OpenLoginScreenState);
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
    if (state is SplashScreenInitState) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(boxShadow: [BoxShadow(
                color: Colors.black.withOpacity(.4),
                blurRadius: 4,
                spreadRadius: 2,
              )]),
              child: Image.asset(
                "assets/icon.png",
                fit: BoxFit.contain,
                height: 200,
                width: 200,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            CircularProgressIndicator(),
          ],
        ),
      );
    }
  }
}
