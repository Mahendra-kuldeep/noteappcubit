import 'package:bloc/bloc.dart';

import '../notesmodel/noteModel.dart';

abstract class NoteState{}

class initialState extends NoteState{}

class loadingState extends NoteState{}

class loadedState extends NoteState{
  List<NoteModel>notelist = [];
  int? id;
  loadedState({required this.notelist,this.id});
}

class errorState extends NoteState{
  String message="an error accurd";
  errorState({required this.message});
}
