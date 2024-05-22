import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:the_company/presentation/login_screen/login_page.dart';
import 'package:the_company/presentation/signup_screen/signup_page.dart';
import 'package:the_company/presentation/splash_screen/splash_screen.dart';

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
          const LoginPage());
  static final Handler _unknownHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          const SignupPage());

  // static final Handler _aboutHandler = Handler(
  //     handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
  //     const AboutPage());
  //
  // static final Handler _forgotHandler = Handler(
  //     handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
  //     const ForgotPassPage());
  static final Handler _signupHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          SignupPage(
            extra: params['extra'][0],
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
