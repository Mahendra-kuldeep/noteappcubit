import 'package:bloc/bloc.dart';
import 'package:noteappcubit/Cubit/CubitState.dart';
import 'package:noteappcubit/DbHelper/DbHelper.dart';
import 'package:noteappcubit/notesmodel/noteModel.dart';
class NoteCubit extends Cubit<NoteState> {
  DbHelper dbHelper;

  NoteCubit({required this.dbHelper}) : super(initialState());

  addnotes(NoteModel noteModel) async {
    emit(loadingState());

    bool check = await dbHelper.insertnotes(noteModel);
    if (check) {
      final notes = await dbHelper.getData();
      emit(loadedState(notelist: notes));
    }
    else{
      emit(errorState(message: "an error"));
    }
  }

  getallnotes() async {
    emit(loadingState());
    var notes = await dbHelper.getData();
    emit(loadedState(notelist: notes));
  }

  deleteNotes(int id) async {
    emit(loadingState());

    bool check = await dbHelper.deletenotes(id);

    if (check) {
      final notes = await dbHelper.getData();
      emit(loadedState(notelist: notes));
    }
    else{
      emit(errorState(message: "an erroe"));
    }
  }
  Future<void>updatenotes(int id,String title,String desc)async{
    bool check =await dbHelper.updatenotes(NoteModel(id:id,title: title, desc: desc));
    if(check){
      emit(loadedState(notelist: await dbHelper.getData()));
    }
    else{
      print("Data Note Found");
    }
  }
}

