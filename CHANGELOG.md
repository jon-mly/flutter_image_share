## 0.1.0+4

- Fixed a problem relative to the declaration of <provider> in `AndroidManifest.xml`

## 0.1.0+3

  - **Breaking change**. Migrated dependencies from the deprecated original Android Support Library to AndroidX.
 This shouldn't result in any functional changes, but it requires any Android apps using this plugin to also migrate if 
 they're using the original support library.

## 0.1.0+2

  - fixing problem with Manifest merger relative to the authorities of FileProvider

## 0.1.0+1

  - Reverted `path_provider` to `0.5.0` to avoid dependency conflict, since `1.1.0` is not adopted yet by other plugins.

## 0.1.0

  - Fixed a problem relative to the unique provider that prevented the plugin to be usable on multiple apps on the same
  device.
  - Changed `path_provider` to `1.1.0`.

## 0.0.2

Plugin has be rewritten in Objective-C and Java.

## 0.0.1

Initial release.
