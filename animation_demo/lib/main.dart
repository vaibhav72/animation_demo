import 'package:animation_demo/screens/custom_painter_demo.dart';
import 'package:animation_demo/screens/explicit_animation_demo.dart';
import 'package:animation_demo/screens/implicit_animation_demo.dart';
import 'package:animation_demo/screens/final_code.dart';
import 'package:animation_demo/screens/resource_demo.dart';
import 'package:animation_demo/screens/tween_animation_builder_demo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticker App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Animations Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            children: [
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ImplicitAnimationsDemo()));
                },
                child: const Text("Implicit animations"),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TweenAnimationDemo()));
                },
                child: const Text("Tween Animation Builder"),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ExplicitAnimationDemo()));
                },
                child: const Text("Explicit Animations"),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const CustomPainterExplicitAnimationDemo()));
                },
                child: const Text("Custom Painter"),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ResourceDemo()));
                },
                child: const Text("External Resource"),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FinalApp()));
                },
                child: const Text("Final"),
              )
            ],
          ),
        ));
  }
}
