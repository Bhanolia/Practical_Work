import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:manager/widgets/drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

import 'model/pengumuman model.dart';

int indexx;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // debugShowMaterialGrid: false,
      title: 'manager',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: announcement(),
    );
  }
}

class announcement extends StatefulWidget {
  static const String routeName = "/announcement";

  @override
  _announcement createState() => _announcement();
}

class _announcement extends State<announcement> {
  var url = Uri.parse('https://test-prodi.000webhostapp.com/api/pengumuman');

  List<myModel> myAllData = [];
  List data;

  @override
  void initState() {
    loadData();
  }

  loadData() async {
    var response = await http.get(url, headers: {"Aceept": "application/json"});
    if (response.statusCode == 200) {
      String responeBody = response.body;
      var jsonBody = json.decode(responeBody);
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> dataa = map["data"];
      for (var data in dataa) {
        myAllData.add(new myModel(
            data['id'],
            data['title'],
            data['description'],
            data['date_creation'],
            data['uploader'],
            data['file_lampiran1'],
            data['file_lampiran2'],
            data['file_lampiran3'],
            data['file_lampiran4'],
            data['file_lampiran5'],
            data['file_lampiran6'],
            data['file_lampiran7'],
            data['file_lampiran8'],
            data['file_lampiran9'],
            data['file_lampiran10']));
      }
      setState(() {});
      myAllData.forEach((someData) => print("Name : ${someData.title}"));
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
    return new MaterialApp(
        home: new Scaffold(
      appBar: new AppBar(
        title: new Text('Pengumuman'),
        backgroundColor: Colors.deepPurple,
      ),
      drawer: drawer(),
      body: myAllData.length == 0
          ? new Center(
              child: new CircularProgressIndicator(),
            )
          : showMyUI(),
    ));
  }

  Widget showMyUI() {
    return new ListView.builder(
        reverse: false,
        shrinkWrap: true,
        itemCount: myAllData == null ? 0 : myAllData.length,
        itemBuilder: (_, index) {
          return new Card(
            elevation: 5.0,
            child: new Container(
                padding: new EdgeInsets.all(12.0),
                child: ListTile(
                  title: Text(
                    myAllData[index].title,
                    style: TextStyle(fontSize: 15),
                    maxLines: 2,
                  ),
                  subtitle: Text(myAllData[index].date_creation),
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset('assets/images/login crop.png'),
                    // child: Text(
                    //     bulan[index][0], // ambil karakter pertama text
                    //     style: TextStyle(fontSize: 20)
                  ),
                  onTap: () {
                    // Navigator.push(context,MaterialPageRoute(builder: (context) => DetailScreen(data : data[index]),
                    indexx = index;
                    print(indexx);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailScreen(myAllData: myAllData),
                        ));
                  },
                )),
          );
        });
  }
}

// second screem
class DetailScreen extends StatefulWidget {
  // // In the constructor, require a Todo.
  // DetailScreen ({Key key, @required this.pengumuman}) : super(key: key);
  //
  // // Declare a field that holds the Todo.
  // final Pengumuman pengumuman;

  List<myModel> myAllData = [];

  DetailScreen({Key key, @required this.myAllData}) : super(key: key);

  @override
  _DetailScreen createState() => new _DetailScreen(myAllData);
}

class _DetailScreen extends State<DetailScreen> {
  List<myModel> myAllData = [];
  int index = indexx;

