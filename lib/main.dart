import 'package:assignment_alisoft/home_page.dart';
import 'package:assignment_alisoft/login_page.dart';
import 'package:flutter/material.dart';

import 'configs/size_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      title: 'Assignment Alisoft',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/login-page',
      routes: {
        '/login-page': (context) => const LoginPage(),
        '/home-page': (context) => const HomePage(),
      },
    );
  }
}
