import 'package:flutter/material.dart';
import '../../core/models/user.dart';
import 'user_controller.dart';

class UserPage extends StatefulWidget {
  final String userId;
  const UserPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final UserController _userController = UserController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Details")),
      body: StreamBuilder<User>(
        stream: _userController.getUserStream(widget.userId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData && snapshot.data != null) {
            User user = snapshot.data!;
            return Column(
              children: [
                ListTile(
                  title: Text("Email: ${user.email}"),
                  subtitle: Text("Username: ${user.username}"),
                ),
                ListTile(
                  title: Text("Team ID: ${user.teamId ?? 'No team assigned'}"),
                ),
              ],
            );
          }
          return Center(child: Text("User details not available. Please try again later."));
        },
      ),
    );
  }
}
