import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:papersy/client/screens/auth/auth_widget.dart';
import 'package:papersy/client/screens/auth/login/login_widget.dart';
import 'package:papersy/client/screens/auth/reset_password/reset_password_widget.dart';
import 'package:papersy/client/screens/auth/signup/signup_widget.dart';
import 'package:papersy/client/screens/downloads/downloads_widget.dart';
import 'package:papersy/client/screens/pdf_viewer/pdf_viewer_widget.dart';
import 'package:papersy/client/screens/preview/preview_widget.dart';
import 'package:papersy/client/screens/profile/profile_widget.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "signup":
        return CupertinoPageRoute(builder: (c) => const SignupWidget());
        break;
      case "login":
        return CupertinoPageRoute(builder: (c) => const LoginWidget());
        break;
      case "reset":
        return CupertinoPageRoute(builder: (c) => const ResetPasswordWidget());
        break;
      case "downloads":
        return CupertinoPageRoute(builder: (c) => const DownloadsWidget());
        break;
      case "profile":
        return CupertinoPageRoute(builder: (c) => ProfileWidget());
        break;
      case "preview":
        return CupertinoPageRoute(builder: (c) => PreviewWidget(url: settings.arguments));
        break;
      case "pdf_viewer":
        return CupertinoPageRoute(builder: (c) => PDFViewerWidget());
        break;
      case "auth":
        return CupertinoPageRoute(builder: (c) => const AuthWidget());
        break;
      default:
    }
  }
}
