import 'package:coinconverterchallenge/core/network/constants.dart';
import 'package:dartz/dartz.dart';

import 'http_method.dart';
import 'api_error.dart';
import 'error_response.dart';
import 'package:dio/dio.dart';

class Request {

  static const _catchError = "An unexpected error occurred while trying to communicate with the server.";
  static const _accessKey = "access_key";

  final Dio _dio = Dio();

  final HttpMethod httpMethod;
  final String url;
  final RequestOptions options = RequestOptions();
  Map<String, dynamic> queryParameters;

  Request(this.httpMethod, this.url, { this.queryParameters }) {
    if (this.queryParameters == null) {
      queryParameters = Map<String, dynamic>();
    }
    this.queryParameters.addAll({_accessKey: ACCESS_KEY});
    options.queryParameters = this.queryParameters;
  }

  Future<Either<ErrorResponse, Response>> execute() async {
    try {
      Response response;
      switch (this.httpMethod) {
        case HttpMethod.GET: response = await executeGet(); break;
        case HttpMethod.POST: response = await executePost(); break;
        case HttpMethod.PUT: response = await executePut(); break;
        case HttpMethod.DELETE: response = await executeDelete(); break;
      }
      if (response == null) {
        return Left(ErrorResponse(
          success: false,
          error: ApiError(
            code: 0,
            info: _catchError
          )
        ));
      }
      else if (_success(response.statusCode)) {
        return Right(response);
      } else {
        return Left(ErrorResponse(
            success: false,
            error: ApiError(
              code: response.statusCode,
              info: response.data["message"]
            )
        ));
      }
    } catch (error) {
      return Left(ErrorResponse(
          success: false,
          error: ApiError(
              code: 0,
              info: _catchError
          )
      ));
    }
  }
  
  Future<Response> executeGet() async {
    try {
      return await _dio.get(
        _getEndpoint(),
        options: options,
      );
    } catch (error) {
      throw error;
    }
  }

  Future<Response> executePost() async {
    try {
      return await _dio.post(
        _getEndpoint(),
        options: options
      );
    } catch (error) {
      throw error;
    }
  }

  Future<Response> executePut() async {
    try {
      return await _dio.put(
        _getEndpoint(),
        options: options
      );
    } catch (error) {
      throw error;
    }
  }

  Future<Response> executeDelete() async {
    try {
      return await _dio.delete(
        _getEndpoint(),
        options: options
      );
    } catch (error) {
      throw error;
    }
  }

  String _getEndpoint() => "$BASE_URL$url";

  bool _success(int code) => (code >= 200 && code < 300);
}