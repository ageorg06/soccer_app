import 'package:cloud_firestore/cloud_firestore.dart';

class Player {
  final String id;
  final String country;
  final String firstName;
  final int number;
  final String photoUri;
  final String position;
  final String lastName;
  final String dateOfBirth;

  Player({
    required this.id,
    required this.country,
    required this.firstName,
    required this.number,
    required this.photoUri,
    required this.position,
    required this.lastName,
    required this.dateOfBirth,
  });

  factory Player.fromDocumentSnapshot(DocumentSnapshot doc) {
    return Player(
      id: doc.id,
      country: doc['country'],
      firstName: doc['first_name'],
      number: doc['number'],
      photoUri: doc['photo_uri'],
      position: doc['position'],
      lastName: doc['last_name'],
      dateOfBirth: doc['date_of_birth'],
    );
  }

  Map<String, dynamic> toDocumentSnapshot() {
    return {
      'country': country,
      'first_name': firstName,
      'number': number,
      'photo_uri': photoUri,
      'position': position,
      'last_name': lastName,
      'date_of_birth': dateOfBirth,
    };
  }
}
