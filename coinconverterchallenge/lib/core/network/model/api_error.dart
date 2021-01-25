class ApiError {

  int code;
  String info;

  ApiError({this.code, this.info});

  factory ApiError.fromJson(Map<String, dynamic> json) => ApiError(
    code: json["code"],
    info: json["info"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "info": info,
  };
}