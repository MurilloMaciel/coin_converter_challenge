extension BoolExtension on bool {

  bool safe() => safeFalse();
  bool safeFalse() => this ?? false;
  bool safeTrue() => this ?? true;
}