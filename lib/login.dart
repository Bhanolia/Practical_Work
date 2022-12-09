import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:manager/main.dart';
import 'package:manager/widgets/drawer.dart';
import 'package:manager/widgets/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    home: Login(),
    theme: ThemeData(),
  ));
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final email = new TextEditingController();
  final password = new TextEditingController();

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  void Loginproses(nidn, password) async {
    var match = {'nidn': nidn, 'password': password};

    var url = Uri.parse('https://test-prodi.000webhostapp.com/api/login');
    // var url = Uri.parse('https://reqres.in/api/login');
// String token = 'QpwL5tke4Pnpja7X4';

    var response = await http.post(url,
        headers: {
          //   // "Accept": "application/json",
          //   HttpHeaders.contentTypeHeader: "application/json",
          //   // HttpHeaders.authorizationHeader: "Bearer $token"
          "Access-Control_Allow_Origin": "*"
        },
        body: match,
        encoding: Encoding.getByName("utf-8"));
    final respon = jsonEncode(response.statusCode);
    final encodefst = jsonEncode(response.body);
    final data = jsonDecode(encodefst);

    // var responseget = await http.post(Uri.parse('https://lalalanang.000webhostapp.com/user'));
    // final respon = jsonEncode(responseget.statusCode);
    // final encodefst = jsonEncode(responseget.body);
    // final data = jsonDecode(encodefst);

    // final rstatus = jsonDecode(response.status);
    // print('Response status: ${respon}');

    if (response.statusCode == 200) {
      if (data == '"Login As User"') {
        print('Response status: ${respon}');
        print('Response body: ${data}');
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => new MyApp()));
      } else if (data == '"Login As Super"') {
        print('Response status: ${respon}');
        print('Response body: ${data}');
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => new MyApp()));
      } else {
        print('Response status: ${respon}');
        print('Response body: ${data}');

        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => new MyApp()));
      }
    } else {
      print('Login Failed failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'logo',
      // child: CircleAvatar(
      //   backgroundColor: Colors.transparent,
      //   radius: 48.0,
      child: Image.asset('assets/images/login crop.png'),
      // ),
    );
    final emaill = TextFormField(
      controller: email,
      validator: (e) {
        if (e.isEmpty) {
          // ignore: missing_return,
          return "Please insert email";
        }
      },
      decoration: InputDecoration(
        labelText: "NIDN",
      ),
    );
    final passwordd = TextFormField(
      controller: password,
      obscureText: _secureText,
      validator: (p) {
        if (p.isEmpty) {
          // ignore: missing_return,
          return "Please insert email";
        }
      },
      decoration: InputDecoration(
        labelText: "Kata Sandi",
        suffixIcon: IconButton(
          onPressed: showHide,
          icon: Icon(_secureText ? Icons.visibility_off : Icons.visibility),
        ),
      ),
    );
    final loginButton = MaterialButton(
      onPressed: () async {
        // email.text = "0610110002";
        // password.text = "12345678";
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('nidn', email.text);
        sharedPreferences.setString('password', password.text);
        // email.text = "0610110002";
        // password.text = "12345678";

        // check();
        Loginproses(email.text, password.text);
      },
      child: Text("Masuk"),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 24.0, right: 24.0),
                children: <Widget>[
              logo,
              SizedBox(height: 48.0),
              emaill,
              SizedBox(height: 8.0),
              passwordd,
              SizedBox(height: 24.0),
              loginButton,
              // forgotLabel
            ])));
  }
}
