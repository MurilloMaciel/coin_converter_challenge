extension StringExtension on String {

  String safe() => this ?? "";
  int parseInt() => int.parse(this);
  double parseDouble() => double.parse(this);
}