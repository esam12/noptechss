import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


import 'app_localizations.dart';
import 'helpers/helpers.dart';
import 'models/user_model.dart';
import 'screens/account_screen.dart';
import 'screens/login_screen.dart';
import 'screens/system_view_screen.dart';

class AppBootloader extends StatelessWidget {
  const AppBootloader({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      theme: ThemeData(
        primarySwatch: Helpers.colorCustom,
      ),
      title: "Noptechs",
      // routes: {
      //   Helpers.loginRoute: (BuildContext context) => LoginScreen(),
      //   // Helpers.loginRoute: (BuildContext context) => LoginScreen(),
      // },
      onGenerateRoute: (RouteSettings settings) {
        print("Navigation ${settings.name}");
        switch (settings.name) {
          case Helpers.loginRoute:
            return MaterialPageRoute(builder: (BuildContext context) {
              var formAccount = false;
              print("${settings.arguments}");
              if (settings.arguments != null) {
                formAccount = settings.arguments as bool;
              }
              return LoginScreen(
                fromAccount: formAccount,
              );
            });

          case Helpers.systemViewRoute:
            return MaterialPageRoute(builder: (BuildContext context) {
              return SystemViewScreen(
                user: settings.arguments as UserModel,
              );
            });

          case Helpers.accountRoute:
            return MaterialPageRoute(builder: (BuildContext context) {
              return AccountScreen();
            });
        }
        return null;
      },
      //home: LoginScreen(),
    );
  }
}
