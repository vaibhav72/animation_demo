import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class ResourceDemo extends StatefulWidget {
  const ResourceDemo({Key? key, this.lookup}) : super(key: key);
  final bool? lookup;

  @override
  State<ResourceDemo> createState() => _ResourceDemoState();
}

class _ResourceDemoState extends State<ResourceDemo> {
  late RiveAnimationController _controller;

  /// Is the animation currently playing?
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = OneShotAnimation(
      'lookUp',
      autoplay: false,
      onStop: () => setState(() => _isPlaying = false),
      onStart: () => setState(() => _isPlaying = true),
    );
    _controller.isActive = widget.lookup ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          _isPlaying ? null : _controller.isActive = widget.lookup ?? true,
      child: Container(
        height: 100,
        width: 100,
        child: Center(
          child: RiveAnimation.network(
            'assets/flutter.riv',
            animations: const ['idle', 'lookUp', 'slowDance'],
            controllers: [_controller],
          ),
        ),
      ),
    );
  }
}
