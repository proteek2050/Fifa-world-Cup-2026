import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../home/home_screen.dart';

/// Animated splash screen with trophy icon, floating particles, and pulsing glow.
/// Duration: ~2.5 seconds total, then navigates to HomeScreen.
///
/// Visual design:
/// - Deep maroon gradient background (#560027 → #C2185B)
/// - Central trophy icon with scale+fade+glow animation
/// - Floating gold particles around the trophy
/// - Bengali app title with slide-up reveal
/// - Host countries text at the bottom
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _particleController;
  late AnimationController _pulseController;

  // Main animations
  late Animation<double> _trophyScale;
  late Animation<double> _trophyOpacity;
  late Animation<double> _titleSlide;
  late Animation<double> _titleOpacity;
  late Animation<double> _subtitleOpacity;
  late Animation<double> _hostOpacity;

  // Pulse glow
  late Animation<double> _pulseScale;

  // Particles
  final List<_Particle> _particles = [];
  final _random = Random();

  @override
  void initState() {
    super.initState();

    // Generate floating particles
    for (int i = 0; i < 20; i++) {
      _particles.add(_Particle(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        size: _random.nextDouble() * 4 + 2,
        speed: _random.nextDouble() * 0.3 + 0.1,
        delay: _random.nextDouble(),
        opacity: _random.nextDouble() * 0.6 + 0.2,
      ));
    }

    // ── Main animation controller (2.5s) ──
    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    // Trophy: scale from 0.3 → 1.0 (0ms - 600ms)
    _trophyScale = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.35, curve: Curves.elasticOut),
      ),
    );

    // Trophy: fade in (0ms - 300ms)
    _trophyOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.15, curve: Curves.easeIn),
      ),
    );

    // Title: slide up from 30px → 0px (400ms - 900ms)
    _titleSlide = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.2, 0.5, curve: Curves.easeOutCubic),
      ),
    );

    // Title: fade in (400ms - 800ms)
    _titleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.2, 0.45, curve: Curves.easeIn),
      ),
    );

    // Subtitle: fade in (600ms - 1000ms)
    _subtitleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.35, 0.55, curve: Curves.easeIn),
      ),
    );

    // Host countries: fade in (800ms - 1200ms)
    _hostOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.45, 0.65, curve: Curves.easeIn),
      ),
    );

    // ── Pulse glow controller (loops) ──
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _pulseScale = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );

    // ── Particle controller (loops) ──
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    // Start animations
    _mainController.forward();
    _pulseController.repeat(reverse: true);
    _particleController.repeat();

    // Navigate after 2.8s
    Future.delayed(const Duration(milliseconds: 2800), () {
      if (mounted) {
        _navigateToHome();
      }
    });
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) {
          return const HomeScreen();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _mainController.dispose();
    _particleController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _mainController,
          _particleController,
          _pulseController,
        ]),
        builder: (context, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.bgDark,      // #560027
                  AppColors.pink,        // #C2185B
                  AppColors.bgMedium,    // #880E4F
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
            child: Stack(
              children: [
                // ── Floating gold particles ──
                ..._buildParticles(screenSize),

                // ── Radial glow behind trophy ──
                Center(
                  child: Transform.scale(
                    scale: _pulseScale.value,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            AppColors.gold.withValues(alpha: 0.15),
                            AppColors.gold.withValues(alpha: 0.05),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),
                  ),
                ),

                // ── Main content (trophy + text) ──
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(flex: 3),

                      // Trophy icon with scale + fade
                      Opacity(
                        opacity: _trophyOpacity.value,
                        child: Transform.scale(
                          scale: _trophyScale.value,
                          child: _buildTrophyIcon(),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // App title with slide-up + fade
                      Opacity(
                        opacity: _titleOpacity.value,
                        child: Transform.translate(
                          offset: Offset(0, _titleSlide.value),
                          child: Text(
                            AppStrings.appNameShort,
                            style: AppTextStyles.displayLarge.copyWith(
                              color: AppColors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Subtitle
                      Opacity(
                        opacity: _subtitleOpacity.value,
                        child: Text(
                          'ফিফা ওয়ার্ল্ড কাপ ২০২৬ সময়সূচী',
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.white.withValues(alpha: 0.85),
                            fontSize: 16,
                            letterSpacing: 0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const Spacer(flex: 2),

                      // Host countries
                      Opacity(
                        opacity: _hostOpacity.value,
                        child: Column(
                          children: [
                            Text(
                              AppStrings.hostCountries,
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.white.withValues(alpha: 0.7),
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            // Loading dots
                            SizedBox(
                              width: 40,
                              height: 4,
                              child: LinearProgressIndicator(
                                backgroundColor:
                                    AppColors.white.withValues(alpha: 0.15),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.gold.withValues(alpha: 0.6),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 48),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Build the trophy icon with golden glow.
  Widget _buildTrophyIcon() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.gold.withValues(alpha: 0.3),
            blurRadius: 40,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer ring
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.gold.withValues(alpha: 0.4),
                width: 2,
              ),
            ),
          ),
          // Inner filled circle
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.gold.withValues(alpha: 0.25),
                  AppColors.pink.withValues(alpha: 0.3),
                ],
              ),
              border: Border.all(
                color: AppColors.gold.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: const Icon(
              Icons.emoji_events_rounded,
              size: 56,
              color: AppColors.gold,
            ),
          ),
        ],
      ),
    );
  }

  /// Build floating particles from the particle list.
  List<Widget> _buildParticles(Size screenSize) {
    return _particles.map((particle) {
      final progress =
          (_particleController.value + particle.delay) % 1.0;
      final y = screenSize.height * (1.0 - progress * particle.speed * 3);
      final x = screenSize.width * particle.x +
          sin(progress * pi * 2) * 20;
      final opacity =
          particle.opacity * sin(progress * pi).clamp(0.0, 1.0);

      return Positioned(
        left: x,
        top: y,
        child: Opacity(
          opacity: opacity,
          child: Container(
            width: particle.size,
            height: particle.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.gold.withValues(alpha: 0.8),
              boxShadow: [
                BoxShadow(
                  color: AppColors.gold.withValues(alpha: 0.4),
                  blurRadius: particle.size * 2,
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }
}

/// Data class for a floating particle.
class _Particle {
  final double x;
  final double y;
  final double size;
  final double speed;
  final double delay;
  final double opacity;

  const _Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.delay,
    required this.opacity,
  });
}


