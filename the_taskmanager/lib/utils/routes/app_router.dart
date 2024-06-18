import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import 'package:the_taskmanager/presentation/screens/add_task/add_task_screen.dart';
import 'package:the_taskmanager/presentation/screens/edit_task/edit_task_screen.dart';
import 'package:the_taskmanager/presentation/screens/home/home_screen.dart';
import 'package:the_taskmanager/presentation/screens/login/login_screen.dart';

import '../../presentation/screens/signup/signup_screen.dart';
import '../../presentation/screens/splash/splash_screen.dart';

class RouteName {
  static const String splashScreen = '/splash_screen';
  static const String logInScreen = '/login_screen';
  static const String homeScreen = '/home_screen';
  static const String signUpScreen = '/signup_screen';
  static const String editTaskScreen = '/edit_task_screen';
  static const String addTaskScreen = '/add_task_screen';
  // static const String adminPanelScreen = '/admin_panel_screen';
  // static const String employeeDataScreen = '/employee_data_screen';
  // static const String employeeDataEditScreen = '/employee_data_edit_screen';
}

class Routes {
  static final getPages = [
    GetPage(name: RouteName.splashScreen, page: ()=> const SplashScreen()),
    GetPage(name: RouteName.logInScreen, page: ()=> const LoginScreen()),
    GetPage(name: RouteName.signUpScreen, page: ()=> const SignUpScreen()),
    GetPage(name: RouteName.homeScreen, page: ()=>  HomeScreen()),
    GetPage(name: RouteName.editTaskScreen, page: ()=>  EditTaskScreen()),
    GetPage(name: RouteName.addTaskScreen, page: ()=>  AddTaskScreen()),

  ];
}
