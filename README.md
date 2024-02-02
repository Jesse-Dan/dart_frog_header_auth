# dart_frog_header_auth

[![Pub Package](https://img.shields.io/pub/v/dart_frog_header_auth.svg)](https://pub.dev/packages/dart_frog_header_auth)
[![GitHub](https://img.shields.io/github/license/Jesse-Dan/dart_frog_header_auth)](https://github.com/Jesse-Dan/dart_frog_header_auth/blob/main/LICENSE)

Header-based authentication middleware for Dart Frog applications.

## Overview

This package provides middleware for header-based authentication in Dart Frog applications. It validates user tokens from a specified header and makes the authenticated user available to handlers.

## Usage

To use this middleware, you can include it in your Dart Frog application as follows:

```dart
import 'package:dart_frog_header_auth/dart_frog_header_auth.dart';

Handler handleHeaderAuth(Handler handler) {
  return handler.use(requestLogger()).use(
    headerAuthentication<User>(
      authenticator: (context, token) async {
        final userRepository = context.read<UserRepository>();
        return await userRepository.userFromToken(token);
      },
    ),
  );
}
```

## Documentation

For detailed documentation and examples, refer to the [API Documentation](https://pub.dev/packages/dart_frog_header_auth).

## Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  dart_frog_header_auth: ^latest_version
```

Replace `^latest_version` with the latest version from [pub.dev](https://pub.dev/packages/dart_frog_header_auth).

## Changelog

For a complete list of changes, see the [Changelog](https://github.com/Jesse-Dan/dart_frog_header_auth/blob/main/CHANGELOG.md).

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/Jesse-Dan/dart_frog_header_auth/blob/main/LICENSE) file for details.