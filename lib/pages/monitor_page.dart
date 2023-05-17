import 'package:flutter/material.dart';
import 'package:next_gen_first_app/utils/scale.dart';

class MonitorPage extends StatefulWidget {
 
  const MonitorPage({Key? key}) : super(key: key);  @override
  _MonitorPageState createState() => _MonitorPageState();
}

class _MonitorPageState extends State<MonitorPage> {
  int _selectedPlayer = -1;
  Widget build(BuildContext context) {
    Scale scale = Scale(context as BuildContext);
    double playerContainerHeight = 40;
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: 11,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      _selectedPlayer = index;
                    });
                  },
                  child: _buildPlayerContainer(playerContainerHeight, _selectedPlayer==index)
                );
              },
            ),
          ),
          
        ],
      ),
    );
  }
  
}

Widget _buildPlayerContainer(double height, bool isSelected) {
  return FractionallySizedBox(
    alignment: Alignment.centerLeft,
    widthFactor: 0.2,
    child: Container(
      height: height,
      margin: EdgeInsets.symmetric(vertical: height/4),
      color: isSelected? Colors.blue : Colors.white,
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey,
          ),
          SizedBox(width: 10,),
          Text('Ach Geo'),
          Text('1'),
        ],
      ),
    ),
  );
}
