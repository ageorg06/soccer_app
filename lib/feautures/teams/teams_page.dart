import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../universal_scaffold.dart';
import '../players/players_page.dart';
import 'teams_controller.dart';


class TeamsPage extends StatefulWidget {
  final ValueNotifier<String> titleNotifier;
  const TeamsPage({Key? key, required this.titleNotifier}) : super(key: key);

  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  final Teams _instance = Teams();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:  _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: _buildBody(), 
    );
  }
  
  Future<void> _update(BuildContext context, [DocumentSnapshot? documentSnapshot]) async {
     await _instance.update(context, documentSnapshot);
  }
  
  Future<void> _create(BuildContext context, [DocumentSnapshot? documentSnapshot]) async {
     await _instance.create(context, documentSnapshot);
  }

  Future<void> _delete(BuildContext context, String teamId) async {
     await _instance.deleteIt(context, teamId);
  }
  
  Widget _buildFloatingActionButton() {
      return FloatingActionButton(
      onPressed: () => _create(context),
      child: const Icon(Icons.add),
    );
  }
  
  Widget _buildBody() {
    return StreamBuilder(
      stream: _instance.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
        if (streamSnapshot.hasError) {
          return Center(
            child: Text("Error: ${streamSnapshot.error}"),
          );
        }
        if(streamSnapshot.hasData){
          return _buildListView(streamSnapshot.data);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    );
  }
  
  Widget _buildListView(QuerySnapshot<Object?>? data) {
    return ListView.builder(
      itemCount: data!.docs.length, //number of rows
      itemBuilder:(context, index){
        final DocumentSnapshot documentSnapshot = data.docs[index];
        return _buildListItem(documentSnapshot);
      }
    );
  }
  
  Widget _buildListItem(DocumentSnapshot<Object?> documentSnapshot) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: Image.network(documentSnapshot['photo_uri']),
        title: Text(documentSnapshot['name']),
        subtitle: Text("Division: ${documentSnapshot['division']}"),
        trailing: _buildActionButtons(documentSnapshot)
      ),
    );        
  }
  
  _buildActionButtons(DocumentSnapshot<Object?> documentSnapshot) {
    SizedBox(
      width: 150,
      child: Row(
        children: [
          IconButton(
            onPressed: () => _navigateToPlayers(documentSnapshot.id), 
            icon: const Icon(Icons.arrow_forward)
          ),
          IconButton(
            onPressed: ()=> _update(context, documentSnapshot),
            icon: const Icon(Icons.edit)
          ),
          IconButton(
            onPressed: ()=> _delete(context, documentSnapshot.id),
            icon: const Icon(Icons.delete)
          )
        ],
      )
    );
  }
  
  _navigateToPlayers(String teamId) {
    ValueNotifier<String> titleNotifier = ValueNotifier<String>("Choose a player");
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => UniversalScaffold(
        title: titleNotifier,
        body: PlayersPage(titleNotifier: titleNotifier, team: teamId)
        )
      )
    );
  }
}