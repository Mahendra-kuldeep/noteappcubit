import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteappcubit/Cubit/CubitState.dart';
import 'package:noteappcubit/Cubit/addNoteCubit.dart';
import 'package:noteappcubit/notesmodel/noteModel.dart';

import '../UiHelper/Uihelper.dart';
class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteCubit,NoteState>(
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
              title: Text("My Note",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),),
              centerTitle: true,
              backgroundColor: Colors.blue
          ),
          body: Column(
            children: [
              TextField(
                controller: titleController,
                style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Title",
                    prefixIcon: Icon(Icons.title)
                ),
              ),
              TextField(
                controller: descController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Your Story",
                    prefixIcon: Icon(Icons.description)
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(onPressed: (){
            var title = titleController.text.toString();
            var desc = descController.text.toString();
            if(title=="" && desc==""){
              setState(() {
                showDialog(context: context, builder: (BuildContext context){
                  return AlertDialog(
                    title: Text("Warning"),
                    content: Text("Please file required fields"),
                    actions: [
                      Row(
                        children: [
                          TextButton(onPressed: (){
                            Navigator.of(context).pop();
                          }, child: Text("Ok"))
                        ],
                      ),
                    ]
                  );
                });
              });
            }
            else{
              context.read<NoteCubit>().addnotes(NoteModel(title: title, desc: desc));
              context.read<NoteCubit>().getallnotes();
              Navigator.of(context).pop();
            }
          },backgroundColor: Colors.blue,splashColor: Colors.white,
            label:Text("Save Note",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),icon: Icon(Icons.save),),
        );
      },
    );
  }
}
