import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestoreAuth;
  Map<String, dynamic> curruserData;
  List<int> _likes;
  UserData(this._firebaseAuth, this._firestoreAuth);

  Future<String> setUserDetails(String name, String username, String phNo, String dob, String photoLink) async {
    try{
      await _firestoreAuth.collection("users").doc(_firebaseAuth.currentUser.uid).set(
      { "name" : name, "username" : username, "email" : _firebaseAuth.currentUser.email,
        "phNo" : phNo, "dob" : dob, "photoLink" : photoLink, "likes" : [] });
      return "Success";
    } catch(e) {
      return e;
    }
  }

  Future<void> fetchUserDetails() async {
    try{
      await _firestoreAuth.collection("users").doc(_firebaseAuth.currentUser.uid).get().then((value){
        curruserData = value.data();
        _likes = curruserData["likedMovies"];
      });
    } catch(e) {
      curruserData = {"Error": e};
      _likes = [];
    }
  }

  Future<String> updateUserDetails(String name, String username, String dob) async {
    try{
      await _firestoreAuth.collection("users").doc(_firebaseAuth.currentUser.uid)
      .update({"name": name, "username": username, "dob": dob}).then((value){
        print("SUCCESS");
    });
    return "Success";
    } catch(e) {
      return "Error";
    }
  }

  Map<String, dynamic> getUserDetails() {
    return curruserData;
  }

  bool isLikedByUser(int id){
    return _likes.contains(id) ? true : false;
  }
  
}