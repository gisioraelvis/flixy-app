import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../app_state/app_state_manager.dart';
import '../app_state/app_theme.dart';
import '../navigation/routes.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    AppState appState;
    final themeProvider = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Account'),
        ),
        body: Column(
          children: [
            Expanded(
                child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Profile'),
                    onTap: () =>
                        GoRouter.of(context).pushNamed(AppScreens.profile),
                  ),
                  const Divider(
                    color: Colors.green,
                    indent: 16,
                    endIndent: 16,
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () => context.pushNamed(AppScreens.settings),
                  ),
                  const Divider(
                    color: Colors.green,
                    indent: 16,
                    endIndent: 16,
                  ),
                  // btn to toggle dark mode on/off
                  ListTile(
                    leading: themeProvider.darkTheme
                        ? const Icon(Icons.wb_sunny)
                        : const Icon(Icons.nights_stay),
                    title: themeProvider.darkTheme
                        ? const Text('Light Mode')
                        : const Text('Dark Mode'),
                    onTap: () {
                      final provider = Provider.of<DarkThemeProvider>(context,
                          listen: false);
                      provider.darkTheme = !provider.darkTheme;
                    },
                  ),
                  const Divider(
                    color: Colors.green,
                    indent: 16,
                    endIndent: 16,
                  ),
                  ListTile(
                    leading: const Icon(Icons.power_settings_new),
                    title: const Text('Sign out'),
                    onTap: () => signOutUser(context),
                  ),
                ],
              ),
            )),
          ],
        ));
  }

  void signOutUser(BuildContext context) {
    Provider.of<AppState>(context, listen: false).signInState = false;
  }
}
