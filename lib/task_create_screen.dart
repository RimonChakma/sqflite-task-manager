import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_task_manager/main.dart';

class TaskCreateScreen extends StatelessWidget {
   final Map<String,dynamic>?result;
   TaskCreateScreen({super.key, this.result,});

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    if(result !=null){
      nameController.text = result !["name"];
      ageController.text = result !["age"].toString();
    }

    return Scaffold(
      appBar: AppBar(title: Text("Create Screen"),centerTitle: true,),
      body: Padding(padding: EdgeInsets.all(10),child: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
            hintText: "name"
          ),),
          SizedBox(height: 10,),
          TextField(
            keyboardType: TextInputType.number,
            controller: ageController,
            decoration: InputDecoration(
            hintText: "age"
          ),),
          SizedBox(height: 10,),
          ElevatedButton(onPressed: (){
          final nameData = nameController.text;
          final ageData = int.tryParse(ageController.text);

          if(result == null){
            context.read<TaskCubit>().addUser(nameData, ageData!);
          }else{
            context.read<TaskCubit>().updateUser(result!["id"], nameData,ageData!);
          }
          Navigator.pop(context);
          }, child: Text("saves")),
        ],
      ),),
    );
  }
}
