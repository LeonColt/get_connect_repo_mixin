library get_connect_repo_mixin;

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

mixin RepositoryAuthHandlerMixin<T> on GetConnect {
  @mustCallSuper
  @override
  void onInit() {
    super.onInit();
    httpClient.addRequestModifier(
      ( final Request request ) async {
        request.headers['Authorization'] = "Bearer ${ await accessToken }";
        return request;
      },
    );
    httpClient.addAuthenticator<dynamic>(
      ( final Request request ) async {
        request.headers['Authorization'] = "Bearer ${ await accessToken }";
        return request;
      },
    );
  }

  String getUrl( final Request<T> request ) => "${ request.url.scheme }://${ request.url.host }${ request.url.hasPort ? ":${ request.url.port }" : "" }";

  Future<String> get accessToken;

}
