import 'package:flutter/cupertino.dart';

import '../screens/auth/auth_widget.dart';
import '../screens//auth/login/login_widget.dart';
import '../screens/auth/reset_password/reset_password_widget.dart';
import '../screens/auth/signup/signup_widget.dart';
import '../screens/downloads/downloads_widget.dart';
import '../screens/error/custom_error_widget.dart';
import '../screens/pdf_viewer/pdf_viewer_widget.dart';
import '../screens/preview/preview_widget.dart';
import '../screens/profile/profile_widget.dart';

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
        return CupertinoPageRoute(
            builder: (c) => PreviewWidget(url: settings.arguments));
        break;
      case "pdf_viewer":
        return CupertinoPageRoute(builder: (c) => PDFViewerWidget());
        break;
      case "auth":
        return CupertinoPageRoute(builder: (c) => const AuthWidget());
        break;
      default:
        return CupertinoPageRoute(builder: (c) => const CustomErrorWidget());
    }
  }
}
