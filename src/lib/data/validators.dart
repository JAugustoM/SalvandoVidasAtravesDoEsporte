bool isEmail(String email) {
  final exp = RegExp(r"^[\w\-\.]+@([\w-]+\.)+[\w-]{2,}$");

  return exp.hasMatch(email);
}
