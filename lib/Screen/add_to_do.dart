import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inv2/Controller/add_to_do_controller.dart';

import '../Model/todo.dart';

class AddToDoScreen extends StatelessWidget {
  final Todo? todoUpdate;
  final bool taskCompleted;
  // final String todoTitle;
  // final String startDate;
  // final String endDate;

  const AddToDoScreen({
    this.todoUpdate, this.taskCompleted = false
    // this.todoTitle = "",
    // this.startDate = "",
    // this.endDate = ""
  });

  @override
  Widget build(BuildContext context) {

    //Dependency injection
    AddToDoController controller = Get.put(AddToDoController());
    controller.toDoTitle.text = todoUpdate == null ? "" : todoUpdate!.todoTitle;
    controller.startDate.value = todoUpdate == null ? "" : todoUpdate!.startDate;
    controller.endDate.value = todoUpdate == null ? "" : todoUpdate!.endDate;

    //Build Page Widget
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffffbe23),
          title: const Text("Add new To-Do List", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.chevron_left, size: 28, color: Colors.black87,),
          ),
        ),
        body: Obx(() => body(controller)),
        bottomNavigationBar: taskCompleted == true ? const SizedBox() : TextButton(
          onPressed: () => todoUpdate == null ? controller.addNew() : controller.updateTodo(todoUpdate!),
          child: Text(todoUpdate == null ? "Create Now" : "Update To-Do", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
          style: TextButton.styleFrom(
            fixedSize: const Size(double.infinity,60),
            backgroundColor: Colors.black
          ),
        ),
      ),
    );
  }

  Widget body(AddToDoController controller) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30,),
          const Text("To-Do Title", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 18),),
          const SizedBox(height: 10,),
          TextFormField(
            controller: controller.toDoTitle,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Please key in your To Do title here',
            ),
            maxLines: 5,
          ),
          const SizedBox(height: 20,),
          const Text("Start Date", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 18),),
          const SizedBox(height: 10,),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400)
            ),
            child: InkWell(
              onTap: () => controller.datePicker(Get.context!, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.startDate.value == "" ? "Select a date" : controller.startDate.value.split(" ").first,
                    style: TextStyle(color: controller.startDate.value == "" ? Colors.grey.shade400 : Colors.black87),),
                  const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.black87,)
                ],
              ),
            ),
          ),
          const SizedBox(height: 20,),
          const Text("Estimated End Date", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 18),),
          const SizedBox(height: 10,),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400)
            ),
            child: InkWell(
              onTap: () => controller.datePicker(Get.context!, 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.endDate.value == "" ? "Select a date" : controller.endDate.value.split(" ").first,
                    style: TextStyle(color: controller.endDate.value == "" ? Colors.grey.shade400 : Colors.black87),
                  ),
                  const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.black87,)
                ],
              ),
            ),
          ),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }
}
