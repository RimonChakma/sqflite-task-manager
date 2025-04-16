
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
      onCreate: (db, version) async{
        await db.execute(
            "CREATE TABLE user (id INTEGER PRIMARY KEY, name TEXT, age INTEGER)"
        );
      },
      version: 1
    );
 }

  Future<int> insertUser (String name, int age) async {
    final db = await database;
    return db.insert("user", {"name":name,"age":age});
  }

  Future<List<Map<String,dynamic>>> getUser ()async {
    final db = await database;
    return db.query("user");
  }

  Future<int> deleteUser(int id) async {
    final db = await database;
    return db.delete("user",where: "id =?",whereArgs: [id]);
  }

  Future<int> updateUser(int id, String name, int age) async {
    final db = await database;
    return db.update(
      "user",
      {"name": name, "age": age},
      where: "id = ?",
      whereArgs: [id],
    );
  }


}



class TaskCubit extends Cubit<List<Map<String,dynamic>>> {
  final DatabaseHelper databaseHelper;
  TaskCubit(this.databaseHelper):super([]){
    fetchData();
  }

  void fetchData () async{
   final users = await databaseHelper.getUser();
   emit(users);
  }

  void addUser (String name, int age) async {
   await databaseHelper.insertUser(name, age);
   fetchData();
  }

  void deleteData (int id)async {
    await databaseHelper.deleteUser(id);
    fetchData();
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
      body: BlocBuilder <TaskCubit,List<Map<String,dynamic>>> (builder: (context, state) {
        if(state.isEmpty){
          return Center(child: Text("task is not available"),);
        }else{
          return  ListView.builder(
            itemCount: state.length,
            itemBuilder: (context, index) {
              final result = state[index];
              return ListTile(
                title: Text(result["name"]),
                subtitle: Text(result["age"].toString()),
                trailing: IconButton(onPressed: (){
                  context.read<TaskCubit>().deleteData(result["id"]);
                }, icon: Icon(Icons.delete)),
              );
            },);
        }
      },),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => TaskCreateScreen(),));
      },child: Icon(Icons.add),),
    );
  }
}
