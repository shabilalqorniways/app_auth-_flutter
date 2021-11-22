import 'package:app_auth/profile.dart';
import 'package:app_auth/singin.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool? login;
  void auth() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (login == 'null' || login == false) {
      sp.setBool('login', false);
      setState(() {
        login = sp.getBool('login');
      });
    } else {
      setState(() {
        login = sp.getBool('login');
      });
    }
  }

  void initState() {
    auth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth Flutter',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: login == false ? SiginPage() : ProfilePage(),
    );
  }
}
