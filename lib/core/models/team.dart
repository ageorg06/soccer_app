import 'package:cloud_firestore/cloud_firestore.dart';

class Team {
  final String id;
  final String name;
  final String country;
  final int division;
  final int position;
  final String photoUri;

  Team({
    required this.id,
    required this.name,
    required this.country,
    required this.division,
    required this.position,
    required this.photoUri,
  });

  // Factory constructor to create an instance of Team from a Firestore document
  factory Team.fromDocument(QueryDocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Team(
      id: doc.id,
      name: data['name'],
      country: data['country'],
      division: data['division'],
      position: data['position'],
      photoUri: data['photo_uri'],
    );
  }

  static Team fromDocumentSnapshot(DocumentSnapshot doc) {
    return Team(
      id: doc.id,
      name: doc['name'],
      country: doc['country'],
      division: doc['division'],
      position: doc['position'],
      photoUri: doc['photo_uri'],
    );
  }

  Map<String, dynamic> toDocumentSnapshot() {
    return {
      'name': name,
      'country': country,
      'division': division,
      'position': position,
      'photo_uri': photoUri,
    };
  }
}
