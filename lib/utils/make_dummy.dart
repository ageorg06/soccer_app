import 'package:cloud_firestore/cloud_firestore.dart';

void addDummyData() {
  CollectionReference teams = FirebaseFirestore.instance.collection('teams');

  teams.add({
    'name': 'Team A',
    'players': [
      [
        {"id":1,"first_name":"Jamal","last_name":"Valett","age":36,"position":"GK","height":179.6,"weight":76.0,"jersey_number":7},
        {"id":2,"first_name":"Athena","last_name":"Jakubovski","age":36,"position":"GK","height":167.2,"weight":84.3,"jersey_number":2},
        {"id":3,"first_name":"Cheryl","last_name":"Costall","age":34,"position":"DEF","height":170.0,"weight":71.9,"jersey_number":48},
        {"id":4,"first_name":"Markus","last_name":"Filipczak","age":21,"position":"ATT","height":200.2,"weight":80.1,"jersey_number":15},
        {"id":5,"first_name":"Elle","last_name":"Munnery","age":28,"position":"ATT","height":189.9,"weight":68.7,"jersey_number":77},
        {"id":6,"first_name":"Lorna","last_name":"Billings","age":28,"position":"GK","height":167.9,"weight":85.9,"jersey_number":70},
        {"id":7,"first_name":"Annis","last_name":"Bisset","age":23,"position":"DEF","height":172.2,"weight":71.3,"jersey_number":23},
        {"id":8,"first_name":"Harley","last_name":"Wormstone","age":34,"position":"ATT","height":163.2,"weight":81.6,"jersey_number":85},
        {"id":9,"first_name":"Fairleigh","last_name":"McFfaden","age":36,"position":"MID","height":165.3,"weight":69.2,"jersey_number":76},
        {"id":10,"first_name":"Haley","last_name":"Caen","age":38,"position":"MID","height":196.0,"weight":83.5,"jersey_number":92},
        {"id":11,"first_name":"Alanah","last_name":"Milburn","age":35,"position":"MID","height":198.0,"weight":79.4,"jersey_number":58},
        {"id":12,"first_name":"Briney","last_name":"Roizn","age":39,"position":"DEF","height":201.7,"weight":81.6,"jersey_number":8},
        {"id":13,"first_name":"Brian","last_name":"Abbay","age":25,"position":"MID","height":191.1,"weight":73.2,"jersey_number":1},
        {"id":14,"first_name":"Mattheus","last_name":"Degoey","age":19,"position":"MID","height":197.0,"weight":89.1,"jersey_number":89},
        {"id":15,"first_name":"Ernst","last_name":"Moroney","age":30,"position":"MID","height":167.7,"weight":73.5,"jersey_number":4},
        {"id":16,"first_name":"Roderick","last_name":"Elton","age":35,"position":"MID","height":196.7,"weight":75.6,"jersey_number":18},
        {"id":17,"first_name":"Arri","last_name":"Threlkeld","age":34,"position":"MID","height":193.5,"weight":70.6,"jersey_number":51},
        {"id":18,"first_name":"Austen","last_name":"Lyddy","age":26,"position":"ATT","height":163.2,"weight":74.2,"jersey_number":17},
        {"id":19,"first_name":"Somerset","last_name":"Ricardin","age":23,"position":"DEF","height":194.9,"weight":81.6,"jersey_number":10},
        {"id":20,"first_name":"Ruben","last_name":"Tuckey","age":18,"position":"ATT","height":167.1,"weight":86.6,"jersey_number":4},
        {"id":21,"first_name":"Dorothee","last_name":"Errey","age":34,"position":"GK","height":190.8,"weight":86.4,"jersey_number":38},
        {"id":22,"first_name":"Turner","last_name":"Gouch","age":39,"position":"DEF","height":187.7,"weight":71.3,"jersey_number":47},
        {"id":23,"first_name":"Dorey","last_name":"Woods","age":38,"position":"DEF","height":191.1,"weight":81.6,"jersey_number":44},
        {"id":24,"first_name":"Marcelia","last_name":"Boxill","age":34,"position":"DEF","height":184.1,"weight":78.2,"jersey_number":35},
        {"id":25,"first_name":"Franchot","last_name":"Archanbault","age":36,"position":"ATT","height":188.2,"weight":88.8,"jersey_number":93}
      ]
    ]
  })
  .then((value) => print("Team Added"))
  .catchError((error) => print("Failed to add team: $error"));
}
