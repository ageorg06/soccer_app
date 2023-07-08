import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:next_gen_first_app/utils/scale.dart';
class MonitorPage extends StatefulWidget {
  final ValueNotifier<String> titleNotifier;
  const MonitorPage({Key? key, required this.titleNotifier}) : super(key: key);  
  @override
  _MonitorPageState createState() => _MonitorPageState();
}

class _MonitorPageState extends State<MonitorPage> {
  int _selectedPlayer = 0;
  late List<int> _actionCounts ;
  List<String> action = List<String>.generate(22, (index) => 'Action ${index + 1}');
  List<String> players = List<String>.generate(11, (index) => 'Player ${index + 1}');


  @override
  void initState() {
    super.initState();
    _actionCounts = List<int>.generate(action.length, (index) => 0); // Initialize all counts to 0
  }

  @override
  Widget build(BuildContext context) {
    Scale scale = Scale(context as BuildContext);
    double playerContainerHeight = 40;
    return Scaffold(
      body: Row(
          children: [
          Expanded(
            //!TODO: Check the flex value 
            flex: 3,
            child: ListView.builder(
              itemCount: 11,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: (){
                    // addDummyData();
                    setState(() {
                      _selectedPlayer = index;
                      widget.titleNotifier.value = players[index];
                    });
                  },
                  child: _buildPlayerContainer(players[index], playerContainerHeight, _selectedPlayer==index)
                );
              },
            ),
          ),
          Expanded(
            //!TODO: Check the flex value 
            flex: 25,
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
                    return GestureDetector(
                      onTap: () => {
                        setState((){
                          _actionCounts[index]++; // Increment the count for this container
                        })
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          boxShadow:[
                            BoxShadow(
                              // color: Theme.of(context).colorScheme.background,
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
                                // color: Theme.of(context).colorScheme.onbackground,
                                color: Colors.grey[200],
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  _actionCounts[index].toString(), 
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 0,  
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

Widget _buildPlayerContainer(String name, double height, bool isSelected) {
  return FractionallySizedBox(
    alignment: Alignment.centerLeft,
    widthFactor: 1,
    child: Container(
      height: height,
      margin: EdgeInsets.symmetric(vertical: 5),
      color: isSelected? const Color(0xFF5E35B1) : Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey,
          ),
          SizedBox(width: 10,),
          Text(
            name,
            style: TextStyle(
              color:isSelected? Colors.white : const Color(0xFF5E35B1),
              fontSize: 16
            ),
          ), //!FIXME: Make this text dynamic to fit in container
          SizedBox(width: 10,),
          Text(
            '1',
            style: TextStyle(
              color:isSelected? Colors.white : const Color(0xFF5E35B1),
              fontSize: 16
            ),
          ),
        ],
      ),
    ),
  );
}
