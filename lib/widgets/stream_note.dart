import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:checkmate/widgets/task_widgets.dart';

import '../data/firestor.dart';

class Stream_note extends StatelessWidget {
  bool done;
  Stream_note(this.done, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirestoreDatasource().stream(done),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final noteslist = FirestoreDatasource().getNotes(snapshot);
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final note = noteslist[index];
              return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    FirestoreDatasource().deletNote(note.id);
                  },
                  child: Task_Widget(note));
            },
            itemCount: noteslist.length,
          );
        });
  }
}
