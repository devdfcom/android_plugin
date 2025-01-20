# Android plugin (devdf_android)

<a href="https://github.com/devdfcom/android_plugin#readme">
    <img src="https://github.com/user-attachments/assets/3896d28f-e53b-4153-b67a-e4ab8c1ec541" alt="devdf_android" title="DevDF Android Plugin" align="right" height="120" />
</a>

[![License: MIT](https://img.shields.io/github/license/devdfcom/android_plugin?style=flat&color=mediumseagreen)](https://opensource.org/licenses/MIT)
[![Request a feature](https://img.shields.io/badge/Request-Feature-teal?style=flat)](https://github.com/devdfcom/android_plugin/discussions/new?category=ideas)
[![Ask a question](https://img.shields.io/badge/Ask-Question-royalblue?style=flat)](https://github.com/devdfcom/android_plugin/discussions/new/choose)
[![Report a bug](https://img.shields.io/badge/Report-Bug-indianred?style=flat)](https://github.com/devdfcom/android_plugin/issues/new?labels=bug&projects=&template=bug_report.yml)

Commonly used methods collection for android app.

## 🚀 Features

- Get app information.
  Inspired by [package_info_plus](https://pub.dev/packages/package_info_plus) plugin. Just for Android.

## 📖 Documentation

### <ins>Table of Contents:</ins>

1. 🤖 [**Android plugin stack**](#android-plugin-stack)
2. 🛠️ [**Installation**](#️install-section)
3. 🗂️️ [**Available methods**](#available-methods)
    - 📄 [PackageInfo](#packageinfo) ([*usage*](#packageinfo-usage) 👁️‍🗨️)
4. 🗃️ [**Plugin Exceptions**](#plugin-exceptions)
5. 📦 [**Changelog**](#changelog-section)
6. ⁉️ [**Help & Questions**](#help--questions)
7. 🌱 [**Contributing**](#contributing)

<a name="android-plugin-stack"></a>

## 🤖 Android plugin stack

- MinSDK Android 5.0 (API level 21)
- Compiled with Android 15 (API level 35)
- Android NDK v27.0.12077973
- Kotlin v2.0.20
- Gradle v8.12.0 (Android Gradle Plugin v8.8.0)
- Java 17 major version

<a name="install-section"></a>

## 🛠️ Installation
```yaml
dependencies:
  devdf_android: ^0.0.1
  git:
    url: git://github.com/devdfcom/android_plugin.git
```
    
<a name="available-methods"></a>

## 🗂️ Available methods, data classes

Collection of all currently available methods, data classes, provided by the plugin.

<a name="packageinfo"></a>

### 📄 PackageInfo

This class provides information about the application package.

Class `PackageInfo` has the following properties:

- `app` - Application name, fallback to package name if not available
- `package` - Application package name
- `version` - Application version, fallback to empty string if not available ""
- `build` - Application build number, if not available, will be "0"


<a name="packageinfo-usage"></a>

#### <ins>***PackageInfo Usage:***</ins>
```dart
import 'package:devdf_android/devdf_android.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final PackageInfo? info = await PackageInfo.get();
  print(info?.toString());
}
```
<a name="plugin-exceptions"></a>

## 🗃️ Plugin Exceptions

Plugin provides a set of exceptions that can be thrown during the plugin operation.

- `BaseException` - Base exception for all exceptions.

Common exceptions for all channels:

- `AlreadyRunningException` Thrown when the same method is already in progress.

<a name="changelog-section"></a>

## 📦 Changelog

Please see [CHANGELOG.md](./CHANGELOG.md) for more information on what has changed recently.

<a name="help--questions"></a>

## ⁉️ Help & Questions

Start a new discussion in the [Discussions Tab](https://github.com/devdfcom/android_plugin/discussions).

<a name="contributing"></a>

## 🌱 Contributing

Any contributions you make are **greatly appreciated**.

Just [fork the repository](https://docs.github.com/en/get-started/quickstart/fork-a-repo)
and [create a pull request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request).

For major changes, please first start a discussion in
the [Discussions Tab](https://github.com/devdfcom/android_plugin/discussions) to discuss what you would
like to change.

> [!NOTE]
> By submitting a patch, you agree to allow the project owner(s) to license your work under the terms of
> the [**`MIT License`**](./LICENSE).

🙏 **Thank you!**