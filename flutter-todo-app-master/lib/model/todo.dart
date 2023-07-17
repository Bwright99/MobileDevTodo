class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'Mobile Dev', isDone: true),
      ToDo(id: '02', todoText: 'CTW', isDone: true),
      ToDo(
        id: '03',
        todoText: 'Exam in Urban Life',
      ),
    ];
  }
}
