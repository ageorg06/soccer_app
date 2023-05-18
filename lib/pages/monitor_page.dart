import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:next_gen_first_app/utils/scale.dart';

class MonitorPage extends StatefulWidget {
 
  const MonitorPage({Key? key}) : super(key: key);  
  @override
  _MonitorPageState createState() => _MonitorPageState();
}

class _MonitorPageState extends State<MonitorPage> {
  int _selectedPlayer = 0;
  List<String> action = List<String>.generate(22, (index) => 'Action ${index + 1}');
  Widget build(BuildContext context) {
    Scale scale = Scale(context as BuildContext);
    double playerContainerHeight = 40;
    return Scaffold(
      body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
          Expanded(
            flex: 3,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constrains){
                int numColumns = (constrains.maxWidth/100).floor();
                numColumns = numColumns >= 4 ? numColumns : 4;
                numColumns = numColumns <= 8 ? numColumns : 8;

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: numColumns,
                    childAspectRatio: 1,
                  ),
                  itemCount: action.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow:[
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0,3),
                          )
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              "assets/shoot.svg",
                              width: 65,
                              height: 65,
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,  
                            child: Container(
                              color: Colors.grey[200],
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                action[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
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
