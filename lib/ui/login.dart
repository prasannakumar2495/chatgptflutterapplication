import 'dart:math';

import 'package:flutter/material.dart';

class FlipTile extends StatefulWidget {
  final Widget front;
  final Widget back;

  const FlipTile({
    super.key,
    required this.front,
    required this.back,
  });

  @override
  FlipTileState createState() => FlipTileState();
}

class FlipTileState extends State<FlipTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  bool isFlipped = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(2 * pi * _animation.value),
                child: child,
              );
            },
            child: _animation.value >= 0.5 ? widget.back : widget.front,
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                isFlipped = !isFlipped;
              });
              if (isFlipped) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
            },
            child: const Text('Flip'),
          ),
        ],
      ),
    );
  }
}
