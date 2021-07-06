library get_connect_repo_mixin;

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

mixin RepositorySslHandlerMixin on GetConnect {
  @mustCallSuper
  @override
  void onInit() {
    super.onInit();
    if ( !kReleaseMode ) allowAutoSignedCert = true;
    else {
      trustedCertificates = new List.unmodifiable([
        new TrustedCertificate(
          certificate,
        ),
      ]);
    }
  }

  List<int> get certificate;

}