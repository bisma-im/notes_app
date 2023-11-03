import 'package:flutter/material.dart';
import 'package:notes_app/models/Note.dart';
import 'package:notes_app/module_screens/note_view.dart';
import 'package:notes_app/widgets/dropdown.dart';

class NoteCard extends StatefulWidget {
  const NoteCard({super.key, required this.note, required this.index, required this.onNoteDeleted,required this.onCategoryChanged, required this.isEnabled});
  final Note note;
  final int index;
  final Function(int) onNoteDeleted;
  final Function(String, int) onCategoryChanged;
  final bool isEnabled;

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> NoteView(note: widget.note, index: widget.index, onNoteDeleted: widget.onNoteDeleted)));
        },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  widget.note.title,
                  style: const TextStyle(
                      fontSize: 18
                  ),
                ),
                trailing: DropDown(
                    note: widget.note,
                    onCategoryChanged: widget.onCategoryChanged,
                    index: widget.index,
                    isEnabled: widget.isEnabled,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.note.body,
                style: const TextStyle(
                    fontSize: 18
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
