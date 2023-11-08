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
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.secondary,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          'Note View',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
              fontSize: 26.0
          ),
        ),
        actions: [
          IconButton(
            color: Theme.of(context).colorScheme.secondary,
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
              style: TextStyle(
                fontSize: 28,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              note.body,
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
