import 'package:devdf_android/src/data/package_info.dart';
import 'package:devdf_android/src/data/regional_info.dart';
import 'package:devdf_android/src/extensions/platform_exception_ext.dart';
import 'package:flutter/material.dart' show visibleForTesting;
import 'package:flutter/services.dart' show MethodChannel, PlatformException;
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// An implementation of [PlatformInterface] that uses method channel.
/// Action channel is used for actions that don't require any UI.
/// And can run in the background.
class BgChannel extends PlatformInterface {
  /// Constructs a [BgChannel] platform interface.
  BgChannel() : super(token: _token);

  static final Object _token = Object();

  static BgChannel _instance = BgChannel();

  /// The default instance of [BgChannel] to use.
  ///
  /// Defaults to [BgChannel].
  static BgChannel get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BgChannel] when
  /// they register themselves.
  static set instance(BgChannel instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('devdf.plugins.android/bg_channel');

  /// Methods
  Future<PackageInfo?> appInfo() async {
    try {
      final info = await call<Map<dynamic, dynamic>>('package_info');
      return PackageInfo.fromMap(Map.from(info!));
    } catch (e) {
      return null;
    }
  }

  /// Get regional info from device via locale & more
  Future<RegionalInfo?> regionalInfo({String? locale}) async {
    try {
      final info = await call<Map<dynamic, dynamic>>('regional_info', {'locale': locale});
      return RegionalInfo.fromMap(Map.from(info!));
    } catch (e) {
      return null;
    }
  }

  /// Entry point for calls on the native platform.
  Future<T?> call<T>(String name, [dynamic args]) async {
    try {
      return await methodChannel.invokeMethod<T>(name, args);
    } catch (e) {
      if (e is PlatformException) {
        e.throwByCode();
      } else {
        rethrow;
      }
    }
  }
}
