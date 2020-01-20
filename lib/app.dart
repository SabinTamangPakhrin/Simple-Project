import 'package:flutter/material.dart';
import './screens/login/login.dart';
import './screens/register/register.dart';
import './screens/home/home.dart';
import './screens/createpost/createpost.dart';
import './screens/comment/comment.dart';
import './screens/splash/splash.dart';
import './screens/profile/profile.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/upload': (context) => UploadScreen(),
        '/comment': (context) => CommentScreen(),
        '/profile': (context) => ProfileScreen(),
      },
    );
  }

  appTheme() {
    return ThemeData(
      primarySwatch: primaryBlack,
      accentColor: Colors.black,
      inputDecorationTheme: inputDecorationTheme(),
    );
  }

  inputDecorationTheme() {
    return InputDecorationTheme(
      contentPadding: EdgeInsets.all(8.0),
      hintStyle: TextStyle(fontSize: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            // color: Colors.red,
            ),
      ),
    );
  }

  final MaterialColor primaryBlack = MaterialColor(
    0xFF000000,
    <int, Color>{
      50: Color(0xFF000000),
      100: Color(0xFF000000),
      200: Color(0xFF000000),
      300: Color(0xFF000000),
      400: Color(0xFF000000),
      500: Color(0xFF000000),
      600: Color(0xFF000000),
      700: Color(0xFF000000),
      800: Color(0xFF000000),
      900: Color(0xFF000000),
    },
  );
}
