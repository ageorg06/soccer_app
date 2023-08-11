import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MonitorPage extends StatefulWidget {
  final ValueNotifier<String> titleNotifier;

  const MonitorPage({Key? key, required this.titleNotifier}) : super(key: key);

  @override
  _MonitorPageState createState() => _MonitorPageState();
}

class _MonitorPageState extends State<MonitorPage> {
  int _selectedPlayer = 0;
  late List<int> _actionCounts;
  final List<String> action;
  final List<String> players = List<String>.generate(11, (index) => 'Player ${index + 1}');

  final int numberOfActions = 22;

  _MonitorPageState() : action = List<String>.generate(22, (index) => 'Action ${index+1}');
  @override
  void initState() {
    super.initState();
    _actionCounts = List<int>.generate(action.length, (index) => 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _buildPlayerList(),
          _buildActionGrid(context),
        ],
      ),
    );
  }

Expanded _buildPlayerList() {
  return Expanded(
    flex: 3,
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red, width: 2), // To visualize the container
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          print("Height of the player list container: ${constraints.maxHeight}"); // Print the height

          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: players.length,
            itemBuilder: (BuildContext context, int index) {
              return _PlayerContainer(
                name: players[index],
                isSelected: _selectedPlayer == index,
                onTap: () {
                  setState(() {
                    _selectedPlayer = index;
                    widget.titleNotifier.value = players[index];
                  });
                },
              );
            },
          );
        },
      ),
    ),
  );
}


Expanded _buildActionGrid(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  //we assume each action should be 100 pixels
  int numColumns = (screenHeight / 100).floor();

  // Compute the number of rows based on the number of actions and columns
  int numRows = (action.length / numColumns).ceil(); 

  double childWidth = screenWidth / numColumns;
  double childHeight = (screenHeight * 5/8) / numRows;
  double childAspectRatio = childWidth / childHeight ;

  return Expanded(
    flex: 25,
    child: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: numColumns,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: action.length,
      itemBuilder: (BuildContext context, int index) {
        return _ActionContainer(
          actionName: action[index],
          actionCount: _actionCounts[index],
          onTap: () {
            setState(() {
              _actionCounts[index]++;
            });
          },
        );
      },
    ),
  );
}
}

class _PlayerContainer extends StatelessWidget {
  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  const _PlayerContainer({required this.name, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        color: isSelected ? const Color(0xFF5E35B1) : Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CircleAvatar(radius: 20, backgroundColor: Colors.grey),
            const SizedBox(width: 10),
            Text(
              name,
              style: TextStyle(color: isSelected ? Colors.white : const Color(0xFF5E35B1), fontSize: 16),
            ),
            const SizedBox(width: 10),
            Text(
              '1',
              style: TextStyle(color: isSelected ? Colors.white : const Color(0xFF5E35B1), fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionContainer extends StatelessWidget {
  final String actionName;
  final int actionCount;
  final VoidCallback onTap;

  const _ActionContainer({required this.actionName, required this.actionCount, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
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
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  actionCount.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Container(
                color: Colors.grey[200],
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  actionName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
