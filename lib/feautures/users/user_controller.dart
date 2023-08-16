import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/models/user.dart';

class UserController {
  final CollectionReference _users = FirebaseFirestore.instance.collection('users');

  Future<void> createUser(String email, String username) async {
    await _users.add({
      'email': email,
      'username': username,
    });
  }

  Future<void> assignTeamToUser(String userId, String teamId) async {
    await _users.doc(userId).update({
      'teamId': teamId,
    });
  }

  Stream<User> getUserStream(String userId) {
    return _users.doc(userId).snapshots().map((doc) => User.fromDocument(doc));
  }
}
