import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/shared/bloc_observer.dart';
import 'package:social_app/shared/components/constant.dart';
import 'package:social_app/shared/network/local/cashe_helper.dart';
import 'package:social_app/shared/styles/themes.dart';
import 'package:social_app/layout/social_layout.dart';
import 'modules/social_login_screen/social_login_layout.dart';

void main() async
{
  BlocOverrides.runZoned(() async
  {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await CasheHelper.init();
    Widget? widget;
    uId = await CasheHelper.getData(key:'uId');
    debugPrint(uId.toString());
    var token = await FirebaseMessaging.instance.getToken();
    debugPrint(token);
    FirebaseMessaging.onMessage.listen((event)
    {
      debugPrint(event.data.toString());
    });
    if(uId != null )
    {
      widget = const SocialLayout();
    }
    else
      {
        widget = const SocialLoginScreen();
      }
    runApp(MyApp(startWidget: widget));

  },

  blocObserver: MyBlocObserver()

  );
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  const MyApp({Key? key,this.startWidget}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers:
        [
          BlocProvider(create: (BuildContext context)=>SocialCubit()..getUserData()..getUsers()..getPosts()),
        ],
        child: MaterialApp(
          title: 'Login Demo',
          home: startWidget,
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          darkTheme: darkTheme,
          theme: lightTheme,
        )
    );
  }
}


