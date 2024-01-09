import 'dart:io';
import 'dart:ui';

import 'package:noteappcubit/notesmodel/noteModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper{
  DbHelper._();
  static final DbHelper instence = DbHelper._();
  static const note = "notetable";
  static const note_id = "noteid";
  static const note_title = "notetitle";
  static const note_desc="notedesc";
  Database? _database;

  Future<Database>getDb()async{
    if(_database!=null){
      return _database!;
    }
    else{
      return await initDb();
    }
  }

  Future<Database>initDb()async{
    Directory directory = await getApplicationDocumentsDirectory();
    var dbpath = join(directory.path+"opendb.db");
    return await openDatabase(dbpath,version: 1,onCreate: (db,version){
      return db.execute("create table $note($note_id integer primary key autoincrement $note_title text , $note_desc text)");
    });
  }
  insertnotes(NoteModel noteModel)async{
    var db = await getDb();
    await db.insert(note, noteModel.toMap());
  }

  Future<List<NoteModel>>getData()async{
    var db = await getDb();
    List<NoteModel>notelist = [];
    var data  = await db.query(note);
    for(Map<String,dynamic>eachData in data){
      NoteModel noteModel = NoteModel.formMap(eachData);
      notelist.add(noteModel);
    }
    return notelist;
  }
  Future<bool>updatenotes(NoteModel notes)async{
    var db = await getDb();
    var count = await db.update(note, notes.toMap(),where:"$note_id = ${notes.id}");
    return count>0;
  }

  Future<bool>deletenotes(int id)async{
    var db = await getDb();
    var count = await db.delete(note,where: "$note_id=?",whereArgs: [id]);
    return count>0;
  }
}