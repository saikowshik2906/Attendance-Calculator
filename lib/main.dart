import 'package:hi/hello.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attendance',
      routes: {
        
        "/hello":(context) => Hello()

        
      },
      initialRoute: "/hello",
          );
  }
  
}

