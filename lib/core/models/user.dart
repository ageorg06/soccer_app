import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String email;
  final String username;
  final String? teamId;  // This can be null if the user hasn't created a team yet

  User({
    required this.id,
    required this.email,
    required this.username,
    this.teamId,
  });

  // Factory constructor to create an instance of User from a Firestore document
  factory User.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>? ?? {};
    
    print("Data from Firestore: $data");  // Debugging print statement
    
    return User(
      id: doc.id,
      email: data['email'] ?? '',
      username: data['username'] ?? '',
      teamId: data['teamId'],
    );
  }

  Map<String, dynamic> toDocumentSnapshot() {
    return {
      'email': email,
      'username': username,
      'teamId': teamId,
    };
  }
}
