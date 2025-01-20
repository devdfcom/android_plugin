import 'package:devdf_android/src/background_actions/bg_channel.dart';
import 'package:flutter/material.dart' show immutable;

/// A representation of information about a package.
@immutable
class PackageInfo {
  /// Creates a new [PackageInfo] instance.
  const PackageInfo({
    required this.app,
    required this.package,
    required this.version,
    required this.build,
  });

  /// The name of the application.
  final String app;

  /// The package name of the application.
  final String package;

  /// The version of the application.
  final String version;

  /// The build number of the application.
  final String build;

  /// Gets the package information of the application.
  static Future<PackageInfo?> get() async => BgChannel.instance.appInfo();

  /// Creates a new [PackageInfo] instance from a map.
  factory PackageInfo.fromMap(Map<String, dynamic> map) => PackageInfo(
        app: map['app'] as String,
        package: map['package'] as String,
        version: map['version'] as String,
        build: map['build'] as String,
      );

  @override
  String toString() =>
      'PackageInfo(app: $app, package: $package, version: $version, build: $build)';

  /// Converts this instance to a map.
  Map<String, dynamic> toMap() => {
        'app': app,
        'package': package,
        'version': version,
        'build': build,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PackageInfo &&
          runtimeType == other.runtimeType &&
          package == other.package &&
          version == other.version &&
          build == other.build;

  @override
  int get hashCode => Object.hash(package, version, build);
}
