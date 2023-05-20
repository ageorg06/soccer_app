import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class TeamsPage extends StatefulWidget {
  final ValueNotifier<String> titleNotifier;
  const TeamsPage({super.key, required this.titleNotifier});

  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  final CollectionReference _teams = FirebaseFirestore.instance.collection('teams');
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _divisionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _teams.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
          if (streamSnapshot.hasError) {
            return Center(
              child: Text("Error: ${streamSnapshot.error}"),
            );
          }
          if(streamSnapshot.hasData){
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length, //number of rows
              itemBuilder:(context, index){
                final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.network(documentSnapshot['photo_uri']),
                    title: Text(documentSnapshot['name']),
                    subtitle: Text("Division: ${documentSnapshot['division']}"),
                    // trailing: SizedBox(
                    //   width: 100,
                    //   child: Row(
                    //     children: [
                    //       IconButton(
                    //         onPressed: ()=> _update(documentSnapshot),
                    //         icon: const Icon(Icons.edit)
                    //       )
                    //     ],
                    //   )
                    // ),
                  ),
                );
              }
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      ),
    );
  }
}