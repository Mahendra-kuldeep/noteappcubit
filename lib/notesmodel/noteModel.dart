import 'package:noteappcubit/DbHelper/DbHelper.dart';

class NoteModel{
  int? id;
  String title;
  String desc;

  NoteModel({required this.title,required this.desc,this.id});

  factory NoteModel.formMap(Map<String,dynamic>map){
    return NoteModel(title: map[DbHelper.note_title], desc: map[DbHelper.note_desc],id: map[DbHelper.note_id]);
  }
  Map<String ,dynamic>toMap(){
    return {
      DbHelper.note_id:id,
      DbHelper.note_title:title,
      DbHelper.note_desc:desc
    };
  }
}