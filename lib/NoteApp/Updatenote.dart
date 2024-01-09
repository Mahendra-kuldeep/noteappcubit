import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteappcubit/Cubit/CubitState.dart';
import 'package:noteappcubit/Cubit/addNoteCubit.dart';
import 'package:noteappcubit/notesmodel/noteModel.dart';

class UpdatNoteView extends StatefulWidget {
  String utitle;
  String udesc;
  int? uid;
  UpdatNoteView({required this.utitle,required this.udesc,this.uid});

  @override
  State<UpdatNoteView> createState() => _UpdatNoteViewState();
}

class _UpdatNoteViewState extends State<UpdatNoteView> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteCubit,NoteState>(
      builder: (context,state){
        return Scaffold(
            appBar: AppBar(
              title: Text("Note View",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
              centerTitle: true,
              backgroundColor: Colors.blue,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
              child: Column(
                children: [
                  Text("${widget.utitle}",style: TextStyle(
                    fontSize: 17,fontWeight: FontWeight.bold,
                  ),maxLines: 10,),
                  SizedBox(height: 10,),
                  TextField(
                    decoration: InputDecoration(
                      hintText: widget.udesc
                    ),
                  ),
                  Text("${widget.udesc}",maxLines: null,)
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(onPressed: (){
              BlocProvider.of<NoteCubit>(context).updatenotes(widget.uid!,titleController.text.toString(),descController.text.toString());
              Navigator.of(context).pop();
            },backgroundColor: Colors.blue,splashColor: Colors.white, label: Text("Update Note"),
              icon: Icon(Icons.edit),
            ),
        );
        },
    );
  }
}
