import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/music/providers/music_provider.dart';
import '../features/news/providers/news_provider.dart';
import 'screens/main_navigation_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MusicProvider()),
        ChangeNotifierProvider(create: (_) => NewsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Music News App',
        theme: ThemeData.dark(),
        home: const MainNavigationScreen(),
      ),
    );
  }
}
