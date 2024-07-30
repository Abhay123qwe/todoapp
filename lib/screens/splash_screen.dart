import 'package:flutter/material.dart';
import 'package:todoapp/const/gradient.dart';
import 'package:todoapp/screens/homescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GradientText(
          " ToDo",
          style: TextStyle(decoration: TextDecoration.none, fontSize: 60),
          gradient: LinearGradient(colors: [
            Colors.greenAccent,
            Colors.pinkAccent,
            Colors.orangeAccent,
            Colors.cyanAccent,
            Colors.orangeAccent,
            Colors.pinkAccent,
            Colors.greenAccent,
          ]),
        ),
        GradientText(
          "APP",
          style: TextStyle(decoration: TextDecoration.none),
          gradient: LinearGradient(colors: [
            Colors.greenAccent,
            Colors.pinkAccent,
            Colors.orangeAccent,
            Colors.cyanAccent,
            Colors.orangeAccent,
            Colors.pinkAccent,
            Colors.greenAccent,
          ]),
        ),
        // ElevatedButton(
        //   onPressed: () {
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => const HomeScreen()));
        //   },
        //   child: const GradientText(
        //     "Go",
        //     style: TextStyle(decoration: TextDecoration.none),
        //     gradient: LinearGradient(colors: [
        //       Colors.greenAccent,
        //       Colors.pinkAccent,
        //       Colors.orangeAccent,
        //       Colors.cyanAccent,
        //       Colors.orangeAccent,
        //       Colors.pinkAccent,
        //       Colors.greenAccent,
        //     ]),
        //   ),
        // )
      ],
    );
  }
}
