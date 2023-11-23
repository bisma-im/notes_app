import 'package:flutter/material.dart';
import 'package:notes_app/models/Note.dart';
import 'package:notes_app/widgets/create_view_note_skeleton.dart';

class NoteView extends StatefulWidget {
  const NoteView({super.key, required this.note, required this.index, required this.onNoteDeleted});
  final Function(int) onNoteDeleted;
  final Note note;
  final int index;

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future loadData() async{
    setState(() {
      loading = true;
    });

    await Future.delayed(const Duration(seconds: 4), (){
      setState(() {
        loading = false;
      });
    });
  }
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
                        title: Text("Are you sure you want to delete the note ${widget.note.title}?"),
                        actions: [
                          TextButton(
                              onPressed: (){
                                Navigator.of(context).pop();
                                widget.onNoteDeleted(widget.index);
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
      body: loading ? NoteSkeleton(context) : Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.note.title,
              style: TextStyle(
                fontSize: 28,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.note.body,
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
