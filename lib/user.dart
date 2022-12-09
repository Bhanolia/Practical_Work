import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:manager/model/user_model.dart';
import 'package:manager/widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

String finalemail;
void main() => runApp(new user());

class user extends StatefulWidget {
  static const String routeName = "/archive";

  @override
  _user createState() => _user();
}

class _user extends State<user> {
  List<usermodel> myAllData = [];
  List data;

  @override
  void initState() {
    Validation().whenComplete(() async {
      if (finalemail == null) {
        print(finalemail);
      } else {
        loadData(finalemail);
      }
    });
    super.initState();
  }

  Validation() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var email = sharedPreferences.getString('nidn');
    setState(() {
      finalemail = email;
    });
    print(finalemail);
  }

  loadData(nidn) async {
    var match = {'nidn': "nidn"};
    var url = Uri.parse('https://test-prodi.000webhostapp.com/api/login?');
    url =
        url.replace(queryParameters: <String, String>{'nidn': nidn.toString()});
    print(url);
    var response = await http.get(url, headers: {"Aceept": "application/json"});
    if (response.statusCode == 200) {
      String responeBody = response.body;
      var jsonBody = json.decode(responeBody);
      var aaa = jsonBody['user'];
      Map<String, dynamic> map = json.decode(response.body);
      // List dataa = jsonBody['user'];
      print(jsonBody['user']);
      // for (var data in aaa) {
      myAllData.add(new usermodel(
          aaa['nidn'],
          aaa['name'],
          aaa['pob'],
          aaa['dob'],
          aaa['address'],
          aaa['gender'],
          aaa['religion'],
          aaa['email'],
          aaa['telephone'],
          aaa['image']));
      // }
      setState(() {});
      myAllData.forEach((someData) => print("Name : ${someData.nidn}"));
    } else {
      print('Something went wrong');
    }
    for (int i = 0; i < myAllData.length; i++) {
      data = myAllData;
    }
    print(data[0]);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Profile'),
          backgroundColor: Colors.deepPurple,
        ),
        drawer: drawer(),
        body: myAllData.isEmpty
            ? new Center(
                child: new CircularProgressIndicator(),
              )
            : showMyUI());
  }

  Widget showMyUI() {
    return new Container(
      color: Colors.white,
      child: new ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              new Container(
                height: 250.0,
                color: Colors.white,
                child: new Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: new Stack(fit: StackFit.loose, children: <Widget>[
                        new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                                width: 200.0,
                                height: 200.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    image: new NetworkImage(
                                        // 'https://source.unsplash.com/1600x900/?girls'),
                                        'https://test-prodi.000webhostapp.com/assets/img/profile/${myAllData[0].image}'),
                                    fit: BoxFit.cover,
                                  ),
                                )),
                          ],
                        ),
                      ]),
                    )
                  ],
                ),
              ),
              new Container(
                color: Color(0xffFFFFFF),
                child: Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Parsonal Information',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'NIDN',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new Text(
                                  myAllData[0].nidn == null
                                      ? ""
                                      : myAllData[0].nidn,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 10.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Nama Lengkap',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new Text(
                                  myAllData[0].name == null
                                      ? ""
                                      : myAllData[0].name,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 10.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Tempat Lahir',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new Text(
                                  myAllData[0].pob == null
                                      ? ""
                                      : myAllData[0].pob,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 10.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Tanggal Lahir',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new Text(
                                  myAllData[0].dob == null
                                      ? ""
                                      : myAllData[0].dob,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 10.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Alamat',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new Text(
                                  myAllData[0].address == null
                                      ? ""
                                      : myAllData[0].address,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 10.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Jenis Kelamin',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new Text(
                                  myAllData[0].gender == null
                                      ? ""
                                      : myAllData[0].gender,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 10.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Agama',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new Text(
                                  myAllData[0].religion == null
                                      ? ""
                                      : myAllData[0].religion,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 10.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Email',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new Text(
                                  myAllData[0].email == null
                                      ? ""
                                      : myAllData[0].email,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 10.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Telepon',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0, bottom: 38.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new Text(
                                  myAllData[0].telephone == null
                                      ? ""
                                      : myAllData[0].telephone,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
