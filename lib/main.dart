import 'package:chatgptflutterapplication/providers/alldata.dart';
import 'package:chatgptflutterapplication/providers/chatmessagesprovider.dart';
import 'package:chatgptflutterapplication/providers/imagesprovider.dart';
import 'package:chatgptflutterapplication/providers/typesofchatgptservices.dart';
import 'package:chatgptflutterapplication/providers/username.dart';
import 'package:chatgptflutterapplication/ui/chatscreen.dart';
import 'package:chatgptflutterapplication/ui/dashbord.dart';
import 'package:chatgptflutterapplication/ui/editscreen.dart';
import 'package:chatgptflutterapplication/ui/imagesscreen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'providers/themeprovider.dart';
import 'util/constants.dart';

void main() {
  runApp(const MyApp());
}

final _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const DashboardScreen(),
      routes: <RouteBase>[
        GoRoute(
          path: CHAT_SCREEN,
          builder: (context, state) => const ChatScreen(),
        ),
        GoRoute(
          path: EDIT_SCREEN,
          builder: (context, state) => const EditScreen(),
        ),
        GoRoute(
          path: IMAGE_SCREEN,
          builder: (context, state) => const ImageScreen(),
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => ChatMessagesProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => TypesOfChatGptServiceProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => ImagesProvider()),
        ),
        ChangeNotifierProvider(
          create: (context) => AllDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeNotifierProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserNameProvider(),
        ),
      ],
      child: Consumer<ThemeNotifierProvider>(
        builder: (context, notifier, child) => MaterialApp.router(
          title: 'AIBot',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            brightness:
                notifier.fetchTheme ? Brightness.dark : Brightness.light,
          ),
          routerConfig: _router,
        ),
      ),
    );
  }
}
