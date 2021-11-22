import 'dart:convert';

import 'package:app_auth/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SiginPage extends StatefulWidget {
  const SiginPage({Key? key}) : super(key: key);

  @override
  State<SiginPage> createState() => _SiginPageState();
}

class _SiginPageState extends State<SiginPage> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  String? username;
  String? password;

  void nextScreenReplace(context, page) async {
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => page));
  }

  void signin(u, p) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var url = Uri.parse('https://blcub.landa.id/cms/api/site/login');
    var response = await http.post(url, body: {'username': u, 'password': p});
    var data = jsonDecode(response.body);
    if (data['status_code'] == 200) {
      sp.setString('username', u);
      sp.setString('email', data['data']['user']['email']);
      sp.setString('password', p);
      sp.setBool('login', true);
      nextScreenReplace(context, MyApp());
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Error'),
          content: Text(
              'Maaf Password atau Username anda salah mohon cek lagi inputan anda!'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(
            top: 25,
            bottom: 25,
            left: 15,
            right: 15,
          ),
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter your Username',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    } else {
                      setState(() {
                        username = value;
                      });
                    }

                    return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter your Password',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your pasword';
                    } else {
                      setState(() {
                        password = value;
                      });
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        signin(username, password);
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
