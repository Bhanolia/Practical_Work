import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manager/model/arsip%20model.dart';
import 'package:manager/model/pengumuman%20model.dart';
import 'package:url_launcher/url_launcher.dart';

int indexx;

void main() => runApp(Beranda());

class Beranda extends StatefulWidget {
  @override
  _Beranda createState() => _Beranda();
}

class _Beranda extends State<Beranda> {
  @override
  void initState() {
    loadDataPengumuman();
    loadDatapengarsipan();
    super.initState();
  }

  List data = [
    {
      "url":
          "https://www.amikompurwokerto.ac.id/images/slides/2021/_KonsepCarouselA.webp"
    },
    {
      "url":
          "https://www.amikompurwokerto.ac.id/images/slides/2021/_KonsepCarouselB.webp"
    },
    {
      "url":
          "https://www.amikompurwokerto.ac.id/images/slides/2021/_KonsepCarouselC.webp"
    },
    // {
    //   "url": "https://cdn.dribbble.com/users/3281732/screenshots/10940512/media/b2a8ea95c550e5f09d0ca07682a3c0da.jpg?compress=1&resize=600x600"
    // },
    // {
    //   "url": "https://cdn.dribbble.com/users/3281732/screenshots/8616916/media/a7e39b15640f8883212421d134013e38.jpg?compress=1&resize=600x600"
    // },
    // {
    //   "url": "https://cdn.dribbble.com/users/3281732/screenshots/6590709/samji_illustrator.jpg?compress=1&resize=600x600"
    // }
  ];

  void amikom() async {
    String url = "https://www.amikompurwokerto.ac.id/";
    print("launchingUrl: $url");
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  var urlpengumuman =
      Uri.parse('https://test-prodi.000webhostapp.com/api/pengumuman');
  var urlpengarsipan =
      Uri.parse('https://test-prodi.000webhostapp.com/api/pengarsipan');

  List<myModel> pengumuman = [];
  List<myModell> pengarsipan = [];

  void loadDataPengumuman() async {
    var response =
        await http.get(urlpengumuman, headers: {"Aceept": "application/json"});
    if (response.statusCode == 200) {
      String responeBody = response.body;
      var jsonBody = json.decode(responeBody);
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> pengumumann = map["data"];
      for (var data in pengumumann) {
        pengumuman.add(new myModel(
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
      pengumuman.forEach((someData) => print("Name : ${someData.title}"));
    } else {
      print('Something went wrong');
    }
  }

  loadDatapengarsipan() async {
    var response =
        await http.get(urlpengarsipan, headers: {"Aceept": "application/json"});
    if (response.statusCode == 200) {
      String responeBody = response.body;
      var jsonBody = json.decode(responeBody);
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> dataa = map["data"];
      for (var data in dataa) {
        pengarsipan.add(new myModell(
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
      pengarsipan.forEach((someData) => print("Name : ${someData.title}"));
    } else {
      print('Something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: <Widget>[
      Container(
        child: CarouselSlider.builder(
          itemCount: data.length,
          options: CarouselOptions(
            viewportFraction: 1,
            enlargeCenterPage: true,
            height: MediaQuery.of(context).size.height * 0.2,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            reverse: false,
            aspectRatio: 5.0,
          ),
          itemBuilder: (context, i, id) {
            //for onTap to redirect to another screen
            return GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(15),
                    // border: Border.all(color: Colors.white,)
                    ),
                //ClipRRect for image border radius
                child: ClipRRect(
                  // borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    data[i]['url'],
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              onTap: () {
                var url = data[i]['url'];
                Fluttertoast.showToast(
                  msg: "Universitas Amikom Purwokerto",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                );
                amikom();
              },
            );
          },
        ),
      ),
      Container(
        child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 20.0, bottom: 10.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Text(
                            'Pengumuman',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  )),
            ]),
      ),
      pengumuman.length == 0
          ? new Center(
              child: new CircularProgressIndicator(),
            )
          : pengumumanlist(),
      Container(
        child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 20.0, bottom: 10.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Text(
                            'Berita',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  )),
            ]),
      ),
      pengarsipan.length == 0
          ? new Center(
              child: new CircularProgressIndicator(),
            )
          : arsiplist(),
    ]));
  }

  Widget pengumumanlist() {
    return new ListView.builder(
        reverse: false,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: pengumuman == null ? 0 : 2,
        itemBuilder: (_, index) {
          return new Card(
            elevation: 5.0,
            child: new Container(
                padding: new EdgeInsets.all(12.0),
                child: ListTile(
                  title: Text(
                    pengumuman[index].title,
                    style: TextStyle(fontSize: 15),
                    maxLines: 2,
                  ),
                  subtitle: Text(pengumuman[index].date_creation),
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
                              DetailScreenPengumuman(myAllData: pengumuman),
                        ));
                  },
                )),
          );
        });
  }

  Widget arsiplist() {
    return new ListView.builder(
        reverse: false,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: pengarsipan == null ? 0 : 2,
        itemBuilder: (_, index) {
          return new Card(
            elevation: 5.0,
            child: new Container(
                padding: new EdgeInsets.all(12.0),
                child: ListTile(
                  title: Text(
                    pengarsipan[index].title,
                    style: TextStyle(fontSize: 15),
                    maxLines: 2,
                  ),
                  subtitle: Text(pengarsipan[index].date_created),
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
                              DetailScreenArip(myAllData: pengarsipan),
                        ));
                  },
                )),
          );
        });
  }
}

// second screem pengumuman
class DetailScreenPengumuman extends StatefulWidget {
  // // In the constructor, require a Todo.
  // DetailScreen ({Key key, @required this.pengumuman}) : super(key: key);
  //
  // // Declare a field that holds the Todo.
  // final Pengumuman pengumuman;

  List<myModel> myAllData = [];

  DetailScreenPengumuman({Key key, @required this.myAllData}) : super(key: key);

  @override
  _DetailScreenPengumuman createState() =>
      new _DetailScreenPengumuman(myAllData);
}

class _DetailScreenPengumuman extends State<DetailScreenPengumuman> {
  List<myModel> myAllData = [];
  int index = indexx;

  _DetailScreenPengumuman(this.myAllData);

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

class DetailScreenArip extends StatefulWidget {
  // // In the constructor, require a Todo.
  // DetailScreen ({Key key, @required this.pengumuman}) : super(key: key);
  //
  // // Declare a field that holds the Todo.
  // final Pengumuman pengumuman;

  List<myModell> myAllData = [];

  DetailScreenArip({Key key, @required this.myAllData}) : super(key: key);

  @override
  _DetailScreenArip createState() => new _DetailScreenArip(myAllData);
}

class _DetailScreenArip extends State<DetailScreenArip> {
  List<myModell> myAllData = [];

  int index = indexx;

  _DetailScreenArip(this.myAllData);

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
