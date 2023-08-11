import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'players_controller.dart';

class PlayersPage extends StatefulWidget {
  final String team;
  const PlayersPage({super.key, required ValueNotifier<String> titleNotifier, required this.team});

  @override
  State<PlayersPage> createState() => _PlayersPageState();
}

class _PlayersPageState extends State<PlayersPage> {
  late Players instance;
  late Stream<QuerySnapshot> _playersStream;

  @override
  void initState() {
    super.initState();
    instance = Players(widget.team);
    _playersStream = instance.getPlayersStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(context),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: StreamBuilder(
        stream: _playersStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasError) {
            return Center(
              child: Text("Error: ${streamSnapshot.error}"),
            );
          }
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length, //number of rows
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.network(documentSnapshot['photo_uri']),
                    title: Text(documentSnapshot['first_name']),
                    subtitle: Text("Kit number: ${documentSnapshot['number']}"),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(onPressed: () => _update(context, documentSnapshot), icon: const Icon(Icons.edit)),
                          IconButton(onPressed: () => _delete(context, documentSnapshot.id), icon: const Icon(Icons.delete))
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<void> _update(BuildContext context, [DocumentSnapshot? documentSnapshot]) async {
    await instance.update(context, documentSnapshot);
  }

  Future<void> _create(BuildContext context, [DocumentSnapshot? documentSnapshot]) async {
    await instance.create(context, documentSnapshot);
  }

  Future<void> _delete(BuildContext context, String teamId) async {
    await instance.deleteIt(context, teamId);
  }
}
