import 'package:app_auth/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var data = [];
  bool loading = true;

  void nextScreenReplace(context, page) async {
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => page));
  }

  void getData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    data.add({
      "username": sp.getString('username'),
      "password": sp.getString('password'),
      "email": sp.getString('email')
    });
    setState(() {
      loading = false;
    });
  }

  void logout() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    sp.setBool('login', false);
    nextScreenReplace(context, MyApp());
  }

  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Auth Demo'),
      ),
      body: data.isEmpty
          ? Center(
              child: Text('no data'),
            )
          : Column(
              children: [
                Text("Username :" + data[0]['username']),
                Text("Password :" + data[0]['password']),
                Text("Email :" + data[0]['email']),
                ElevatedButton(
                  onPressed: () {
                    logout();
                  },
                  child: Text('Logout'),
                ),
              ],
            ),
    );
  }
}
