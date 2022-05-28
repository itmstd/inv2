// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inv2/Controller/my_home_page_controller.dart';
import 'package:inv2/Model/todo.dart';

import 'package:inv2/main.dart';

import 'package:get/get.dart';

void main() {
  test('''Test dependency injection''',
          () {
        /// You can test the controller without the lifecycle,
        /// but it's not recommended unless you're not using
        ///  GetX dependency injection
        MyHomePageController controller = Get.put(MyHomePageController());
        // expect(controller.name.value, 'name1');

        /// If you are using it, you can test everything,
        /// including the state of the application after each lifecycle.
        controller.getToDoList();
        expect(controller.test, 'test jer');
        // expectLater(controller.todos[0].todoTitle, "TEst 1");
        expect(controller.timeLeft(Todo("Test", "2022-06-13", "2022-05-28", false)), "-384 hrs 00 min");

      });
}
