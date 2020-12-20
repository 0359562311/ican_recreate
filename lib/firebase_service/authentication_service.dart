import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:ican_project/model/custom_user.dart';

class AuthService {
  static var _authInstance = FirebaseAuth.instance;

  static Stream<User> get user => _authInstance.userChanges();

  static User get currentUser => _authInstance.currentUser;

  static Future<User> createUser(CustomUser user) async{
    var credential = await _authInstance.createUserWithEmailAndPassword(email: user.email, password: user.password);
    await credential.user.updateProfile(displayName: user.fullName);
    return credential.user;
  }

  static Future<void> changePassword(String oldPassword, String newPassword) async{
    AuthCredential authCredential = EmailAuthProvider.credential(email: currentUser.email, password: oldPassword);
    await currentUser.reauthenticateWithCredential(authCredential).whenComplete(() async {
      await currentUser.updatePassword(newPassword);
    });
  }
}