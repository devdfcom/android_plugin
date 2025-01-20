/// Base class for all custom exceptions in the package
/// {@category Exceptions}
abstract interface class BaseException implements Exception {
  /// Representing corresponding `PlatformException` error code.
  final String code;

  /// Creates a new instance of [BaseException].
  ///
  /// The [code] parameter is the error message.
  const BaseException(this.code);

  @override
  String toString();
}
