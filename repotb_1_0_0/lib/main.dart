import 'package:flutter/material.dart';
import 'homescreen.dart';

void main() {
    runApp(const Repotbadr());
}
class Repotbadr extends StatelessWidget{
    const Repotbadr({super.key});

    @override 
    Widget build(BuildContext context) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
        title: 'repoTB ADR',
        theme: ThemeData(
            primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
        );
        
    }

}

