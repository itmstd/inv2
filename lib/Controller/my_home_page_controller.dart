import 'package:get/get.dart';
import 'package:inv2/Controller/todo_db.dart';
import 'dart:io';

import '../Model/todo.dart';

class MyHomePageController extends GetxController {

  RxBool isLoaded = false.obs;

  String test = "";

  TodoDb db = TodoDb();
  late List<Todo> todos;
  RxList<bool> completed = <bool>[].obs;
  RxList<String> timeLeftList = <String>[].obs;

  @override
  void onInit(){
    super.onInit();
    test = "initialized";
    getToDoList(null); //comment this when unit testing
  }

  //grab To-Do list from Sembast
  Future getToDoList(Directory? direction) async {
    isLoaded.value = false;
    completed = <bool>[].obs;
    timeLeftList = <String>[].obs;
    await db.getTodos(null);
    todos = await db.getTodos(null);

    if (todos.isNotEmpty){
      // print("sini");
      isLoaded.value = true;
      for(Todo todo in todos){
        timeLeftList.add(timeLeft(todo));
        completed.add(todo.completed);
      }
      // print(timeLeftList);
      return todos;
    } else {
      // print("sana");
      isLoaded.value = true;
      return Future.error("No data");
    }
  }

  //update the To-Do information into Sembast
  void updateTodo(Todo todo) async{
    TodoDb db = TodoDb();
    await db.database;

    todo.completed = !todo.completed;

    await db.updateTodo(todo);

    getToDoList(null);
  }

  //to calculate time left from the end date of the To-Do list
  String timeLeft(Todo todo) {
    // Duration duration = DateTime.parse(todo.endDate).difference(DateTime.parse(todo.startDate)); //for unit testing
    Duration duration = DateTime.parse(todo.endDate).difference(DateTime.now()); //for app operation
    return("${duration.toString().split(":")[0]} hrs ${duration.toString().split(":")[1]} min");
  }
}