# image_share

A plugin to share an image from your Flutter app via the platform's share 
dialog.

Wraps the ACTION_SEND Intent on Android and UIActivityViewController on iOS.

## Usage

To use the plugin, add `image_share` as a 
[dependency in your pubspec.yaml file](https://flutter.io/docs/development/packages-and-plugins/using-packages).

#### On iOS
Add an `NSPhotoLibraryAddUsageDescription` key to the
`Info.plist` file.

#### On Android

No configuration to do.

## Example

Import the library via

``` dart
import 'package:image_share/image_share.dart';
```

Then invoke the `shareFile` method anywhere in your Dart code to share a file
given its path :
``` dart
ImageShare.shareFile(<PATH OF YOUR FILE>);
```