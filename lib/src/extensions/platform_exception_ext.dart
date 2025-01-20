import 'package:devdf_android/src/exceptions/already_running.dart';
import 'package:flutter/services.dart' show PlatformException;

/// Extensions for [PlatformException] class.
extension PlatformExceptionExt on PlatformException {
  /// Throws a custom exception based on the error [code].
  ///
  /// If the [code] is 'already_running', it throws an [AlreadyRunningException]
  /// with the provided [message]. For any other [code] not in list, it rethrows the original
  /// [PlatformException].
  Never throwByCode() => switch (code) {
        AlreadyRunningException.tag => throw AlreadyRunningException(message),
        _ => throw this,
      };
}
