import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SquareAnimation(),
    );
  }
}

class SquareAnimation extends StatefulWidget {
  const SquareAnimation({super.key});

  @override
  State<SquareAnimation> createState() => _SquareAnimationState();
}

class _SquareAnimationState extends State<SquareAnimation> {
  static const double _squareSize = 50.0;
  static const Duration _animationDuration = Duration(seconds: 1);

  double _boxPos = 0;
  bool _isAnimating = false;
  double _screenWidth = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenWidth = MediaQuery.of(context).size.width;

    // initial position of the box
    _boxPos = (_screenWidth - _squareSize) / 2;
  }

  // function to move box Left
  void _moveToLeft() async {
    setState(() => _isAnimating = true);
    setState(() => _boxPos = 0);
    print(_boxPos);
    await Future.delayed(_animationDuration);
    setState(() => _isAnimating = false);
  }

  // function to move box Right
  void _moveToRight() async {
    setState(() => _isAnimating = true);
    setState(() => _boxPos = _screenWidth - _squareSize);
    print(_boxPos);
    await Future.delayed(_animationDuration);
    setState(() => _isAnimating = false);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: _animationDuration,
            top: MediaQuery.of(context).size.height / 2 - _squareSize / 2,
            left: _boxPos,
            child: Container(
              width: _squareSize,
              height: _squareSize,
              color: Colors.red,
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed:
                      (!_isAnimating && !(_boxPos == 0)) ? _moveToLeft : null,
                  child: const Text('To Left'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: (!_isAnimating &&
                          !(_boxPos == (_screenWidth - _squareSize)))
                      ? _moveToRight
                      : null,
                  child: const Text('To Right'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
