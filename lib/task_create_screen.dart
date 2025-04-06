import 'package:flutter/material.dart';

class TaskCreateScreen extends StatelessWidget {
  const TaskCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Screen"),centerTitle: true,),
      body: Padding(padding: EdgeInsets.all(10),child: Column(
        children: [
          TextField(decoration: InputDecoration(
            hintText: "name"
          ),),
          SizedBox(height: 10,),
          TextField(decoration: InputDecoration(
            hintText: "age"
          ),)
        ],
      ),),
    );
  }
}
