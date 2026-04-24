import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/app_routes.dart';
import '../screens/onboarding/body_type_page.dart';
import '../screens/onboarding/concierge_page.dart';
import '../screens/onboarding/first_upload_page.dart';
import '../screens/onboarding/forgot_password_page.dart';
import '../screens/onboarding/gender_page.dart';
import '../screens/onboarding/login_page.dart';
import '../screens/onboarding/otp_page.dart';
import '../screens/onboarding/ready_page.dart';
import '../screens/onboarding/sign_up_page.dart';
import '../screens/onboarding/welcome_page.dart';
import '../screens/shell/ai_assist_page.dart';
import '../screens/shell/dashboard_page.dart';
import '../screens/shell/explorer_page.dart';
import '../screens/shell/profile_page.dart';
import '../screens/shell/style_studio_page.dart';
import '../screens/shell/wardrobe_page.dart';
import '../widgets/main_shell.dart';

/// Single app router (paths mirror the web app route table).
final GoRouter victusRouter = GoRouter(
  initialLocation: AppRoutes.welcome,
  routes: [
    GoRoute(path: '/', redirect: (context, state) => AppRoutes.welcome),
    GoRoute(
      path: AppRoutes.welcome,
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: AppRoutes.concierge,
      builder: (context, state) => const ConciergePage(),
    ),
    GoRoute(
      path: AppRoutes.signUp,
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: AppRoutes.forgot,
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    GoRoute(path: AppRoutes.otp, builder: (context, state) => const OtpPage()),
    GoRoute(
      path: AppRoutes.gender,
      builder: (context, state) => const GenderPage(),
    ),
    GoRoute(
      path: AppRoutes.bodyType,
      builder: (context, state) => const BodyTypePage(),
    ),
    GoRoute(
      path: AppRoutes.upload,
      builder: (context, state) => const FirstUploadPage(),
    ),
    GoRoute(
      path: AppRoutes.ready,
      builder: (context, state) => const ReadyPage(),
    ),
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return MainShell(child: child);
      },
      routes: [
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const DashboardPage(),
        ),
        GoRoute(
          path: AppRoutes.wardrobe,
          builder: (context, state) => const WardrobePage(),
        ),
        GoRoute(
          path: AppRoutes.assist,
          builder: (context, state) => const AiAssistPage(),
        ),
        GoRoute(
          path: AppRoutes.studio,
          builder: (context, state) => const StyleStudioPage(),
        ),
        GoRoute(
          path: AppRoutes.explorer,
          builder: (context, state) => const ExplorerPage(),
        ),
        GoRoute(
          path: AppRoutes.profile,
          builder: (context, state) => const ProfilePage(),
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => const WelcomePage(),
);
