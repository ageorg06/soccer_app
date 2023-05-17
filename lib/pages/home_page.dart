import 'package:flutter/material.dart';
import 'package:next_gen_first_app/utils/scale.dart';

class HomePage extends StatelessWidget {
 const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    Scale scale = Scale(context as BuildContext);
    return Container(
      child: Text("This is Home Page", style: TextStyle(fontSize:scale.width(200) ),),
    );
  }
}
