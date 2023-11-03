class Note{
  final String title;
  final String body;
  String _categoryVal = "";
  Note({required this.title, required this.body});

  String get category => _categoryVal;

  set category(String value) {
    _categoryVal = value;
  }
}