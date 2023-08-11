import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Teams{
  final CollectionReference _teams = FirebaseFirestore.instance.collection('teams');

  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _divisionController = TextEditingController();

  Future<void> update(BuildContext context, [DocumentSnapshot? documentSnapshot]) async{
    if(documentSnapshot != null){
      _nameController.text = documentSnapshot['name'];
      _countryController.text = documentSnapshot['country'];
      _divisionController.text = documentSnapshot['division'].toString();
      _positionController.text = documentSnapshot['position'].toString();
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
                controller: _countryController,
                decoration: const InputDecoration(labelText: 'Country'),
              ),

              TextField(
                keyboardType: const TextInputType.numberWithOptions(decimal: false),
                controller: _divisionController,
                decoration: const InputDecoration(labelText: 'Division'),
              ),

              TextField(
                keyboardType: const TextInputType.numberWithOptions(decimal: false),
                controller: _positionController,
                decoration: const InputDecoration(labelText: 'Position'),
              ),

              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () async{
                  final String name = _nameController.text;
                  final String country = _countryController.text;
                  final int? division = int.tryParse(_divisionController.text);
                  final int? position = int.tryParse(_positionController.text);
                  if(division!=null){
                    await _teams.doc(documentSnapshot!.id).update({"name":name, "division":division, "country":country, "position":position });
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

  Future<void> create(BuildContext context, [DocumentSnapshot? documentSnapshot]) async{
    _divisionController.text = '' ;
    _nameController.text = '' ;
    _countryController.text = '' ;
    _positionController.text = '' ;
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
                controller: _countryController,
                decoration: const InputDecoration(labelText: 'Country'),
              ),
              TextField(
                keyboardType: const TextInputType.numberWithOptions(decimal: false),
                controller: _divisionController,
                decoration: const InputDecoration(labelText: 'Division'),
              ),

              TextField(
                keyboardType: const TextInputType.numberWithOptions(decimal: false),
                controller: _positionController,
                decoration: const InputDecoration(labelText: 'Position'),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () async{
                  final String name = _nameController.text;
                  final String country = _countryController.text;
                  final int? division = int.tryParse(_divisionController.text);
                  final int? position = int.tryParse(_positionController.text);
                  if(division!=null){
                    //!TODO: Add also the picture input
                    await _teams.add({"name":name, "division":division, "country":country, "position":position, "photo_uri":"https://firebasestorage.googleapis.com/v0/b/soccer-app-5af3d.appspot.com/o/none_logo.png?alt=media&token=4d1c5d1f-0900-4fad-85de-766f5167734b"});
                    _divisionController.text = '' ;
                    _nameController.text = '' ;
                    _countryController.text = '' ;
                    _positionController.text = '' ;
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
  
  Future<void> deleteIt(BuildContext context, String teamId) async{
    await _teams.doc(teamId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('You have successfully deleted a product'))
    );
  }

  Stream<QuerySnapshot> snapshots() {
    return _teams.snapshots();
  }
  
}