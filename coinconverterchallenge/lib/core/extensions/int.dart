extension IntExtension on int {

  int safe() => this ?? 0;
}