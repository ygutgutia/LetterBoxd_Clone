import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestoreAuth;
  AuthenticationService(this._firebaseAuth, this._firestoreAuth);

  /// Changed to idTokenChanges as it updates depending on more cases.
  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  /// This won't pop routes so you could do something like
  /// Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  /// after you called this method if you want to pop all routes.
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<String> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      await _firebaseAuth.currentUser.sendEmailVerification();
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }


  Future<String> forgetPassword({String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> setUserDetails(String name, String username, String phNo, String dob, String photoLink) async {
    try{
      await _firestoreAuth.collection("users").doc(_firebaseAuth.currentUser.uid).set(
      { "name" : name, "username" : username, "email" : _firebaseAuth.currentUser.email,
        "phNo" : phNo, "dob" : dob, "photoLink" : photoLink });
      return "Success";
    } catch(e) {
      return e;
    }
  }

  Future<Map<String, dynamic>> getUserDetails() async {
    try{
      Map<String, dynamic> valueTemp;
      await _firestoreAuth.collection("users").doc(_firebaseAuth.currentUser.uid).get().then((value){
      valueTemp = value.data();
    });
    return valueTemp;
    } catch(e) {
      return {"Error": e};
    }
  }

  Future<String> updateUserDetails(String name, String username, String dob) async {
    try{
      print("DOING");
      await _firestoreAuth.collection("users").doc(_firebaseAuth.currentUser.uid)
      .update({"name": name, "username": username, "dob": dob}).then((value){
        print("SUCCESS");
    });
    return "Success";
    } catch(e) {
      return "Error";
    }
  }

  bool isUserverified({String email, String password}) {
    return _firebaseAuth.currentUser.emailVerified;
  }
  
}