import 'package:frontend/pages/auth/login_page.dart';
import 'package:frontend/pages/pages.dart';
import 'package:go_router/go_router.dart';

GoRouter myRouter() {
  return GoRouter(routes: [
    GoRoute(
      path: AuthPage.routerPath(),
      builder: (context, state) => const AuthPage(),
    ),
    GoRoute(
      path: LoginPage.routerPath(),
      builder: (context, state) => const LoginPage(),
    ),
  ]);
}
