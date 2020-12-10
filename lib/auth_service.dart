import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //final FirebaseAuth _firebaseAuth;
  AuthService(this._firebaseAuth);

  //alteração
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //TENTANDO RELACIOANR UM ID COM UMA COLLECTION
  Future<String> getCurrentUID() async {
    FirebaseUser user = await _firebaseAuth.currentUser;
    return user?.uid;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signUp({String email, String password}) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      await FirebaseFirestore.instance
          .collection('userData')
          .doc(credential.user.uid)
          .set({'email': credential.user.email});

      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
