import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get user => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.idTokenChanges();

  Future<void> login(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    print("[Auth_Service] value authStateChanges 1==> $authStateChanges");
    print("[Auth_Service] value currentUser 1==> $user");
  }

  Future<void> signUp(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    try {
      
    await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
    
    print("[Auth_Service] value authStateChanges 2==> $authStateChanges");
     print("[Auth_Service] value currentUser 2 ==> $user");
    
  }
}
