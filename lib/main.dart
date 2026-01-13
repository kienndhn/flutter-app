import 'package:flutter/material.dart';
import 'package:flutter_template_app/core/services/http_service.dart';
import 'package:flutter_template_app/core/services/storage_service.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'ui/screens/login_screen.dart';
import 'ui/screens/main_tab_screen.dart';
import 'core/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpService();
  String? token = await StorageService().getToken();
  bool initialLoggedIn = token != null;

  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthService()..setInitialStatus(initialLoggedIn),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _router;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final authService = context.read<AuthService>();
    _router = GoRouter(
      initialLocation: authService.isLoggedIn ? '/' : '/login',
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) => const MainTabScreen(),
        ),
      ],
      refreshListenable: authService,
      redirect: (context, state) {
        final bool loggedIn = authService.isLoggedIn;
        final bool loggingIn = state.matchedLocation == '/login';

        if (!loggedIn) return '/login';
        if (loggedIn && loggingIn) return '/';

        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return MaterialApp.router(
      title: 'Flutter Template App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      routerConfig: _router,
    );
  }
}
