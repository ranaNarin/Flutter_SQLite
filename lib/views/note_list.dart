import 'package:flutter/material.dart';
import 'package:flutter_sqlite/views/note.dart';

class NoteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Note(NoteMode.Editing)));
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 30.0, bottom: 30.0, left: 13.0, right: 22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _NoteTitle(),
                  Container(
                    height: 4,
                  ),
                  _NoteText()
                ],
              ),
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Note(NoteMode.Adding)));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _NoteTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Some tilte',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    );
  }
}

class _NoteText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'I have a reference of Fresher with 6 months training. Profile- Mean Stack (Angular,Node,Express,MongoDB). Candidate is technically strong and have good interpersonal skills.Interested can share their e-mail id.Preferred location - Mohali,Chandigarh.',
      style: TextStyle(color: Colors.grey.shade600),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
