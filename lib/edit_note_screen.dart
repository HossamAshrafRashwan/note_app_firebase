import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({Key? key, required this.id}) : super(key: key);
final String id;
  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final noteController = TextEditingController();

  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Note",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextFormField(
              controller: noteController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Note",
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  editNote();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                child: const Text("Edit Note"),
              ),
            )
          ],
        ),
      ),
    );
  }

  void editNote() async {
    String note = noteController.text;

    if (note.isEmpty) return;


    Map<String, dynamic> data = {
      "note" : note,
    };


    await firestore.collection("notes").doc(widget.id).update(data);
  }
}