import 'package:flutter/material.dart';

import 'package:manager/announcement.dart' as announce;
import 'package:manager/main.dart';
import 'package:manager/user.dart' as user;
import 'package:manager/archive.dart' as archive;
import 'package:manager/login.dart' as login;
import 'package:manager/widgets/banner.dart' as banner;
import 'bug.dart' as bug;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:manager/trial.dart' as trial;

class drawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // _createHeader(),
          _createDrawerItem(
              icon: Icons.home,
              text: 'Beranda',
              onTap: () {
                Navigator.of(context).pushReplacement(
                    new MaterialPageRoute(builder: (context) => new MyApp()));
              }),
          Divider(),
          _createDrawerItem(
              icon: Icons.email,
              text: 'Pengumuman',
              onTap: () {
                Navigator.of(context).pushReplacement(new MaterialPageRoute(
                    builder: (context) => new announce.announcement()));
              }),
          _createDrawerItem(
              icon: Icons.menu_book,
              text: 'Berita',
              onTap: () {
                Navigator.of(context).pushReplacement(new MaterialPageRoute(
                    builder: (context) => new archive.archive()));
              }),
          // _createDrawerItem(icon: Icons.note, text: '',),
          Divider(),
          _createDrawerItem(
              icon: Icons.account_box_sharp,
              text: 'Profil',
              onTap: () {
                Navigator.of(context).pushReplacement(new MaterialPageRoute(
                    builder: (context) => new user.user()));
              }),
          // _createDrawerItem(icon: Icons.face, text: 'Authors'),
          // _createDrawerItem(icon: Icons.account_box, text: 'Flutter Documentation',),
          // _createDrawerItem(icon: Icons.stars, text: 'Useful Links'),

          _createDrawerItem(
              icon: Icons.exit_to_app,
              text: 'Keluar ',
              onTap: () async {
                final SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.remove('nidn');
                sharedPreferences.remove('password');
                Navigator.of(context).pushReplacement(new MaterialPageRoute(
                    builder: (context) => new login.Login()));
              }),
          Divider(),
          _createDrawerItem(
              icon: Icons.bug_report,
              text: 'Bug',
              onTap: () {
                Navigator.of(context).pushReplacement(new MaterialPageRoute(
                    builder: (context) => new bug.MyHomePage()));
              }),
          Divider(),
          ListTile(
            title: Text('Aplikasi Versi 0.0.1'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // Widget _createHeader() {
  //   return DrawerHeader(
  //       margin: EdgeInsets.zero,
  //       padding: EdgeInsets.all(10),
  //       decoration: BoxDecoration(
  //         shape : BoxShape.circle,
  //           image: DecorationImage(
  //               fit: BoxFit.fill,
  //               image: NetworkImage(
  //                 'https://himdeve.eu/wp-content/uploads/2019/04/himdeve_beach.jpg'),
  //           ),

  //       ),
  //       child: new  ,;  //     child: Stack(children: <Widget>[
  //     Positioned(
  //         bottom: 12.0,
  //         left: 16.0,
  //         child: Text("Welcome to manager",
  //             style: TextStyle(
  //                 // color: Colors.white,
  //                 fontSize: 20.0,
  //                 fontWeight: FontWeight.w500))),
  //   ]));
  //   );
  // }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
