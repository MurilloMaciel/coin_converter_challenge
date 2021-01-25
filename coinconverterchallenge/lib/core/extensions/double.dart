extension DoubleExtension on double {

  double safe() => this ?? 0.0;
}