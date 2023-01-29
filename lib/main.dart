import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:chatgptflutterapplication/providers/chatmessagesprovider.dart';
import 'package:chatgptflutterapplication/providers/imagesprovider.dart';
import 'package:chatgptflutterapplication/providers/typesofchatgptservices.dart';
import 'package:chatgptflutterapplication/ui/chatscreen.dart';
import 'package:chatgptflutterapplication/ui/dashbord.dart';
import 'package:chatgptflutterapplication/ui/editscreen.dart';
import 'package:chatgptflutterapplication/ui/imagesscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

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
      ],
      child: MaterialApp(
        title: 'AIBot',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: AnimatedSplashScreen(
          duration: 1,
          splash: const FlutterLogo(
            size: 50,
          ),
          nextScreen: const DashboardScreen(),
        ),
        routes: {
          ChatScreen.routeName: (context) => const ChatScreen(),
          EditScreen.routeName: (context) => const EditScreen(),
          ImageScreen.routeName: (context) => const ImageScreen(),
        },
      ),
    );
  }
}
