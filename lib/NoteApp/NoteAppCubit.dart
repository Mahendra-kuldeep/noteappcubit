import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noteappcubit/Cubit/CubitState.dart';
import 'package:noteappcubit/Cubit/addNoteCubit.dart';
import 'package:noteappcubit/UiHelper/Uihelper.dart';

import 'AddNotePager.dart';
import 'Updatenote.dart';

class NoteApp extends StatefulWidget {
  const NoteApp({super.key});

  @override
  State<NoteApp> createState() => _NoteAppState();
}

class _NoteAppState extends State<NoteApp> {
  @override
  void initState() {
    super.initState();
    context.read<NoteCubit>().getallnotes();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Note",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),),
          centerTitle: true,
          backgroundColor: Colors.blue
        ),
      body:BlocBuilder<NoteCubit,NoteState>(
          builder: (context,state){
        if(state is loadingState){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        else if(state is loadedState){
          return ListView.builder(itemBuilder: (context,index){
            return InkWell(
              onLongPress: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdatNoteView(utitle: state.notelist[index].title,udesc: state.notelist[index].desc,uid: state.notelist[index].id,)));
                Navigator.of(context).pop();
              },
              child: Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.grey),
                child: Center(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text("${state.notelist[index].id}"),
                    ),
                    title: Text("${state.notelist[index].title}"),
                    subtitle: Text("${state.notelist[index].desc}"),
                    trailing: IconButton(onPressed: (){
                      context.read<NoteCubit>().deleteNotes(state.notelist[index].id!);
                    }, icon: Icon(Icons.delete_forever_outlined)),
                  ),
                )
              ),
            );
          },
            itemCount: state.notelist.length,);
        }
        else if(state is errorState){
          return Center(
            child: Text("${state.message.toString()}"),);
        }
        else{
          return Container();
        }

      }
      ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNotes()));
        },child: Icon(FontAwesomeIcons.plus),),
    );
  }
}
