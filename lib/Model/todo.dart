class Todo {
  Todo(this.todoTitle, this.startDate, this.endDate, this.completed);

  int? id;
  String todoTitle;
  String startDate;
  String endDate;
  bool completed;

  Map<String, dynamic> toMap() {
    return {
      'todoTitle' : todoTitle,
      'startDate' : startDate,
      'endDate' : endDate,
      'completed' : completed,
    };
  }
  static Todo fromMap(Map<String, dynamic> map){
    return Todo(map['todoTitle'], map['startDate'], map['endDate'], map['completed']);
  }
}