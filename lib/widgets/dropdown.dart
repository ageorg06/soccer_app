import 'package:flutter/material.dart';

class CustomDropDown<T> extends StatefulWidget {
  final List<T> options;
  final Function(T) onSelected;
  const CustomDropDown({super.key, required this.options, required this.onSelected});

  @override
  _CustomDropDownState<T> createState() => _CustomDropDownState<T>();
}

class _CustomDropDownState<T> extends State<CustomDropDown<T>> {
  late T dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.options[0];
  }
  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style:  TextStyle(color: Theme.of(context).colorScheme.onBackground),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (T? newValue) {
        setState(() {
          dropdownValue = newValue!;
          widget.onSelected(newValue);
        });
      },
      items: widget.options.map<DropdownMenuItem<T>>((T value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Text(value.toString()),
        );
      }).toList()
    );
  }
}