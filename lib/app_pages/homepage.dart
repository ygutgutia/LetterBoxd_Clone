import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './drawerFunc.dart';
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
      drawer: new WidgetDrawer("curruser - jazzbythe", curruser.email),
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
}