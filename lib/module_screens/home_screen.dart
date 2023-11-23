import 'package:flutter/material.dart';
import 'package:notes_app/models/Note.dart';
import 'package:notes_app/module_screens/create_note.dart';
import 'package:notes_app/widgets/bottom_nav_bar.dart';
import 'package:notes_app/widgets/note_card.dart';
import 'package:notes_app/widgets/note_card_skeleton.dart';
import '../main.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{

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

  List <Note> notes = List.empty(growable: true);
  //List<String> categories = ['Home','Complete','Pending','Archived'];
  int _selectedIndex = 0;
  List<Note> filteredNotes = List.empty(growable: true);
  List<Note> filterNotesByCategory(String category) {
    return notes.where((note) => note.category == category).toList();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [Switch(value: themeManager.themeMode == ThemeMode.dark, onChanged: (newValue){
          themeManager.toggleTheme(newValue);
        })],
        title: Center(
          child: Text("Notes App",
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 26.0
            ),
          ),
        ),
      ),
      body: _selectedIndex == 0 ? (notes.isEmpty ? Center(
        child: Text(
          'Create notes using the button below.',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ) : ListView.builder(
        itemCount: notes.length,
        itemBuilder: loading ? (BuildContext context, int index){
            return noteSkeleton(context);
          } : (BuildContext context, int index){
            return NoteCard(note: notes[index], index: index, onNoteDeleted: onNoteDeleted, onCategoryChanged: onCategoryChanged, isEnabled: true);
            },
      )) : ListView.builder(
        itemCount: filteredNotes.length,
        itemBuilder: loading ? (BuildContext context, int index){
          return noteSkeleton(context);
        } : (BuildContext context, int index){
          return NoteCard(note: filteredNotes[index], index: index, onNoteDeleted: onNoteDeleted, onCategoryChanged: onCategoryChanged, isEnabled: false);
        },
      ),

      //ListViewBuilder(notes: notes, length: notes.length, context: context, onNoteDeleted: onNoteDeleted, onCategoryChanged: onCategoryChanged),
      bottomNavigationBar: BottomNavBar(
          selectedIndex: _selectedIndex,
          complete: categoryLength('Complete'),
          pending: categoryLength('Pending'),
          archive: categoryLength('Archive'),
          all: notes.length,
          onItemTapped: (int index) {
            loadData();
            setState(() {
              _selectedIndex = index;
              switch(index){
                case 1: filteredNotes = filterNotesByCategory('Complete'); break;
                case 2: filteredNotes = filterNotesByCategory('Pending'); break;
                case 3: filteredNotes = filterNotesByCategory('Archive'); break;
              }
            });
          },
      ),
      floatingActionButton: _selectedIndex == 0 ? FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
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

  int categoryLength(String newCategory){
    int len = 0;
    newCategory == 'Complete' ? len = notes.where((note) => note.category == 'Complete').toList().length :
    newCategory == 'Pending' ? len = notes.where((note) => note.category == 'Pending').toList().length:
    len = notes.where((note) => note.category == 'Archive').toList().length;
    return len;
  }
}
