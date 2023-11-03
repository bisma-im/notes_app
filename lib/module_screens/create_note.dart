import 'package:flutter/material.dart';
import 'package:notes_app/models/Note.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key,required this.onNewNoteCreated});
  final Function(Note) onNewNoteCreated;
  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {

  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              style: const TextStyle(
                fontSize: 28
              ),
              decoration: const InputDecoration(
                hintText: "Title",
              ),
            ),
            TextFormField(
              controller: bodyController,
              style: const TextStyle(
                  fontSize: 18
              ),
              decoration: const InputDecoration(
                hintText: "Body",
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(titleController.text.isEmpty){
            return;
          }
          if(bodyController.text.isEmpty){
            return;
          }
          final note = Note(
            title: titleController.text,
            body: bodyController.text,
          );
          widget.onNewNoteCreated(note);
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
