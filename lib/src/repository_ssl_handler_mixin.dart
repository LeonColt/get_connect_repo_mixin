library get_connect_repo_mixin;

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

mixin RepositorySslHandlerMixin on GetConnect {
  @mustCallSuper
  @override
  void onInit() {
    super.onInit();
    if (!kReleaseMode) {
      allowAutoSignedCert = true;
    } else {
      final cert = certificate;
      if (cert.isNotEmpty) {
        trustedCertificates = List.unmodifiable([
          TrustedCertificate(cert),
        ]);
      }
    }
  }

  List<int> get certificate => const [];
}
