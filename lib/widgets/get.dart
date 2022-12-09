import 'dart:convert';
import 'dart:ui';
// import 'path prov';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Pengumuman {
  int id;
  String title;
  String description;
  String date_creation;
  String uploader;
  String file_lampiran1;
  String file_lampiran2;
  String file_lampiran3;
  String file_lampiran4;
  String file_lampiran5;
  String file_lampiran6;
  String file_lampiran7;
  String file_lampiran8;
  String file_lampiran9;
  String file_lampiran10;


  Pengumuman({
    this.id,
    this.title,
    this.description,
    this.date_creation,
    this.uploader,
    this.file_lampiran1,
    this.file_lampiran2,
    this.file_lampiran3,
    this.file_lampiran4,
    this.file_lampiran5,
    this.file_lampiran6,
    this.file_lampiran7,
    this.file_lampiran8,
    this.file_lampiran9,
    this.file_lampiran10,
  });

  factory Pengumuman.fromJson(Map<String, dynamic> parsedJson){
    return Pengumuman(
      id: parsedJson['id'],
      title: parsedJson['title'],
      description: parsedJson['description'],
      date_creation: parsedJson['date_creation'],
      uploader: parsedJson['uploader'],
      file_lampiran1: parsedJson['file_lampiran1'],
      file_lampiran2: parsedJson['file_lampiran2'],
      file_lampiran3: parsedJson['file_lampiran3'],
      file_lampiran4: parsedJson['file_lampiran4'],
      file_lampiran5: parsedJson['file_lampiran5'],
      file_lampiran6: parsedJson['file_lampiran6'],
      file_lampiran7: parsedJson['file_lampiran7'],
      file_lampiran8: parsedJson['file_lampiran8'],
      file_lampiran9: parsedJson['file_lampiran9'],
      file_lampiran10: parsedJson['file_lampiran10'],
    );
  }
}
void main() async {
  var url = Uri.parse('https://test-prodi.000webhostapp.com/api/pengumuman');
  final response = await http.get(url, headers: {
    "Accept": "application/json"
  });
  // print(response.body);

  Map<String, dynamic> map = json.decode(response.body);
  List<dynamic> data = map["data"];
  var a = Pengumuman.fromJson(map).toString();
  print(data);
}