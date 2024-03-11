import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.idTokenChanges();

  Future<void> login(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    print('=> [auth_service] login user : $email');
    print('=> [auth_service] login current user : $currentUser');
  }

  Future<void> signUp(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    await _auth.signOut();
    print('=> [auth_service] currentUser signout $currentUser');
  }

  Future<User?> getUser() async {
    return currentUser;
  }
}
