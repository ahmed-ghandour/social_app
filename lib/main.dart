import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:social_app/shared/bloc_observer.dart';
import 'package:social_app/shared/styles/themes.dart';
import 'modules/social_login_screen/social_login_layout.dart';

void main() async
{
  BlocOverrides.runZoned( () async
  {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const MyApp());


  },
  blocObserver: MyBlocObserver()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     title: 'Login Demo',
     home: const SocialLoginScreen(),
     debugShowCheckedModeBanner: false,
     themeMode: ThemeMode.light,
     darkTheme: darkTheme,
     theme: lightTheme,
    );
  }
}


