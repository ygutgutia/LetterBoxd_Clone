import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../apis/authentication_service.dart';
import '../themes.dart';

class UserProfilePage extends StatefulWidget {
  @override
  UserProfilePageState createState() => UserProfilePageState();
}

class UserProfilePageState extends State<UserProfilePage> with SingleTickerProviderStateMixin {

  Map<String, dynamic> curruser;
  bool isUserLoaded = false;
  bool _status = true;
  final TextEditingController _nameCont = TextEditingController();
  final TextEditingController _usernameCont = TextEditingController();
  final TextEditingController _dobCont = TextEditingController();
  @override
  void initState() {
    loadUser();
    super.initState();
  }

  void loadUser() async {
    curruser = await context.read<AuthenticationService>().getUserDetails();
    setState(() {
      isUserLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: appBGColor,
      appBar: AppBar(centerTitle: true, title: Text('Profile')),
      body: !isUserLoaded ? CircularProgressIndicator() : new Container(
        child: new ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                new Container(
                  height: 200.0,
                  child: new Container(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: new Stack(
                        fit: StackFit.loose,
                        children: <Widget>[
                          new Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Container(
                                width: 140.0,
                                height: 140.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    image:
                                        new ExactAssetImage("assets/images/as.jpeg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 90.0, right: 100.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 25.0,
                                  child: new Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                new Container(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 25.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Personal Information',
                                    style: TextStyle(
                                      color: formFieldTextColor,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  _status ? _getEditIcon() : new Container(),
                                ],
                              ),
                            ],
                          ),
                        ),
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
                                    'Name',
                                    style: TextStyle(
                                        color: formFieldTextColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: _status ? new Text(curruser["name"], style: TextStyle(color: hintTextColor)) : 
                                new TextFormField(
                                  controller: _nameCont,
                                  style: TextStyle(color: formFieldTextColor),
                                  decoration: const InputDecoration(
                                    hintText: 'Enter Your Name',
                                    hintStyle: TextStyle(color: hintTextColor),
                                  ),
                                  validator: (String value) {
                                    if (value.trim().isEmpty) {
                                      return 'Enter a valid name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
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
                                    'Email ID',
                                    style: TextStyle(
                                      color: formFieldTextColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new Text(curruser["email"], style: TextStyle(color: hintTextColor),)
                              ),
                            ],
                          ),
                        ),
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
                                    'Mobile',
                                    style: TextStyle(
                                      color: formFieldTextColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new Text(curruser["phNo"], style: TextStyle(color: hintTextColor),)
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: new Text(
                                    'UserName',
                                    style: TextStyle(
                                      color: formFieldTextColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                  ),
                                ),
                                flex: 2,
                              ),
                              Expanded(
                                child: Container(
                                  child: new Text(
                                    'DOB',
                                    style: TextStyle(
                                      color: formFieldTextColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                  ),
                                ),
                                flex: 2,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: _status ? new Text(curruser["username"], style: TextStyle(color: hintTextColor)) : 
                                  new TextFormField(
                                    controller: _usernameCont,
                                    style: TextStyle(color: formFieldTextColor),
                                    decoration: const InputDecoration(
                                      hintText: 'Enter Username',
                                      hintStyle: TextStyle(color: hintTextColor),
                                    ),
                                    validator: (String value) {
                                      if (value.trim().isEmpty) {
                                        return 'Enter a valid Username';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                flex: 2,
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: _status ? new Text(curruser["dob"], style: TextStyle(color: hintTextColor)) : 
                                  new TextFormField(
                                    controller: _dobCont,
                                    style: TextStyle(color: formFieldTextColor),
                                    decoration: const InputDecoration(
                                      hintText: 'Enter DOB',
                                      hintStyle: TextStyle(color: hintTextColor),
                                    ),
                                    validator: (String value) {
                                      if (value.trim().isEmpty) {
                                        return 'Enter a valid dob';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                flex: 2,
                              ),
                            ],
                          ),
                        ),
                        !_status ? _getActionButtons() : new Container(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            TextButton(
              child: Text("Go Back"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                child: new ElevatedButton(
                  child: new Text("Save"),
                  style: ElevatedButton.styleFrom(
                    primary: elevatedButtonPrimaryColor1,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0)
                    ),
                    textStyle: TextStyle(color: formFieldTextColor),
                  ),
                  onPressed: () {
                    updateDetail();
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                child: new ElevatedButton(
                  child: new Text("Cancel"),
                  style: ElevatedButton.styleFrom(
                    primary: elevatedButtonPrimaryColor2,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0)
                    ),
                    textStyle: TextStyle(color: formFieldTextColor),
                  ),
                  onPressed: () {
                    setState(() {
                      _status = true;
                      FocusScope.of(context).requestFocus(new FocusNode());
                    });
                  },
                ),
              ),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }

  void updateDetail() async {
    setState(() {
      isUserLoaded = false;
    });
    String returnMsg = await context.read<AuthenticationService>().updateUserDetails(_nameCont.text, _usernameCont.text, _dobCont.text);
    Fluttertoast.showToast(  
      msg: returnMsg,  
      toastLength: Toast.LENGTH_SHORT,  
      gravity: ToastGravity.BOTTOM,
      backgroundColor: elevatedButtonPrimaryColor2,  
      textColor: hintTextColor  
    );
  }
}
