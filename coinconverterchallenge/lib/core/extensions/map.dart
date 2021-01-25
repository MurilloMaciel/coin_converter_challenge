extension MapExtension<T, Q> on Map<T, Q> {

  Map<T, Q> safe() => this ?? Map<T, Q>();
}