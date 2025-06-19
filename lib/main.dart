import 'package:flutter/material.dart';
import 'welcome_screen.dart'; // Import av WelcomeScreen
import 'package:provider/provider.dart';
import 'ticket_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TicketProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parkering App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WelcomeScreen(),
    );
  }
}