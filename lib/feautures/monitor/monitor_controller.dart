class MonitorController {
  int selectedPlayer = 0;
  late List<int> actionCounts;
  final List<String> action;
  final List<String> players = List<String>.generate(11, (index) => 'Player ${index + 1}');

  MonitorController() : action = List<String>.generate(22, (index) => 'Action ${index+1}');

  void initializeActionCounts() {
    actionCounts = List<int>.generate(action.length, (index) => 0);
  }

  void selectPlayer(int index) {
    selectedPlayer = index;
  }

  void incrementActionCount(int index) {
    actionCounts[index]++;
  }
}
