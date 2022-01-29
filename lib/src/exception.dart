library get_connect_repo_mixin;

class HttpConnectionError implements Exception {
  final String? message;
  const HttpConnectionError(this.message);
  @override
  String toString() => message ?? "HttpConnectionError: Unknown Error";
}

class HttpException implements Exception {
  final String message;
  final dynamic body;
  const HttpException({
    required final int code,
    final String? statusText,
    final String? errorBody,
    this.body,
  }) : message = "$code: $statusText, $errorBody";
  @override
  String toString() => message;
}

class HttpBadRequestException extends HttpException {
  const HttpBadRequestException({
    final String? statusText,
    final String? errorBody,
    final dynamic body,
  }) : super(
          code: 400,
          statusText: statusText,
          errorBody: errorBody,
          body: body,
        );
}

class HttpConflictException extends HttpException {
  const HttpConflictException({
    final String? statusText,
    final String? errorBody,
    final dynamic body,
  }) : super(
          code: 409,
          statusText: statusText,
          errorBody: errorBody,
          body: body,
        );
}

class HttpNotFoundException extends HttpException {
  const HttpNotFoundException({
    final String? statusText,
    final String? errorBody,
    final dynamic body,
  }) : super(
          code: 404,
          statusText: statusText,
          errorBody: errorBody,
          body: body,
        );
}

class HttpForbiddenException extends HttpException {
  const HttpForbiddenException({
    final String? statusText,
    final String? errorBody,
    final dynamic body,
  }) : super(
          code: 403,
          statusText: statusText,
          errorBody: errorBody,
          body: body,
        );
}

class HttpUnauthorizedException extends HttpException {
  const HttpUnauthorizedException({
    final String? statusText,
    final String? errorBody,
    final dynamic body,
  }) : super(
          code: 401,
          statusText: statusText,
          errorBody: errorBody,
          body: body,
        );
}
