extension ListExtension<T> on List<T> {

  List<T> safe() => this ?? List<T>();
}