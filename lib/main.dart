import 'package:flutter/material.dart';
import 'package:login/homepage.dart';
import 'package:login/loginpage.dart';
import 'package:login/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dbhelper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Utils.prefs = await SharedPreferences.getInstance();
  runApp(MaterialApp(
    home: Utils.prefs!.getBool('loggedin') == true ? HomePage() : LoginPage(),
  ));
}

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
