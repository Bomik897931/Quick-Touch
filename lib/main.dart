import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quicktouch/home_page.dart';
import 'package:quicktouch/login_page.dart';
import 'package:quicktouch/register_page.dart';

import 'firebase_option.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    HomePage.tag: (context) => HomePage(),
    RegisterPage.tag: (context) => RegisterPage(),
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MaterialApp(
            title: 'Login',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.lightBlue,
              fontFamily: 'Nunito',
            ),
            home: LoginPage(),
            routes: routes,
          )),
    );
  }
}
