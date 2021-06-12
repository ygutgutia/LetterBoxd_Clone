import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:letterboxd/models/user_details.dart';

class UserData with ChangeNotifier{
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestoreAuth;
  UserDetail curruserData;
  List<dynamic> _likes = [];
  UserData(this._firebaseAuth, this._firestoreAuth);

  Future<String> setUserDetails(String name, String username, String phNo, String dob, String photoLink) async {
    try{
      await _firestoreAuth.collection("users").doc(_firebaseAuth.currentUser.uid).set(
      { "name" : name, "username" : username, "email" : _firebaseAuth.currentUser.email,
        "phNo" : phNo, "dob" : dob, "photoLink" : photoLink, "likedMovies" : [] });
      return "Success";
    } catch(e) {
      return e;
    }
  }

  Future<void> fetchUserDetails() async {
    try{
      await _firestoreAuth.collection("users").doc(_firebaseAuth.currentUser.uid).get().then((value){
        curruserData = UserDetail(name: value["name"], username: value["username"], email: value["email"], dob: value["dob"],
                                  photoLink: value["photoLink"], phNo: value["phNo"], likedMovies: value["likedMovies"].cast<int>());
        _likes = curruserData.likedMovies;
      });
    } catch(e) {
      throw e;
    }
  }

  Future<String> updateUserDetails(String name, String username, String dob) async {
    try{
      await _firestoreAuth.collection("users").doc(_firebaseAuth.currentUser.uid)
        .update({"name": name, "username": username, "dob": dob}).then((value){
      });
      curruserData.name = name;
      curruserData.username = username;
      curruserData.dob = dob;
      notifyListeners();
      return "Success";
    } catch(e) {
      return "Error";
    }
  }

   Future<String> updateLikes(int movieid, bool add) async {
    try{
      add ? await _firestoreAuth.collection("users").doc(_firebaseAuth.currentUser.uid)
        .update({"likedMovies" : FieldValue.arrayUnion([movieid])}).then((value){
      }) : await _firestoreAuth.collection("users").doc(_firebaseAuth.currentUser.uid)
        .update({"likedMovies" : FieldValue.arrayRemove([movieid])}).then((value){
      });
      add ? curruserData.likedMovies.add(movieid) : curruserData.likedMovies.remove(movieid);
      _likes = curruserData.likedMovies;
      notifyListeners();
      return "Success";
    } catch(e) {
      print(e); 
      return "Error";
    }
  }

  UserDetail getUserDetails() {
    return curruserData;
  }

  bool isLikedByUser(int id){
    return _likes.contains(id) ? true : false;
  }
  
}