  _DetailScreen(this.myAllData);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
        appBar: AppBar(
          title: Text('Pengumuman'),
          // title: Text(myAllData[indexx].title),
          backgroundColor: Colors.deepPurple,
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${myAllData[index].title}\n',
                  style: TextStyle(color: Colors.black, fontSize: 17),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
                TextSpan(
                  text: '${myAllData[index].uploader}\n',
                  style: TextStyle(color: Colors.black54, fontSize: 15),
                ),
                TextSpan(
                  text: '${myAllData[index].date_creation}\n',
                  style: TextStyle(color: Colors.black45, fontSize: 13),
                ),
                TextSpan(
                  text: "\n",
                  style: TextStyle(color: Colors.black54, fontSize: 15),
                ),
                TextSpan(
                  text: '${myAllData[index].description}\n',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                TextSpan(
                  text: "\n",
                  style: TextStyle(color: Colors.black54, fontSize: 15),
                ),
                TextSpan(
                  text: "File Lampiran\n",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                TextSpan(
                  text:
                      '${myAllData[index].file_lampiran1 == null ? "" : myAllData[index].file_lampiran1}\n',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      String link =
                          "https://test-prodi.000webhostapp.com/pengumuman/arsip/file/${myAllData[index].file_lampiran1}";
                      print(link);
                      launch(link);
                    },
                ),
                TextSpan(
                  text:
                      '${myAllData[index].file_lampiran2 == null ? "" : myAllData[index].file_lampiran2}\n',
                  style: TextStyle(color: Colors.blue, fontSize: 13),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      String link =
                          "https://test-prodi.000webhostapp.com/pengumuman/arsip/file/${myAllData[index].file_lampiran2}";
                      print(link);
                      launch(link);
                    },
                ),
                TextSpan(
                  text:
                      '${myAllData[index].file_lampiran3 == null ? "" : myAllData[index].file_lampiran3}\n',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      String link =
                          "https://test-prodi.000webhostapp.com/pengumuman/arsip/file/${myAllData[index].file_lampiran3}";
                      print(link);
                      launch(link);
                    },
                ),
                TextSpan(
                  text:
                      '${myAllData[index].file_lampiran4 == null ? "" : myAllData[index].file_lampiran4}\n',
                  style: TextStyle(color: Colors.blue, fontSize: 13),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      String link =
                          "https://test-prodi.000webhostapp.com/pengumuman/arsip/file/${myAllData[index].file_lampiran4}";
                      print(link);
                      launch(link);
                    },
                ),
                TextSpan(
                  text:
                      '${myAllData[index].file_lampiran5 == null ? "" : myAllData[index].file_lampiran5}\n',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      String link =
                          "https://test-prodi.000webhostapp.com/pengumuman/arsip/file/${myAllData[index].file_lampiran5}";
                      print(link);
                      launch(link);
                    },
                ),
                TextSpan(
                  text:
                      '${myAllData[index].file_lampiran6 == null ? "" : myAllData[index].file_lampiran6}\n',
                  style: TextStyle(color: Colors.blue, fontSize: 13),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      String link =
                          "https://test-prodi.000webhostapp.com/pengumuman/arsip/file/${myAllData[index].file_lampiran6}";
                      print(link);
                      launch(link);
                    },
                ),
                TextSpan(
                  text:
                      '${myAllData[index].file_lampiran7 == null ? "" : myAllData[index].file_lampiran7}\n',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      String link =
                          "https://test-prodi.000webhostapp.com/pengumuman/arsip/file/${myAllData[index].file_lampiran7}";
                      print(link);
                      launch(link);
                    },
                ),
                TextSpan(
                  text:
                      '${myAllData[index].file_lampiran8 == null ? "" : myAllData[index].file_lampiran8}\n',
                  style: TextStyle(color: Colors.blue, fontSize: 13),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      String link =
                          "https://test-prodi.000webhostapp.com/pengumuman/arsip/file/${myAllData[index].file_lampiran8}";
                      print(link);
                      launch(link);
                    },
                ),
                TextSpan(
                  text:
                      '${myAllData[index].file_lampiran9 == null ? "" : myAllData[index].file_lampiran9}\n',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      String link =
                          "https://test-prodi.000webhostapp.com/pengumuman/arsip/file/${myAllData[index].file_lampiran9}";
                      print(link);
                      launch(link);
                    },
                ),
                TextSpan(
                  text:
                      '${myAllData[index].file_lampiran10 == null ? "" : myAllData[index].file_lampiran10}\n',
                  style: TextStyle(color: Colors.blue, fontSize: 13),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      String link =
                          "https://test-prodi.000webhostapp.com/pengumuman/arsip/file/${myAllData[index].file_lampiran10}";
                      print(link);
                      launch(link);
                    },
                ),
              ],
            ),
          ),
        ));
  }
}
