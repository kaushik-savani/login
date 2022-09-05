import 'package:flutter/material.dart';
import 'package:login/dbhelper.dart';
import 'package:login/homepage.dart';
import 'package:login/signuppage.dart';
import 'package:login/utils.dart';
import 'package:sqflite/sqlite_api.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Database? db;
  List<Map<String, Object?>>? l;
  String emailtext='';
  String passwordtext='';
  String logintext='';
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
    getdata();
  }

  Future<List<Map<String, Object?>>> getdata() async {
    db = await dbhelper().createdatabase();
    String qry = "select * from Test";
    List<Map<String, Object?>> l1 = await db!.rawQuery(qry);
    return l1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            l = snapshot.data as List<Map<String, Object?>>;
            if (snapshot.hasData) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        buildemailbtn(),
                        Container(
                            padding: EdgeInsets.only(left: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              emailtext,
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        buildpasswordbtn(),
                        Container(
                            padding: EdgeInsets.only(left: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              logintext,
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            )),
                        buildfrgbtn(),
                        SizedBox(height: 20,),
                        buildloginbtn(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an Account?"),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return SignUp();
                                    },
                                  ));
                                },
                                child: Text("Sign Up",
                                    style: TextStyle(color: Colors.black)))
                          ],
                        )
                      ]),
                ),
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
        future: getdata(),
      ),
    );
  }

  Widget buildemailbtn() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.black12),
      child: TextField(
        controller: email,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 20),
          hintText: "Email or Mobile No",
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget buildpasswordbtn() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.black12),
      child: TextField(
        controller: password,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 20),
          hintText: "Password",
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget buildfrgbtn() {
    return Container(alignment: Alignment.centerRight,
      child: InkWell(
          onTap: () {},
          child: Text(
            "Forgot Password?",
            style: TextStyle(color: Colors.black),
          )),
    );
  }

  Widget buildloginbtn() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.black12),
      child: TextButton(
          onPressed: () async {
            if ((l![0]['email'] == email.text ||
                    l![0]['contact'] == email.text) &&
                l![0]['password'] == password.text) {
              print("Done");
              await Utils.prefs!.setBool('loggedin', true);
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return HomePage();
                },
              ));
            }
            else{
              if(email.text.isEmpty && password.text.isNotEmpty){
                emailtext="Email or Mobile No is Required";
                logintext='';
              }
              else if(password.text.isEmpty && email.text.isNotEmpty){
                logintext="Password is Required";
                emailtext='';
              }
              else if(email.text.isEmpty && password.text.isEmpty){
                emailtext="Email or Mobile No is Required";
                logintext="Password is Required";
              }
              else{
                logintext="Invalid Email or Password";
                emailtext='';
              }
              setState(() {});
            }
          },
          child: Text(
            "LOGIN",
            style: TextStyle(color: Colors.black, fontSize: 16),
          )),
    );
  }
}
