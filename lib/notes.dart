import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:session7/add_note_screen.dart';
import 'package:session7/edit_note_screen.dart';
import 'package:session7/login_screen.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {

  final noteController  = TextEditingController();

  final firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> notes = [];

  @override
  void initState() {
    super.initState();
    getNotesFromFireStore();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          navigateToAddNoteScreen();
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(context,
              MaterialPageRoute(
                builder: (context) => const MyLoginScreen(),
              ),
            );
          },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
        title: const Text(
          "Note App",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return noteItem(index);
            }
        ),
      ),
    );
  }
  Widget noteItem(int index){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              notes[index]["note"],
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          IconButton(
            onPressed: (){
              navigateToEditNoteScreen(index);
            },
            icon: const Icon(
                Icons.edit
            ),
          ),
          IconButton(onPressed: (){
            firestore.collection("notes").doc(notes[index]["id"]).delete();
            notes.removeAt(index);
            setState(() {});
          },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  void getNotesFromFireStore(){
    firestore.collection("notes").snapshots().listen((event) {
      notes.clear();
      for(var document in event.docs){
        final note = document.data();
        notes.add(note);
      }
      setState(() {

      });
    });
  }

  void navigateToAddNoteScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>  const AddNoteScreen(),
      ),
    ).then((value){
      getNotesFromFireStore();
    });
  }

   navigateToEditNoteScreen(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>   EditNoteScreen(id: notes[index]['id'],),
      ),
    ).then((value) async {
      print("NotesScreen => $value");
      if (value == null) return;
      // notes.removeAt(index);
      // notes.insert(index, value);
       notes[index] = value;
      setState(() {});

    });
  }

}
