import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_state/app_state_manager.dart';
import 'app_state/app_theme.dart';
import 'navigation/router.dart';
import 'theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences preferences = await SharedPreferences.getInstance();
  // await preferences.clear();

  final prefs = await SharedPreferences.getInstance();
  final appState = AppState(prefs);
  appState.onAppStart();
  runApp(App(appState: appState));
}

class App extends StatefulWidget {
  final AppState appState;

  const App({Key? key, required this.appState}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.appThemePreference.getDarkTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(
          lazy: false,
          create: (BuildContext createContext) => widget.appState,
        ),
        Provider<AppRouter>(
          lazy: false,
          create: (BuildContext createContext) => AppRouter(widget.appState),
        ),
        ChangeNotifierProvider<DarkThemeProvider>(
          create: (_) {
            return themeChangeProvider;
          },
        ),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget? child) {
          final router = Provider.of<AppRouter>(context, listen: false).router;
          return MaterialApp.router(
            routeInformationProvider: router.routeInformationProvider,
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
            debugShowCheckedModeBanner: false,
            title: 'Video On Demand Streaming',
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: themeChangeProvider.darkTheme
                ? ThemeMode.dark
                : ThemeMode.light,
          );
        },
      ),
    );
  }
}
