import 'package:flutter/material.dart';
import 'package:inv2/Controller/my_home_page_controller.dart';
import 'package:inv2/Screen/add_to_do.dart';
import 'package:get/get.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyHomePageController controller = Get.put(MyHomePageController()); //Dependency Injection using GetX
    // _testData();
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: const Color(0xffffbe23),
        title: const Text("To-Do List", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),),
        leading: null,
      ),
      body: Obx(() => controller.isLoaded.value ? body(controller) : const Center(child: CircularProgressIndicator())), //While waiting for the data to be loaded the app will show progress indicator
      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.all(10),
        child: FloatingActionButton(
          onPressed: () => Get.to(() => const AddToDoScreen())?.then((value) => controller.getToDoList(null)),
          backgroundColor: const Color(0xffef5a25),
          child: const Icon(Icons.add, size: 28,),
        ),
      ),
    );
  }

  Widget body(MyHomePageController controller) {
    return ListView.builder(
        itemCount: controller.todos.length,
        itemBuilder: (context,index){
          return toDoCard(index, controller);
        });
  }

  //Here is the card that displays all the To-Do List
  Widget toDoCard(int index, MyHomePageController controller) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 7,
          shadowColor: Colors.grey.shade200,
          child: Column(
            children: [
              InkWell(
                onTap: () => Get.to(() => AddToDoScreen(
                  todoUpdate: controller.todos[index],
                  taskCompleted: controller.todos[index].completed,
                  // todoTitle: controller.todos[index].todoTitle,
                  // startDate: controller.todos[index].startDate,
                  // endDate: controller.todos[index].endDate,
                ))?.then((value) => controller.getToDoList(null)),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(controller.todos[index].todoTitle, style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18), overflow: TextOverflow.fade,),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            const Text("Start Date", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),),
                            const SizedBox(height: 10,),
                            Text(controller.todos[index].startDate.split(' ').first, style: const TextStyle(fontWeight: FontWeight.bold),)
                          ],),
                          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            const Text("End Date", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),),
                            const SizedBox(height: 10,),
                            Text(controller.todos[index].endDate.split(' ').first, style: const TextStyle(fontWeight: FontWeight.bold),)
                          ],),
                          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            const Text("Time Left", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),),
                            const SizedBox(height: 10,),
                            Text(controller.timeLeftList[index].contains("-") ? "--" : controller.timeLeftList[index], style: const TextStyle(fontWeight: FontWeight.bold),)
                          ],)
                        ],)
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
                  color: Color(0xffe8e3d0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      const Text("Status", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),),
                      const SizedBox(width: 10,),
                      Text(controller.todos[index].completed == false ? "Incomplete" : "Completed",
                        style: TextStyle(fontWeight: FontWeight.bold, color: controller.todos[index].completed == false ? Colors.black87 : Colors.green),)
                    ],),
                    Row(children: [
                      const Text("Tick if completed", style: TextStyle(color: Colors.black87),),
                      const SizedBox(width: 10,),
                      SizedBox(
                        width: 20,
                        height: 50,
                        child: Checkbox(
                          value: controller.todos[index].completed,
                          onChanged: (value) => controller.updateTodo(controller.todos[index]),
                          activeColor: Colors.white,
                          checkColor: Colors.black87,
                          side: MaterialStateBorderSide.resolveWith(
                                (states) => const BorderSide(width: 1.0, color: Colors.black87),
                          ),
                        ),
                      )
                    ],),
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}