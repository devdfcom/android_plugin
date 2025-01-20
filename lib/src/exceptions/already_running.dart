import 'package:devdf_android/src/exceptions/base_exception.dart';

/// Exception thrown when a same method is already running,
/// and the user tries to run it again, without waiting for the first one to finish.
///
/// {@category Exceptions}
class AlreadyRunningException implements BaseException {
  /// The name of the method that is already in progress.
  final String methodName;

  /// Representing corresponding `PlatformException` error code.
  static const tag = 'already_running';

  /// Creates a new instance of [AlreadyRunningException].
  ///
  /// The [name] parameter is the name of the method that is already in progress.
  /// If [name] is not provided, the default value is `undefined`.
  const AlreadyRunningException([String? name])
      : methodName = name ?? 'undefined';

  @override
  String toString() => 'AlreadyRunning Method: $methodName';

  @override
  String get code => tag;
}
