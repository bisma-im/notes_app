import 'package:flutter/material.dart';
import 'package:notes_app/models/Note.dart';
import '../widgets/create_view_note_skeleton.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key,required this.onNewNoteCreated});
  final Function(Note) onNewNoteCreated;
  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
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
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Note"),
      ),
      body: loading ? NoteSkeleton(context) : Padding(
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
        backgroundColor: Theme.of(context).colorScheme.primary,
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
