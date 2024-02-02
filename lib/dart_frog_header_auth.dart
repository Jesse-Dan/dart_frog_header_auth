library dart_frog_header_auth;

import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_auth/dart_frog_auth.dart';

Future<bool> _defaultApplies(RequestContext context) async => true;

/// **AUTH FOR SPECIFIC HEADER TOKEN**
///
/// Provides middleware for header-based authentication in Dart Frog applications.
/// Validates user tokens from a specified header and makes the authenticated user available
/// to handlers.
Middleware headerAuthentication<T extends Object>({
  /// **The authenticator function**
  ///
  /// This function takes a `RequestContext` and a `String` token as arguments
  /// and returns a `Future<T?>` representing the authenticated user.
  Future<T?> Function(RequestContext context, String token)? authenticator,
  /// **Optional applies function**
  ///
  /// This function takes a `RequestContext` and returns a `Future<bool>`,
  /// determining whether authentication should be applied to a request.
  /// Defaults to `_defaultApplies` which always returns `true`.
  Applies applies = _defaultApplies,
  /// **Optional header key**
  ///
  /// Specifies the header key containing the token. Defaults to `'x-user-token'`.
  String headerKey = 'x-user-token',
}) {
  assert(
    authenticator != null,
    'You must provide either a userFromToken or a '
    'authenticator function',
  );

  return (handler) => (context) async {
        if (!await applies(context)) {
          return handler(context);
        }

        Future<T?> call(String token) async {
          return authenticator!(context, token);
        }

        /// **Access token from specific header**
        ///
        /// Retrieves the token from the specified header key.
        final authorization = context.request.headers[headerKey];
        if (authorization != null) {
          /// **Authenticate user with token**
          final user = await call(authorization);
          if (user != null) {
            return handler(context.provide(() => user));
          }
        }

        return Response(statusCode: HttpStatus.unauthorized);
      };
}
