import 'package:bloc_login/logic/blocs/auth/bloc/auth_shared_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_login/logic/blocs/auth/bloc/auth_state.dart';
import 'package:bloc_login/presentation/router/app_routes.dart';
import 'data/repositories/authentication_sharedPref_repository/authentication_sharedPref_repository.dart';
import 'logic/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  HydratedBlocOverrides.runZoned(
    () => runApp(App(
      authenticationRepository: AuthenticationSharedPrefRepository(),
    )),
    storage: storage,
    blocObserver: MyBlocObserver()
  );
}

class App extends StatelessWidget {
  final AuthenticationSharedPrefRepository authenticationRepository;

  const App({
    Key key,
    this.authenticationRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      // initialize auth bloc with the *AuthInit* event which fetches previous state
      child: BlocProvider(
        create: (context) {
          return AuthSharedBloc(authenticationRepository: authenticationRepository,)..add(AuthSharedInit());
        },
        child: BlocApp(),
      ),
    );
  }
}

class BlocApp extends StatelessWidget {
  BlocApp({Key key}) : super(key: key);

  final AppRouter _appRouter = AppRouter();
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('assets/icons/logo.png'), context);
    precacheImage(
        const AssetImage('assets/icons/welcome-background.png'), context);
    precacheImage(
        const AssetImage('assets/icons/registration_100px.png'), context);
    precacheImage(const AssetImage('assets/icons/registration.png'), context);
    precacheImage(const AssetImage('assets/icons/login_240px.png'), context);
    precacheImage(const AssetImage('assets/icons/menu.png'), context);

    return MaterialApp(
      title: 'Velocity Health',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocBuilder<AuthSharedBloc, AuthState>(
          builder: (context, state) {
            return BlocListener<AuthSharedBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthGranted) {
                  _navigator.pushNamedAndRemoveUntil("/home", (route) => false);
                } else if (state is AuthSharedInit) {
                  _navigator.pushNamedAndRemoveUntil("/", (route) => false);
                }
              },
              child: child,
            );
          },
        );
      },
      onGenerateRoute: _appRouter.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
