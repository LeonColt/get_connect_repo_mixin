library get_connect_repo_mixin;

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:synchronized/synchronized.dart';

mixin RepositoryAuthHandlerMixin<T> on GetConnect {
  static final lock = Lock();
  @mustCallSuper
  @override
  void onInit() {
    super.onInit();
    httpClient.addRequestModifier<T?>(
      (request) async {
        final accessToken = await lock.synchronized(() async {
          if (shouldRefreshAccessToken) {
            try {
              return await refreshAccessToken();
            } catch (error, st) {
              onRefreshSessionError(error, st);
              return null;
            }
          } else {
            return await this.accessToken;
          }
        });
        if (accessToken != null) {
          request.headers['Authorization'] = accessToken;
        }
        return request;
      },
    );
    httpClient.addAuthenticator<T?>(
      (request) async {
        final accessToken =
            await lock.synchronized(() async => await refreshAccessToken());
        request.headers['Authorization'] = accessToken;
        return request;
      },
    );
  }

  String getUrl(final Request<T> request) =>
      "${request.url.scheme}://${request.url.host}${request.url.hasPort ? ":${request.url.port}" : ""}";

  Future<String> get accessToken;
  Future<String> refreshAccessToken();
  bool get shouldRefreshAccessToken => false;
  void onRefreshSessionError(dynamic error, StackTrace stackTrace) {}
}
