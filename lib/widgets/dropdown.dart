import 'package:flutter/material.dart';
import '../models/Note.dart';
class DropDown extends StatefulWidget {
  const DropDown({super.key, required this.note, required this.onCategoryChanged, required this.index, required this.isEnabled});
  final Note note;
  final int index;
  final Function(String, int) onCategoryChanged;
  final bool isEnabled;

  @override
  State<DropDown> createState() => _DropDownState();
}
class _DropDownState extends State<DropDown> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      style: TextStyle(
        color: Theme.of(context).colorScheme.secondary,
      ),
      value: widget.note.category.isNotEmpty ? widget.note.category : null,
      hint: const Text("Select a category"),
      items: const [
        DropdownMenuItem(
          value: "Complete",
          child: Text("Complete"),
        ),
        DropdownMenuItem(
          value: "Pending",
          child: Text("Pending"),
        ),
        DropdownMenuItem(
          value: "Archive",
          child: Text("Archive"),
        ),
      ],
      onChanged: widget.isEnabled ? (String? newValue) {
        if (newValue != null && newValue.isNotEmpty) {
            widget.note.category = newValue; // Update the note's category.
            widget.onCategoryChanged(newValue, widget.index);
        }
      } : null,
    );
  }
}


