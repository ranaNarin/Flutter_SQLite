import 'package:flutter/material.dart';

class NoteInheritedWidget extends InheritedWidget {

  final notes=[
    {
      'title': 'someTitle1',
      'text': 'someText1'
    },{
      'title': 'someTitle2',
      'text': 'someText'
    },{
      'title': 'someTitle',
      'text': 'someText'
    },{
      'title': 'someTitle',
      'text': 'someText'
    },
  ];

  NoteInheritedWidget(Widget child):super(child:child);


  static  NoteInheritedWidget of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(NoteInheritedWidget) as NoteInheritedWidget);
  }

  @override
  bool updateShouldNotify(NoteInheritedWidget oldWidget) {
    return oldWidget.notes !=notes;
  }
}