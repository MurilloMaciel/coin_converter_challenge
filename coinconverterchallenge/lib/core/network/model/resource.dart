import 'request_state.dart';

class Resource {

  int _code;
  String _message;
  RequestState state;

  String get message => _message;

  int get code => _code;

  void setLoading() {
    this.state = RequestState.LOADING;
    _message = "";
    _code = 0;
  }

  void setError(String message, { int code }) {
    state = RequestState.ERROR;
    _message = message;
    _code = code;
  }

  void setSuccess() {
    state = RequestState.SUCCESS;
    _message = "";
    _code = 0;
  }
}