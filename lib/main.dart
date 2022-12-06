import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jobuapp/firebase_options.dart';
import 'package:jobuapp/providers/app_provider.dart';
import 'package:jobuapp/providers/auth_provider.dart';
import 'package:jobuapp/providers/state_provider.dart';
import 'package:jobuapp/providers/user_provider.dart';
import 'package:jobuapp/services/shared_data.dart';
import 'package:jobuapp/views/addservice.dart';
import 'package:jobuapp/views/login/getstarted.dart';
import 'package:jobuapp/views/login/login.dart';
import 'package:jobuapp/views/login/signup.dart';
import 'package:jobuapp/views/page_structure.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await DataPrefrences.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => StateProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ThemeNotifier>().initTheme(DataPrefrences.getDarkMode());

    return MaterialApp(
      title: 'Jobu App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/formcond',
      routes: {
        '/index': (context) => const IndexScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/addservice': (context) => const Addservice(),
        '/home': (context) => const PageStructure()

      },
    );
  }
}