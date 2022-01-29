library get_connect_repo_mixin;

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

import 'exception.dart';

mixin RepositoryErrorHandlerMixin on GetConnect {
  getException<T>(final Response<T> response) {
    switch (response.status.code) {
      case HttpStatus.badRequest:
        return HttpBadRequestException(
          statusText: response.statusText,
          errorBody: response.bodyString,
          body: response.body,
        );
      case HttpStatus.notFound:
        return HttpNotFoundException(
          statusText: response.statusText,
          errorBody: response.bodyString,
          body: response.body,
        );
      case HttpStatus.unauthorized:
        return HttpUnauthorizedException(
          statusText: response.statusText,
          errorBody: response.bodyString,
          body: response.body,
        );
      case HttpStatus.forbidden:
        return HttpForbiddenException(
          statusText: response.statusText,
          errorBody: response.bodyString,
          body: response.body,
        );
      case HttpStatus.conflict:
        return HttpConflictException(
          statusText: response.statusText,
          errorBody: response.bodyString,
          body: response.body,
        );
      default:
        {
          if (response.status.connectionError) {
            return HttpConnectionError(response.statusText);
          } else {
            return HttpException(
              code: response.statusCode ?? 0,
              statusText: response.statusText,
              errorBody: response.bodyString,
              body: response.body,
            );
          }
        }
    }
  }
}
