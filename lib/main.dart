
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_task_manager/task_create_screen.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async{
    if(_database!=null) return _database!;
    _database =await initializeDB();
    return _database!;
  }

  Future<Database> initializeDB() async {
   String path = await getDatabasesPath();
   return openDatabase(
     join(path,"user.db"),
     onCreate: (db, version) async {
       await db.execute(
         "CREATE TABLE user (id integer primary key, text name, integer age)"
       );
     },
     version: 1
   );
  }

  Future<int> insertUser (String name, int age) async {
    final db = await database;
    return db.insert("user", {"name":name,"age":age});
  }

  Future<List<Map<String,dynamic>>> getUser (String name , int age)async {
    final db = await database;
    return db.query("user");
  }

}



class TaskCubit extends Cubit<List<Map<String,dynamic>>> {
  final DatabaseHelper databaseHelper;
  TaskCubit(this.databaseHelper):super([]){

  }

  void addUser (String name, int age)  {
   databaseHelper.insertUser(name, age);
  }
}


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => TaskCubit(DatabaseHelper()),child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TaskScreen(),
    ),);
  }
}

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Task Manager"),),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => TaskCreateScreen(),));
      },child: Icon(Icons.add),),
    );
  }
}
