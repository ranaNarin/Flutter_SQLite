import 'package:flutter/material.dart';
import 'package:flutter_sqlite/inherited_widgets/note_inherited_widget.dart';
import 'package:flutter_sqlite/providers/NoteProvider.dart';

enum NoteMode { Editing, Adding }

class Note extends StatefulWidget {
  final NoteMode noteMode;
  //final int index;
  final Map<String, dynamic> note;

  Note(this.noteMode, this.note);

  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();

  List<Map<String, String>> get _notes => NoteInheritedWidget.of(context).notes;

  @override
  void didChangeDependencies() {
    if(widget.noteMode==NoteMode.Editing) {
      _titleController.text = widget.note['title'];
      _textController.text = widget.note['text'];
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.noteMode == NoteMode.Adding ? 'Add note' : 'Edit note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(hintText: 'Note title'),
            ),
            Container(
              height: 8,
            ),
            TextField(
              controller: _textController,
              decoration: InputDecoration(hintText: 'Note text'),
            ),
            Container(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _NoteButton('Save', Colors.blue, () {
                  final title = _titleController.text;
                  final text = _textController.text;

                  if (widget?.noteMode == NoteMode.Adding) {
                   // _notes.add({'title': title, 'text': text});
                    NoteProvider.insertNote({
                      'title' : title,
                      'text' :text
                    });

                  } else if (widget?.noteMode == NoteMode.Editing) {
                    //_notes[widget.index] = {'title': title, 'text': text};
                    NoteProvider.updateNote({
                      'id': widget.note['id'],
                      'title' : _titleController.text,
                      'text': _textController.text,
                    });
                  }

                  Navigator.pop(context);
                }),
                Container(
                  height: 16.0,
                ),
                _NoteButton('Discard', Colors.grey, () {
                  Navigator.pop(context);
                }),
                Container(
                  height: 16.0,
                ),
                widget.noteMode == NoteMode.Editing
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _NoteButton('Delete', Colors.red, () async {
                         // _notes.removeAt(widget.index);
                          await NoteProvider.deleteNote(widget.note['id']);
                          Navigator.pop(context);
                        }))
                    : Container()
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _NoteButton extends StatelessWidget {
  final String _text;
  final Color _color;
  final Function _onPressed;

  _NoteButton(this._text, this._color, this._onPressed);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: _onPressed,
      child: Text(
        _text,
        style: TextStyle(color: Colors.white),
      ),
      minWidth: 100,
      color: _color,
    );
  }
}
