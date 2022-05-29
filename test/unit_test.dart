// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inv2/Controller/my_home_page_controller.dart';
import 'package:inv2/Controller/todo_db.dart';
import 'package:inv2/Model/todo.dart';

import 'package:inv2/main.dart';

import 'package:get/get.dart';

import 'dart:io' show Directory;

import 'package:path_provider/path_provider.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

const String kApplicationDocumentsPath = 'applicationDocumentsPath';

void main() async {
  //Line 22 on my_home_page_controller.dart need to be commented before run the test
  //ss the dependency uses the Sembast implementation for real app.
  //For unit testing there is another Sembast implementation
  //so need to comment that to skip the initialization for real app usage

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    PathProviderPlatform.instance = FakePathProviderPlatform();
  });

  MyHomePageController controller = Get.put(MyHomePageController());

  test('Test sembast initialization', () async {
    TodoDb db = TodoDb();
    Directory result = await getApplicationDocumentsDirectory();
    List<Todo> todoList = await db.getTodos(result);
    expect(result.path, kApplicationDocumentsPath);
    expect(todoList, []);
  });

  test('Home Page controller Test', () {
    expect(controller.test, 'initialized');
  });
  test('Time Left Test', (){
    expect(controller.timeLeft(Todo("Test", "2022-06-13", "2022-05-28", false)), "-384 hrs 00 min");
  });

}
class FakePathProviderPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {

  @override
  Future<String?> getApplicationDocumentsPath() async {
    return kApplicationDocumentsPath;
  }
}
