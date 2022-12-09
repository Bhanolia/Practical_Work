import 'package:flutter/material.dart';
import 'package:manager/login.dart';
import 'package:manager/trial.dart';
import 'package:manager/widgets/banner.dart';
import 'package:manager/widgets/drawer.dart';
import 'package:manager/widgets/splash.dart';
import 'package:manager/trial.dart' as trial;
import './announcement.dart' as announce;
import './user.dart' as user;
import './archive.dart' as archive;
import './login.dart' as login;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    debugShowMaterialGrid: false,
    title: 'manager',
    initialRoute: '/',
    routes: {
      '/': (Contex) => SplashScreen(),
      // '/' : (Contex) => Login(),
      // '/' : (Contex) => trial.archive(),
      announce.announcement.routeName: (Contex) => announce.announcement(),
      archive.archive.routeName: (Contex) => archive.archive(),
      user.user.routeName: (Contex) => user.user(),
    },
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      title: 'manager',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  //create controller untuk tabBar
  TabController controller;

  @override
  void initState() {
    controller = new TabController(vsync: this, length: 3);
    //tambahkan SingleTickerProviderStateMikin pada class _HomeState
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //create appBar
      appBar: new AppBar(
        //warna background
        backgroundColor: Colors.deepPurple,
        //judul
        title: new Text("manager"),
      ),
      //source code lanjutan
      //buat body untuk tab viewnya
      drawer: drawer(),
      body: Beranda(),
    );
  }
}
