import 'package:flutter/material.dart';
import 'package:notes_app/models/Note.dart';
import 'package:notes_app/module_screens/create_note.dart';
import 'package:notes_app/widgets/note_card.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
  List <Note> notes = List.empty(growable: true);
  List<String> categories = ['Home','Complete','Pending','Archived'];
  int _selectedIndex = 0;
  List<Note> filteredNotes = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    List<Note> filterNotesByCategory(String category) {
      return notes.where((note) => note.category == category).toList();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Notes App",
          style: TextStyle(
            color: Colors.tealAccent,
            fontSize: 26.0
            ),
          ),
        ),
      ),
      body: _selectedIndex == 0 ? (notes.isEmpty ? const Center(
        child: Text('Create notes using the button below.'),
      ) : ListView.builder(
        itemCount: notes.length,
        itemBuilder: (BuildContext context, int index){
          return NoteCard(note: notes[index], index: index, onNoteDeleted: onNoteDeleted, onCategoryChanged: onCategoryChanged, isEnabled: true);
        },
      )) : ListView.builder(
        itemCount: filteredNotes.length,
        itemBuilder: (BuildContext context, int index){
          return NoteCard(note: filteredNotes[index], index: index, onNoteDeleted: onNoteDeleted, onCategoryChanged: onCategoryChanged, isEnabled: false);
        },
      ),

      //ListViewBuilder(notes: notes, length: notes.length, context: context, onNoteDeleted: onNoteDeleted, onCategoryChanged: onCategoryChanged),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done_all),
            label: 'Complete',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pending),
            label: 'Pending',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive),
            label: 'Archive',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.tealAccent,
        iconSize: 30.0,
        selectedFontSize: 20.0,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
            switch(index){
              case 1: filteredNotes = filterNotesByCategory('Complete');
              case 2: filteredNotes = filterNotesByCategory('Pending');
              case 3: filteredNotes = filterNotesByCategory('Archive');
            }
          });
        },
      ),
      floatingActionButton: _selectedIndex == 0 ? FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateNote(onNewNoteCreated: onNewNoteCreated)));
        },
        child: const Icon(Icons.add),
      ) : null,
    );
  }
  void onNewNoteCreated(Note note){
    setState(() {
      notes.add(note);
    });
  }
  void onNoteDeleted(int index){
    notes.removeAt(index);
    setState(() {});
  }
  void onCategoryChanged(String newCategory, int index) {
    setState(() {
      notes[index].category = newCategory;
    });
  }
}
