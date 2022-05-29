import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inv2/Controller/todo_db.dart';

import '../Model/todo.dart';

class AddToDoController extends GetxController{

  TextEditingController toDoTitle = TextEditingController();
  RxString startDate = "".obs;
  RxString endDate = "".obs;

  // @override
  // void onInit(){
  //   super.onInit();
  // }

  @override
  void onClose(){
    toDoTitle.dispose();
    super.onClose();
  }

  void datePicker(BuildContext context, int index) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (picked != null) {
      if (index == 1){
        startDate.value = picked.toString().split(" ").first;
      } else if (index == 2){
        endDate.value = picked.toString().split(" ").first;
      }
    }
  }

  //insert new entry into Sembast
  void addNew() async {
    if(toDoTitle.text != "" && startDate.value != "" && endDate.value != "") {
      TodoDb db = TodoDb();
      await db.database;

      await db.insertTodo(Todo(
          toDoTitle.text, DateTime.parse(startDate.value).toString(),
          DateTime.parse(endDate.value).toString(), false));
      Get.back();
    } else {
      Get.snackbar("Need to fill up all fields", "", snackPosition: kIsWeb ? SnackPosition.TOP : SnackPosition.BOTTOM);
    }

  }

  //update existing entry into Sembast
  void updateTodo(Todo todo) async{
    if(toDoTitle.text != "" && startDate.value != "" && endDate.value != "") {
      TodoDb db = TodoDb();
      await db.database;

      todo.todoTitle = toDoTitle.text;
      todo.startDate = DateTime.parse(startDate.value).toString();
      todo.endDate = DateTime.parse(endDate.value).toString();

      await db.updateTodo(todo);

      Get.back();
    } else {
      Get.snackbar("Need to fill up all fields", "", snackPosition: kIsWeb ? SnackPosition.TOP : SnackPosition.BOTTOM);
    }
  }
}