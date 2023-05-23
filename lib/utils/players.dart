import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Players{
  final CollectionReference _players = FirebaseFirestore.instance.collection('teams').doc('teamId').collection('players');
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  @override
  CollectionReference get instance => _players;
  Future<void> update(BuildContext context, [DocumentSnapshot? documentSnapshot]) async{

    if(documentSnapshot != null){
      _firstNameController.text = documentSnapshot['first_name'];
      _countryController.text = documentSnapshot['country'];
      _numberController.text = documentSnapshot['number'].toString();
      _positionController.text = documentSnapshot['position'];
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
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
              ),

              TextField(
                controller: _countryController,
                decoration: const InputDecoration(labelText: 'Country'),
              ),

              TextField(
                keyboardType: const TextInputType.numberWithOptions(decimal: false),
                controller: _numberController,
                decoration: const InputDecoration(labelText: 'Kit number'),
              ),

              TextField(
                keyboardType: const TextInputType.numberWithOptions(decimal: false),
                controller: _positionController,
                decoration: const InputDecoration(labelText: 'Position'),
              ),

              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () async{
                  final String firstName = _firstNameController.text;
                  final String country = _countryController.text;
                  final int? number = int.tryParse(_numberController.text);
                  final String position = _positionController.text;
                  //!TODO: Do other validations
                  //!TODO: Add also the picture input
                  if(number!=null){
                    await _players.doc(documentSnapshot!.id).update({"first_name":firstName, "number":number, "country":country, "position":position });
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
    _numberController.text = '' ;
    _firstNameController.text = '' ;
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
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
              ),

              TextField(
                controller: _countryController,
                decoration: const InputDecoration(labelText: 'Country'),
              ),
              TextField(
                keyboardType: const TextInputType.numberWithOptions(decimal: false),
                controller: _numberController,
                decoration: const InputDecoration(labelText: 'Kit number'),
              ),

              TextField(
                keyboardType: const TextInputType.numberWithOptions(decimal: false),
                controller: _positionController,
                decoration: const InputDecoration(labelText: 'Position'),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () async{
                  final String firstName = _firstNameController.text;
                  final String country = _countryController.text;
                  final int? number = int.tryParse(_numberController.text);
                  final String? position = _positionController.text;
                  if(number!=null){
                    //!TODO: Do other validations
                    //!TODO: Add also the picture input
                    await _players.add({"first_name":firstName, "number":number, "country":country, "position":position, "photo_uri":"https://firebasestorage.googleapis.com/v0/b/soccer-app-5af3d.appspot.com/o/none_logo.png?alt=media&token=4d1c5d1f-0900-4fad-85de-766f5167734b"});
                    _numberController.text = '' ;
                    _firstNameController.text = '' ;
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
    await _players.doc(teamId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('You have successfully deleted a product'))
    );
  }

  Stream<QuerySnapshot> snapshots() {
    return _players.snapshots();
  }
  
}