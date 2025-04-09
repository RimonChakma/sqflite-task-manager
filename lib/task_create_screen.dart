import 'package:flutter/material.dart';

class TaskCreateScreen extends StatelessWidget {
   TaskCreateScreen({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
            controller: ageController,
            decoration: InputDecoration(
            hintText: "age"
          ),),
          SizedBox(height: 10,),
          ElevatedButton(onPressed: (){}, child: Text("saves")),
        ],
      ),),
    );
  }
}
