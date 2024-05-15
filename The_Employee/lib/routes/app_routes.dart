import 'package:flutter/Material.dart';
import 'package:provider/provider.dart';
import 'package:the_employee/screens/admin_login/admin_login_screen.dart';
import 'package:the_employee/screens/admin_login/provider/admin_login_provider.dart';
import 'package:the_employee/screens/admin_panel_screen/admin_panel_screen.dart';
import 'package:the_employee/screens/admin_panel_screen/provider/admin_panel_provider.dart';
import 'package:the_employee/screens/employee_data_edit_screen/employee_data_edit_screen.dart';
import 'package:the_employee/screens/employee_data_edit_screen/provider/employee_data_edit_provider.dart';
import 'package:the_employee/screens/employee_data_screen/employee_data_screen.dart';
import 'package:the_employee/screens/employee_data_screen/provider/employee_data_provider.dart';
import 'package:the_employee/screens/home_screen/provider/home_provider.dart';
import 'package:the_employee/screens/signup_screen/provider/signup_provider.dart';
import 'package:the_employee/screens/signup_screen/signup_screen.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/login_screen/login_screen.dart';
import '../screens/login_screen/provider/login_provider.dart';
import '../screens/splash_screen/splash_screen.dart';

class RouteName {
  static const String splashScreen = '/splash_screen';
  static const String logInScreen = '/login_screen';
  static const String homeScreen = '/home_screen';
  static const String signUpScreen = '/signup_screen';
  static const String adminLogInScreen = '/admin_login_screen';
  static const String adminPanelScreen = '/admin_panel_screen';
  static const String employeeDataScreen = '/employee_data_screen';
  static const String employeeDataEditScreen = '/employee_data_edit_screen';
}

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case RouteName.logInScreen:
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (BuildContext context) => LogInProvider(),
                child: const LoginScreen()));

      case RouteName.homeScreen:
        final args = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (BuildContext context) => HomeProvider(),
                  child: HomeScreen(
                    args: args,
                  ),
                ));

      case RouteName.signUpScreen:
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (BuildContext context) => SignUpProvider(),
                  child: const SignUpScreen(),
                ));

      case RouteName.adminLogInScreen:
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (BuildContext context) => AdminLoginProvider(),
                  child: const AdminLoginScreen(),
                ));

      case RouteName.employeeDataScreen:
        final args = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (BuildContext context) => EmployeeDataProvider(),
                  child: EmployeeDataScreen(args: args),
                ));

      case RouteName.adminPanelScreen:
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (BuildContext context) => AdminPanelProvider(),
                  child: const AdminPanelScreen(),
                ));

      case RouteName.employeeDataEditScreen:
        final args = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (builder) => ChangeNotifierProvider(
                  create: (BuildContext context) => EmployeeDataEditProvider(),
                  child: EmployeeDataEditScreen(
                    args: args,
                  ),
                ));

      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text(" OOps! Something went wrong."),
            ),
          );
        });
    }
  }
}
