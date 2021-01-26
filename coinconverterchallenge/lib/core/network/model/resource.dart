import 'request_state.dart';

class Resource {

  int _code;
  String _message;
  RequestState _state;

  String get message => _message;
  int get code => _code;
  RequestState get state => _state;

  Resource(this._state);

  void setNone() {
    _state = RequestState.NONE;
    _message = "";
    _code = 0;
  }

  void setLoading() {
    _state = RequestState.LOADING;
    _message = "";
    _code = 0;
  }

  void setError(String message, { int code }) {
    _state = RequestState.ERROR;
    _message = message;
    _code = code;
  }

  void setSuccess() {
    _state = RequestState.SUCCESS;
    _message = "";
    _code = 0;
  }
}