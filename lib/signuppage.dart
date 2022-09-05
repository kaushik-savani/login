import 'package:flutter/material.dart';
import 'package:login/dbhelper.dart';
import 'package:login/homepage.dart';
import 'package:login/loginpage.dart';
import 'package:sqflite/sqflite.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Database? db;
  bool viewpassword = true;
  bool viewconfirm = true;
  String matcherrortext = "";
  String nametext = '';
  String emailtext = '';
  String contacttext = '';
  String passwordtext = '';
  String cpasswordtext = '';

  TextEditingController tname = TextEditingController();
  TextEditingController temail = TextEditingController();
  TextEditingController tcontact = TextEditingController();
  TextEditingController tpassword = TextEditingController();
  TextEditingController tcpassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    dbhelper().createdatabase().then((value) {
      db=value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildnamebtn(),
                Container(
                    padding: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      nametext,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    )),
                SizedBox(
                  height: 5,
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
                buildphonebtn(),
                Container(
                    padding: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      contacttext,
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
                      passwordtext,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    )),
                SizedBox(
                  height: 5,
                ),
                buildcpasswordbtn(),
                Container(
                    padding: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      cpasswordtext,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    )),
                Container(
                    alignment: Alignment.centerRight,
                    child: Text(matcherrortext)),
                SizedBox(
                  height: 20,
                ),
                buildsignupbtn(),
              ],
            ),
          )),
        ),
        onWillPop: goback);
  }

  Future<bool> goback() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return LoginPage();
      },
    ));
    return Future.value();
  }

  Widget buildnamebtn() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.black12),
      child: TextField(
        controller: tname,
        textCapitalization: TextCapitalization.words,
        keyboardType: TextInputType.name,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 14, left: 20),
          hintText: "Name",
          suffixIcon: Icon(Icons.person),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget buildemailbtn() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.black12),
      child: TextField(
        onSubmitted: (value) {
          passwordtext = value;
        },
        controller: temail,
        keyboardType: TextInputType.emailAddress,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 14, left: 20),
          hintText: "Email",
          suffixIcon: Icon(Icons.email),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget buildphonebtn() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.black12),
      child: TextField(
        controller: tcontact,
        keyboardType: TextInputType.phone,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 14, left: 20),
          hintText: "Phone Number",
          suffixIcon: Icon(Icons.call),
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
        controller: tpassword,
        obscureText: viewpassword,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 14, left: 20),
          hintText: "Password",
          suffixIcon: IconButton(
              onPressed: () {
                viewpassword = !viewpassword;
                setState(() {});
              },
              icon: viewpassword
                  ? Icon(Icons.visibility_off)
                  : Icon(Icons.visibility)),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget buildcpasswordbtn() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.black12),
      child: TextField(
        controller: tcpassword,
        obscureText: viewconfirm,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 14, left: 20),
          hintText: "Confirm Password",
          suffixIcon: IconButton(
              onPressed: () {
                viewconfirm = !viewconfirm;
                setState(() {});
              },
              icon: viewconfirm
                  ? Icon(Icons.visibility_off)
                  : Icon(Icons.visibility)),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget buildsignupbtn() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.black12),
      child: TextButton(
          onPressed: () async {
            if (tpassword.text == tcpassword.text &&
                tname.text.isNotEmpty &&
                temail.text.isNotEmpty &&
                tcontact.text.isNotEmpty &&
                tpassword.text.isNotEmpty &&
                tcpassword.text.isNotEmpty) {
              String name = tname.text;
              String email = temail.text;
              String contact = tcontact.text;
              String password = tpassword.text;
              print("okk");
              String qry =
                  "insert into Test (name,email,contact,password) values ('$name','$email','$contact','$password')";
              await db!.rawInsert(qry);

              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return LoginPage();
                },
              ));
            } else {
              if (tpassword.text != tcpassword.text &&
                  tname.text.isNotEmpty &&
                  temail.text.isNotEmpty &&
                  tcontact.text.isNotEmpty &&
                  tpassword.text.isNotEmpty &&
                  tcpassword.text.isNotEmpty) {
                nametext = '';
                emailtext = '';
                contacttext = "";
                passwordtext = "";
                cpasswordtext = '';
                matcherrortext = "Password Not Match";
              }
              if (tname.text.isEmpty) {
                nametext = "Name is Required";
              } else {
                nametext = '';
              }
              if (temail.text.isEmpty) {
                emailtext = "Email is Required";
              } else {
                emailtext = '';
              }
              if (tcontact.text.isEmpty) {
                contacttext = "Contact is Required";
              } else {
                contacttext = "";
              }
              if (tpassword.text.isEmpty) {
                passwordtext = "Password is Required";
              } else {
                passwordtext = "";
              }
              if (tcpassword.text.isEmpty) {
                cpasswordtext = "Confirm Password is Required";
              } else {
                cpasswordtext = '';
              }
              setState(() {});
            }
          },
          child: Text(
            "Sign Up",
            style: TextStyle(color: Colors.black, fontSize: 16),
          )),
    );
  }
}
