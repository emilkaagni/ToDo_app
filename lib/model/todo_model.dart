class Todo {
  String title;
  bool isDone;
  bool isFavorite;

  Todo({
    required this.title,
    this.isDone = false,
    this.isFavorite = false,
  });
}
