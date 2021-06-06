import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../loginPages/authentication_service.dart';

import '../themes.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  User curruser;
  @override
  void initState() {
    curruser = FirebaseAuth.instance.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBGColor,
      drawer: _drawerFunc(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Movie List'),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:',
                  style: TextStyle(color: generalTextColor),),
          ],
        ),
      ),
    );
  }

  Widget _drawerFunc(){
    return Drawer(
      child: new ListView(
        children: <Widget>[

          new UserAccountsDrawerHeader(
            accountName: new Text("curruser - jazzbythe"), // Some error showing null first time
            accountEmail: new Text(curruser.email),
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
              Navigator.pop(context);
              //LEFT
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
