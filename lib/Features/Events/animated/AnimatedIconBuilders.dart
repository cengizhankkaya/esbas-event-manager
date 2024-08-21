import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:esbasapp/Features/Events/Screens/Events_add.dart';

class EventNotFound extends StatefulWidget {
  @override
  _EventNotFoundState createState() => _EventNotFoundState();
}

class _EventNotFoundState extends State<EventNotFound>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _positionAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _buttonScaleAnimation;

  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _positionAnimation = Tween<double>(begin: -50, end: 50).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _colorAnimation = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(_controller);

    _buttonScaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticInOut),
    );

    _confettiController = ConfettiController(duration: Duration(seconds: 1));
  }

  @override
  void dispose() {
    _controller.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _createEvent() {
    _confettiController.play(); // Start confetti animation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Yeni etkinlik oluştur!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.translate(
                  offset: Offset(_positionAnimation.value, 0),
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Icon(
                      Icons.sentiment_dissatisfied,
                      color: Colors.orange,
                      size: 100,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Etkinlik bulunamadı.',
                  style: TextStyle(
                    fontSize: 24,
                    color: _colorAnimation.value,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ScaleTransition(
                  scale: _buttonScaleAnimation,
                  child: ElevatedButton(
                    onPressed: () {
                      _createEvent();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddEventScreen()),
                      );
                    },
                    child: Text('Yeni Etkinlik Oluştur'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blueAccent,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        ConfettiWidget(
          confettiController: _confettiController,
          blastDirection: -3.14 / 2,
          emissionFrequency: 0.1,
          numberOfParticles: 10,
          gravity: 0.1,
          shouldLoop: true,
          colors: [Colors.red, Colors.green, Colors.blue, Colors.yellow],
        ),
      ],
    );
  }
}
