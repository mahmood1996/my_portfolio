import 'package:go_router/go_router.dart';

import '../features/home/home.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [GoRoute(path: '/', builder: (context, state) => HomePage())],
);
