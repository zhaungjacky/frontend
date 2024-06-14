import 'package:frontend/pages/pages.dart';
import 'package:go_router/go_router.dart';

GoRouter myRouter() {
  return GoRouter(routes: [
    GoRoute(
      path: AuthPage.routerPath(),
      builder: (context, state) => const AuthPage(),
    ),
  ]);
}
