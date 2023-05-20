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
  
  Future<void> _update([DocumentSnapshot? documentSnapshot]) async{
    if(documentSnapshot != null){
      _nameController.text = documentSnapshot['name'];
      _divisionController.text = documentSnapshot['division'].toString();
    }

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx){
        return Padding(
          padding: EdgeInsets.only(top:20, left:20, right:20, bottom: MediaQuery.of(ctx).viewInsets.bottom+20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                keyboardType: const TextInputType.numberWithOptions(decimal: false),
                controller: _divisionController,
                decoration: const InputDecoration(labelText: 'Division'),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () async{
                  final String name = _nameController.text;
                  final int? division = int.tryParse(_divisionController.text);
                  if(division!=null){
                    await _teams.doc(documentSnapshot!.id).update({"name":name, "division":division});
                    // _divisionController.text = '' ;
                    // _nameController.text = '' ;
                  }
                },
                child: const Text("Update")
              )
            ],
          ),
        );
      }
    );
  }
  
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async{
    if(documentSnapshot != null){
      _nameController.text = documentSnapshot['name'];
      _divisionController.text = documentSnapshot['division'].toString();
    }

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx){
        return Padding(
          padding: EdgeInsets.only(top:20, left:20, right:20, bottom: MediaQuery.of(ctx).viewInsets.bottom+20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                keyboardType: const TextInputType.numberWithOptions(decimal: false),
                controller: _divisionController,
                decoration: const InputDecoration(labelText: 'Division'),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () async{
                  final String name = _nameController.text;
                  final int? division = int.tryParse(_divisionController.text);
                  if(division!=null){
                    await _teams.add({"name":name, "division":division});
                    _divisionController.text = '' ;
                    _nameController.text = '' ;
                  }
                },
                child: const Text("Add")
              )
            ],
          ),
        );
      }
    );
  }

  Future<void> _delete(String teamId) async{
    await _teams.doc(teamId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('You have successfully deleted a product'))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: ()=> _update(documentSnapshot),
                            icon: const Icon(Icons.edit)
                          ),
                          IconButton(
                            onPressed: ()=> _delete(documentSnapshot.id),
                            icon: const Icon(Icons.delete)
                          )
                        ],
                      )
                    ),
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