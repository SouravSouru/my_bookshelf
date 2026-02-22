import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<double> _slide;

  final Color primaryColor = const Color(0xFF6366F1);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _slide = Tween<double>(
      begin: 30.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();

    // Transition smoothly into the login screen where the image persists
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) context.go('/login');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Same Background Image as Login Page
          Image.asset(
            'assets/images/splash_bg.jpg',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: primaryColor,
              child: const Center(
                child: Icon(Icons.menu_book, size: 80, color: Colors.white24),
              ),
            ),
          ),

          // 3. Main Brand Elements
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fade,
                  child: Transform.translate(
                    offset: Offset(0, _slide.value),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Glassmorphic Icon Circle
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          child: const Icon(
                            Icons.auto_stories_rounded,
                            size: 64,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // App Name
                        const Text(
                          'My BookShelf',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Subtitle
                        Text(
                          'Your reading journey starts here',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withValues(alpha: 0.8),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // 4. Subtle Loading Indicator at Bottom
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Center(
              child: FadeTransition(
                opacity: _fade,
                child: SizedBox(
                  width: 32,
                  height: 32,
                  child: CircularProgressIndicator(
                    color: Colors.white.withValues(alpha: 0.8),
                    strokeWidth: 2.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
