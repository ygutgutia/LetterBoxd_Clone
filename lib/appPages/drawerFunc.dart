import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:letterboxd/themes.dart';
import 'package:letterboxd/apis/authentication_service.dart';


class WidgetDrawer extends StatelessWidget{

  final String username, email;
  WidgetDrawer(this.username, this.email);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: new Text(username), // Some error showing null first time
            accountEmail: new Text(email),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.grey,
              child: Text('U', style: TextStyle(color: Colors.black87))
            ),
            decoration: new BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  sideBarGradientLeft,
                  sideBarGradientRight
                ]
              ),
            ),
          ),

          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.pushNamed(context, '/profilePage');
            }
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: new Text("Watch List"),
            onTap: () {
              Navigator.pop(context);
              //LEFT
            }
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: new Text("My Reviews"),
            onTap: () {
              Navigator.pushNamed(context, '/likedmovies');
            }
          ),
          new Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: new Text("Settings"),
            onTap: () {
              Navigator.pop(context);
              //LEFT
            }
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app), //power_settings_new
            title: new Text("Logout"),
            onTap: () {
              Navigator.pop(context);
              context.read<AuthenticationService>().signOut();
              Navigator.pushReplacementNamed(context, '/loginpage');
            }
          ),
        ],
      ),
    );
  }
}