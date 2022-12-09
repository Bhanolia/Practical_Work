import 'dart:ui';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:manager/announcement.dart';
import 'package:manager/widgets/drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

import 'model/arsip model.dart';

int indexx;
DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

void main() => runApp(new archive());

class archive extends StatefulWidget {
  static const String routeName = "/archive";

  @override
  _archive createState() => _archive();
}

class _archive extends State<archive> {
  var url = Uri.parse('https://test-prodi.000webhostapp.com/api/pengarsipan');

  List<myModell> myAllData = [];
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
        myAllData.add(new myModell(
            data['id_file'],
            data['title'],
            data['description'],
            data['date_created'],
            data['uploader'],
            data['userfile1'],
            data['userfile2'],
            data['userfile3'],
            data['userfile4'],
            data['userfile5'],
            data['userfile6'],
            data['userfile7'],
            data['userfile8'],
            data['userfile9'],
            data['userfile10']));
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
        title: new Text('Berita'),
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
                  // subtitle: Text(dateFormat.format(myAllData[index].date_created)),
                  subtitle: Text(myAllData[index].date_created),
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

  List<myModell> myAllData = [];

  DetailScreen({Key key, @required this.myAllData}) : super(key: key);

  @override
  _DetailScreen createState() => new _DetailScreen(myAllData);
}

class _DetailScreen extends State<DetailScreen> {
  List<myModell> myAllData = [];

  int index = indexx;

  _DetailScreen(this.myAllData);

  void _requestDownload(String link) async {
    final taskId = await FlutterDownloader.enqueue(
      url: link,
      savedDir: 'the path of directory where you want to save downloaded files',
      showNotification: true,
      // show download progress in status bar (for Android)
      openFileFromNotification:
          true, // click on notification to open downloaded file (for Android)
    );
  }

  void launchUrl(urll) async {
    String url = "https://test-prodi.000webhostapp.com/";
    print("launchingUrl: $url");
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
        appBar: AppBar(
          title: Text('Berita'),
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
                  text: '${myAllData[index].date_created}\n',
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
                      '${myAllData[index].userfile1 == null ? "" : myAllData[index].userfile1} \n',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      String link =
                          "https://test-prodi.000webhostapp.com/assets/arsip/file/${myAllData[index].userfile1}";
                      print(link);
                      launch(link);
                    },
                ),
                TextSpan(
                  text:
                      '${myAllData[index].userfile2 == null ? "" : myAllData[index].userfile2}\n',
                  style: TextStyle(color: Colors.blue, fontSize: 13),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      String link =
                          "https://test-prodi.000webhostapp.com/assets/arsip/file/${myAllData[index].userfile2}";
                      print(link);
                      launch(link);
                    },
                ),
                TextSpan(
                  text:
                      '${myAllData[index].userfile3 == null ? "" : myAllData[index].userfile3}\n',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      String link =
                          "https://test-prodi.000webhostapp.com/assets/arsip/file/${myAllData[index].userfile3}";
                      print(link);
                      launch(link);
                    },
                ),
                TextSpan(
                  text:
                      '${myAllData[index].userfile4 == null ? "" : myAllData[index].userfile4}\n',
                  style: TextStyle(color: Colors.blue, fontSize: 13),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      String link =
                          "https://test-prodi.000webhostapp.com/assets/arsip/file/${myAllData[index].userfile4}";
                      print(link);
                      launch(link);
                    },
                ),
                TextSpan(
                  text:
                      '${myAllData[index].userfile5 == null ? "" : myAllData[index].userfile5}\n',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      String link =
                          "https://test-prodi.000webhostapp.com/assets/arsip/file/${myAllData[index].userfile5}";
                      print(link);
                      launch(link);
                    },
                ),
                TextSpan(
                  text:
                      '${myAllData[index].userfile6 == null ? "" : myAllData[index].userfile6}\n',
                  style: TextStyle(color: Colors.blue, fontSize: 13),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      String link =
                          "https://test-prodi.000webhostapp.com/assets/arsip/file/${myAllData[index].userfile6}";
                      print(link);
                      launch(link);
                    },
                ),
                TextSpan(
                  text:
                      '${myAllData[index].userfile7 == null ? "" : myAllData[index].userfile7}\n',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      String link =
                          "https://test-prodi.000webhostapp.com/assets/arsip/file/${myAllData[index].userfile7}";
                      print(link);
                      launch(link);
                    },
                ),
                TextSpan(
                  text:
                      '${myAllData[index].userfile8 == null ? "" : myAllData[index].userfile8}\n',
                  style: TextStyle(color: Colors.blue, fontSize: 13),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      String link =
                          "https://test-prodi.000webhostapp.com/assets/arsip/file/${myAllData[index].userfile8}";
                      print(link);
                      launch(link);
                    },
                ),
                TextSpan(
                  text:
                      '${myAllData[index].userfile9 == null ? "" : myAllData[index].userfile9}\n',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      String link =
                          "https://test-prodi.000webhostapp.com/assets/arsip/file/${myAllData[index].userfile9}";
                      print(link);
                      launch(link);
                    },
                ),
                TextSpan(
                  text:
                      '${myAllData[index].userfile10 == null ? "" : myAllData[index].userfile10}\n',
                  style: TextStyle(color: Colors.blue, fontSize: 13),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      String link =
                          "https://test-prodi.000webhostapp.com/assets/arsip/file/${myAllData[index].userfile10}";
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
