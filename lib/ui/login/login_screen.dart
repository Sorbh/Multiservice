import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multiservice/base_bloc/base_bloc_builder.dart';
import 'package:multiservice/base_bloc/base_bloc_listener.dart';
import 'package:multiservice/base_bloc/base_state.dart';
import 'package:multiservice/common_widget/progress_dialog.dart';
import 'package:multiservice/data/local/DbHelper.dart';
import 'package:multiservice/data/prefs/PreferencesManager.dart';
import 'package:multiservice/res/app_colors.dart';
import 'package:multiservice/res/strings.dart';
import 'package:multiservice/ui/login/login_screen_bloc.dart';
import 'package:multiservice/ui/login/login_screen_state.dart';
import 'package:package_info/package_info.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State {
  LoginScreenBloc _bloc = LoginScreenBloc();

  final focus = FocusNode();
  bool _obscurePassword = true;
  final _loginTextContoller = TextEditingController();
  final _passwordTextController = TextEditingController();

  ProgressDialog _progressDialog;
  String version = "";
  String buildNumber = "";

  @override
  void initState() {
    super.initState();

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      String appName = packageInfo.appName;
      String packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
      setState(() {});
    });
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
    if (state is LoginScreenInitState) {
      return Form(
        child: SingleChildScrollView(
          child: Container(
            height: double.maxFinite,
            decoration: new BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                ),
                Image.asset(
                  "assets/icon.png",
                  width: 160,
                  height: 160,
                  fit: BoxFit.cover,
                ),
                Text(
                  "Version No : ${version}+${buildNumber}",
                  style: TextStyle(color: Colors.green, fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
//                          child: Image(
//                              width: 160,
//                              height: 160,
//                              image: AssetImage(ProjectImages.BIC_LOGO),
//                              fit: BoxFit.contain)
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 50.0, end: 50.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(focus);
                    },
                    controller: _loginTextContoller,
                    decoration: new InputDecoration(
                      hintText: ProjectStrings.MAIL,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsetsDirectional.only(start: 50.0, end: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: TextFormField(
                          focusNode: focus,
                          onFieldSubmitted: (v) {
                            FocusScope.of(context).unfocus();
                          },
                          controller: _passwordTextController,
                          decoration: new InputDecoration(
                              hintText: ProjectStrings.PASSWORD),
                          obscureText: _obscurePassword,
                        ),
                      ),
                      IconButton(
                          icon: _obscurePassword
                              ? Icon(Icons.remove_red_eye, color: Colors.grey)
                              : Icon(Icons.remove_red_eye, color: Colors.blue),
                          onPressed: _toggle)
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(top: 50.0),
                  child: MaterialButton(
                    minWidth: 200,
                    color: AppColors.colorAccent,
                    child: Text(
                      ProjectStrings.AUTH,
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                    onPressed: _onLoginButtonPressed,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  void _toggle() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  // void goToNextScreen() {
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (context) {
  //       return HomePage();
  //     }),
  //   );
  // }

  _onLoginButtonPressed() {
    //on login clean the db first and create it again.

    SystemChannels.textInput.invokeMethod('TextInput.hide').then((_) {
      // _bloc.add(
      //   LoginButtonPressed(
      //     username: _loginTextContoller.text,
      //     password: _passwordTextController.text,
      //   ),
      // );
    });
    // TachosDatabase.get().refresh(null).then((_) {
    //   TachosDatabase.get().init().then((_) {

    //   });
    // });
  }
}
