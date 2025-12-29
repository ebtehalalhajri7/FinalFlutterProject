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

    Future.delayed(const Duration(seconds: 5), () {
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
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF3B2365), Color(0xFF2A1848), Colors.black],
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
                          Colors.purple.withOpacity(0.08),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  )
                  .animate(
                    onPlay: (controller) => controller.repeat(reverse: true),
                  )
                  .scale(
                    begin: const Offset(0.85, 0.85),
                    end: const Offset(1.15, 1.15),
                    duration: 4000.ms,
                    curve: Curves.easeInOut,
                  ),

              AnimatedTextWithGradientOnly(text: "استراحة", size: size),
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

  const AnimatedTextWithGradientOnly({
    super.key,
    required this.text,
    required this.size,
  });

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
      duration: const Duration(seconds: 3),
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
              colors: const [
                Colors.blueAccent,
                Colors.purpleAccent,
                Colors.pinkAccent,
                Colors.orangeAccent,
                Colors.yellowAccent,
                Colors.greenAccent,
              ],
              stops: const [0, 0.2, 0.4, 0.6, 0.8, 1],
              begin: Alignment(1.0 - gradientPosition * 2, 0),
              end: Alignment(-1.0 + gradientPosition * 2, 0),
            ).createShader(bounds);
          },
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: widget.size.width * 0.15,
              fontWeight: FontWeight.w900,
              letterSpacing: 3,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.6),
                  blurRadius: 15,
                  offset: const Offset(3, 3),
                ),
              ],
            ),
          ),
        ).animate().fadeIn(duration: 1200.ms);
      },
    );
  }
}
