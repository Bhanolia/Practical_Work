import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:manager/login.dart' as login;
import 'package:manager/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../login.dart';

String finalemail;
String finalpass;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Validation().whenComplete(() async {
      if (finalemail == null && finalpass == null) {
        Timer(
            Duration(seconds: 5),
            () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) => Login())));
      } else {
        Loginproses(finalemail, finalpass);
      }
      // Timer(Duration(seconds: 5),() => Navigator.of(context).pushReplacement(MaterialPageRoute(
      //             builder: (BuildContext context) => Login())));
    });
    super.initState();
  }

  Future Validation() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var email = sharedPreferences.getString('nidn');
    var pass = sharedPreferences.getString('password');
    setState(() {
      finalemail = email;
      finalpass = pass;
    });
    print(finalemail);
    print(finalpass);
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
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Container(
          height: deviceHeight * 0.7,
          width: deviceWidth * 0.7,
          // margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            image: DecorationImage(
              // image: NetworkImage("https://drive.google.com/file/d/1Nu6ZL82Ax-9PCBL-kUOGr33Gh0badw-5/view"),
              image: AssetImage('assets/images/splash.png'),
              fit: BoxFit.scaleDown,
              // // child :  Container(
              //   child : Image.asset('assets/images/splash.png')
              // )
            ),
          ),
        )));
  }
}
