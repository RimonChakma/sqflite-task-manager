import 'package:flutter/material.dart';

class TaskCreateScreen extends StatelessWidget {
   TaskCreateScreen({super.key});

  TextEditingController addController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Screen"),centerTitle: true,),
      body: Padding(padding: EdgeInsets.all(10),child: Column(
        children: [
          TextField(
            controller: addController,
            decoration: InputDecoration(
            hintText: "name"
          ),),
          SizedBox(height: 10,),
          TextField(
            controller: addController,
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
