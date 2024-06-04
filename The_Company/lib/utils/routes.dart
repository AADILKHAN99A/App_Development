import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../features/authentication/screens/login/login.dart';
import '../features/authentication/screens/signup/signup.dart';
import '../features/authentication/screens/splash/splash.dart';

class FRouter {
  static final router = FluroRouter();

  static final Handler _splashHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          const SplashScreen());

  // static final Handler _serverdownHandler = Handler(
  //     handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
  //     const ServerDownPage());

  // lets create for two parameters tooo...

  static final Handler _loginHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          const LoginScreen());
  static final Handler _unknownHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          const SignupScreen());

  // static final Handler _aboutHandler = Handler(
  //     handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
  //     const AboutPage());
  //
  // static final Handler _forgotHandler = Handler(
  //     handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
  //     const ForgotPassPage());
  static final Handler _signupHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          const SignupScreen(
              // extra: params['extra'][0],
              ));

  // ok its all set now .....
  // now lets have a handler for passing parameter tooo....

  static void setupRouter() {
    router.define(
      'splash',
      handler: _splashHandler,
    );
    router.define(
      'login',
      handler: _loginHandler,
      transitionType: TransitionType.fadeIn,
    );
    // router.define(
    //   'serverdown',
    //   handler: _serverdownHandler,
    //   transitionType: TransitionType.fadeIn,
    // );
    router.define(
      'signup',
      handler: _unknownHandler,
      transitionType: TransitionType.fadeIn,
    );

    // router.define(
    //   'about',
    //   handler: _aboutHandler,
    //   transitionType: TransitionType.fadeIn,
    // );
    // router.define(
    //   'forgot',
    //   handler: _forgotHandler,
    //   transitionType: TransitionType.fadeIn,
    // );
    router.define(
      'signup/:extra',
      handler: _signupHandler,
      transitionType: TransitionType.fadeIn,
    );
  }
}
