import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'players_services.dart';

class Players{
  final PlayersServices _services; 
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  DateTime? pickedDate;
  String dropdownValue = 'GK';
  List<String> positions = ['-', 'GK', 'DEF', 'MID', 'FW'];
  final CollectionReference _players = FirebaseFirestore.instance.collection('players');
  Players(String teamId): _services = PlayersServices(teamId);
  Future<void> update(BuildContext context, [DocumentSnapshot? documentSnapshot]) async{

    if(documentSnapshot != null){
      _firstNameController.text = documentSnapshot['first_name'];
      _lastNameController.text = documentSnapshot['last_name'];
      _countryController.text = documentSnapshot['country'];
      _numberController.text = documentSnapshot['number'].toString();
      _dateOfBirthController.text = documentSnapshot['date_of_birth'];
      dropdownValue = documentSnapshot['position'];
    }

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx){
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState){
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
                    controller: _lastNameController,
                    decoration: const InputDecoration(labelText: 'Surname'),
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
              
                  InkWell(
                    onTap: () async {
                      DateTime now = DateTime.now();
                      DateTime firstDate = DateTime(now.year - 35);
                      DateTime lastDate = DateTime(now.year - 16);
                      pickedDate = await showDatePicker(
                        context: context,
                        initialDate: lastDate, 
                        firstDate: firstDate, 
                        lastDate: lastDate,
                      );
                      if(pickedDate!=null){
                        String formattedDate = pickedDate!.year.toString() + '-' + pickedDate!.month.toString() + '-' + pickedDate!.day.toString();
                        _dateOfBirthController.text = formattedDate;
                      }
                    },
                    child: IgnorePointer(
                          child: TextField(
                            controller: _dateOfBirthController,
                            decoration: InputDecoration(hintText: 'Date of Birth'),
                          ),
                    ),
                  ),

                  Row(
                    children: [
                      const Text('Position: '),
                      DropdownButton<String>(
                        value: dropdownValue,
                        onChanged: (String? newValue) {
                          setModalState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: positions.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: 
                           TextStyle(color: Theme.of(context).colorScheme.onPrimary),),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: () async{
                      final String firstName = _firstNameController.text;
                      final String country = _countryController.text;
                      final int? number = int.tryParse(_numberController.text);
                      final String position = dropdownValue;
                      final String dateOfBirth = _dateOfBirthController.text;
                      final String lastName = _lastNameController.text;
                      //!TODO: Do other validations
                      //!TODO: Add also the picture input
                      if(number!=null && firstName.isNotEmpty && country.isNotEmpty && position!='-' && dateOfBirth.isNotEmpty){
                        await _players.doc(documentSnapshot!.id).update({"first_name":firstName, "last_name":lastName, "number":number, "country":country, "position":position, "date_of_birth":dateOfBirth});
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
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
    );
  }

  Future<void> create(BuildContext context, [DocumentSnapshot? documentSnapshot]) async{
    _numberController.text = '' ;
    _firstNameController.text = '' ;
    _lastNameController.text = '' ;
    _countryController.text = '' ;
    _dateOfBirthController.text = '' ;
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx){
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState){
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
                    controller: _lastNameController,
                    decoration: const InputDecoration(labelText: 'Surname'),
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

                  InkWell(
                    onTap: () async {
                      DateTime now = DateTime.now();
                      DateTime firstDate = DateTime(now.year - 35);
                      DateTime lastDate = DateTime(now.year - 16);
                      pickedDate = await showDatePicker(
                        context: context,
                        initialDate: lastDate, 
                        firstDate: firstDate, 
                        lastDate: lastDate,
                      );
                      if(pickedDate!=null){
                        String formattedDate = pickedDate!.year.toString() + '-' + pickedDate!.month.toString() + '-' + pickedDate!.day.toString();
                        _dateOfBirthController.text = formattedDate;
                      }
                    },
                    child: IgnorePointer(
                          child: TextField(
                            controller: _dateOfBirthController,
                            decoration: InputDecoration(hintText: 'Date of Birth'),
                          ),
                    )
                  ),
   
                  Row(
                    children: [
                      const Text('Position: '),
                      DropdownButton<String>(
                          value: dropdownValue,
                          onChanged: (String? newValue) {
                            setModalState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: positions.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style:  TextStyle(color: Theme.of(context).colorScheme.onPrimary),),
                            );
                          }).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: () async{
                      final String firstName = _firstNameController.text;
                      final String country = _countryController.text;
                      final int? number = int.tryParse(_numberController.text);
                      final String position = dropdownValue;
                      final String dateOfBirth = _dateOfBirthController.text;
                      final String lastName = _lastNameController.text;
                      if (number != null && firstName.isNotEmpty && country.isNotEmpty && position != '-' && dateOfBirth.isNotEmpty) {
                        await _services.addPlayer({
                          "first_name": firstName,
                          "last_name": lastName,
                          "number": number,
                          "country": country,
                          "position": position,
                          "date_of_birth": dateOfBirth,
                          "photo_uri": "https://firebasestorage.googleapis.com/v0/b/soccer-app-5af3d.appspot.com/o/none_logo.png?alt=media&token=4d1c5d1f-0900-4fad-85de-766f5167734b"
                        }); 
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
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
    );
  }

  Stream<QuerySnapshot> getPlayersStream() {
    return _services.getPlayersStream();
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