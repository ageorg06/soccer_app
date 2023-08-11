import 'package:cloud_firestore/cloud_firestore.dart';

class PlayersServices {
  final String teamId;
  late final CollectionReference _players;

  PlayersServices(this.teamId) {
    _players = FirebaseFirestore.instance.collection('teams').doc(teamId).collection('players');
  }

  Future<DocumentReference> addPlayer(Map<String, dynamic> playerData) async {
    return await _players.add(playerData);
  }

  Future<void> updatePlayer(String playerId, Map<String, dynamic> updatedData) async {
    return await _players.doc(playerId).update(updatedData);
  }

  Future<void> deletePlayer(String playerId) async {
    return await _players.doc(playerId).delete();
  }

  Stream<QuerySnapshot> getPlayersStream() {
    return _players.snapshots();
  }
}
