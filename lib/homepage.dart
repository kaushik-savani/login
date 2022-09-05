import 'package:flutter/material.dart';
import 'package:login/loginpage.dart';
import 'package:login/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await Utils.prefs!.setBool('loggedin', false);
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return LoginPage();
                  },
                ));
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Container(
          child: Text("Welcome"),
        ),
      ),
    );
  }
}
