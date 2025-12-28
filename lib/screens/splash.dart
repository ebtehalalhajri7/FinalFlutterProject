import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:practice3/screens/tabs.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
   
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (context) => Tabs()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.5,
            colors: [
              Colors.blue.shade900.withOpacity(0.1),
              Colors.purple.shade900.withOpacity(0.1),
              Colors.black,
            ],
          ),
        ),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
             
              Container(
                    width: size.width * 0.9,
                    height: size.width * 0.9,
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          Colors.blue.withOpacity(0.05),
                          Colors.purple.withOpacity(0.05),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  )
                  .animate(
                    onPlay: (controller) => controller.repeat(reverse: true),
                  )
                  .scale(
                    begin: Offset(0.8, 0.8),
                    end: Offset(1.2, 1.2),
                    duration: 4000.ms,
                    curve: Curves.easeInOut,
                  ),

              AnimatedTextWithGradientOnly(
                text: "استراحة",
                size: size,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedTextWithGradientOnly extends StatefulWidget {
  final String text;
  final Size size;

  const AnimatedTextWithGradientOnly({required this.text, required this.size});

  @override
  State<AnimatedTextWithGradientOnly> createState() =>
      _AnimatedTextWithGradientOnlyState();
}

class _AnimatedTextWithGradientOnlyState
    extends State<AnimatedTextWithGradientOnly>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double gradientPosition = _controller.value;

        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: [
                Colors.blueAccent,
                Colors.purpleAccent,
                Colors.pinkAccent,
                Colors.orangeAccent,
                Colors.yellowAccent,
                Colors.greenAccent,
              ],
              stops: [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
              begin: Alignment(1.0 - gradientPosition * 2, 0.0),
              end: Alignment(-1.0 + gradientPosition * 2, 0.0),
              tileMode: TileMode.clamp,
            ).createShader(bounds);
          },
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: widget.size.width * 0.15,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 3,
              fontFamily: 'Arial',
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 10,
                  offset: Offset(2, 2),
                ),
              ],
            ),
          ),
        ).animate().fadeIn(duration: 1000.ms);
      },
    );
  }
}
