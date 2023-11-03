import 'package:flutter/material.dart';
import 'package:notes_app/models/Note.dart';

class NoteView extends StatelessWidget {
  const NoteView({super.key, required this.note, required this.index, required this.onNoteDeleted});
  final Function(int) onNoteDeleted;
  final Note note;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note View'),
        actions: [
          IconButton(
              onPressed: (){
                showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        title: Text("Are you sure you want to delete the note ${note.title}?"),
                        actions: [
                          TextButton(
                              onPressed: (){
                                Navigator.of(context).pop();
                                onNoteDeleted(index);
                                Navigator.of(context).pop();
                              },
                              child: const Text("Yes"),
                          ),
                          TextButton(
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                            child: const Text("No"),
                          ),
                        ],
                      );
                    },
                );
              },
              icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: const TextStyle(
                  fontSize: 28
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              note.body,
              style: const TextStyle(
                  fontSize: 18
              ),
            ),
          ],
        ),
      ),
    );
  }
}
