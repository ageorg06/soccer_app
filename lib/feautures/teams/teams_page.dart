import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../core/models/team.dart';
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
  
  Future<void> _update(BuildContext context, [Team? team]) async {
     await _instance.update(context, team);
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
    return StreamBuilder<List<Team>>(
      stream: _instance.snapshots(),
      builder: (context, snapshot){
        if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        }
        if(snapshot.hasData){
          List<Team> teams = snapshot.data!;
          return _buildListView(teams);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    );
  }
  
  Widget _buildListView(List<Team> teams) {
    return ListView.builder(
      itemCount: teams.length, //number of rows
      itemBuilder:(context, index){
        Team team = teams[index];
        return _buildListItem(team);
      }
    );
  }
  
  Widget _buildListItem(Team team) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: Image.network(team.photoUri),
        title: Text(team.name),
        subtitle: Text("Division: ${team.division}"),
        trailing: _buildActionButtons(team)
      ),
    );        
  }
  
  _buildActionButtons(Team team) {
    return SizedBox(
      width: 150,
      child: Row(
        children: [
          IconButton(
            onPressed: () => _navigateToPlayers(team.id), 
            icon: const Icon(Icons.arrow_forward)
          ),
          IconButton(
            onPressed: ()=> _update(context, team),
            icon: const Icon(Icons.edit)
          ),
          IconButton(
            onPressed: ()=> _delete(context, team.id),
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