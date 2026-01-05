import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/overlay_models.dart';

class GlassToast extends StatefulWidget {
  final ToastConfig config;
  final VoidCallback onDismiss;

  const GlassToast({
    super.key,
    required this.config,
    required this.onDismiss,
  });

  @override
  State<GlassToast> createState() => _GlassToastState();
}

class _GlassToastState extends State<GlassToast> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _progressController;
  late Animation<double> _slideAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _progressController = AnimationController(
      vsync: this,
      duration: widget.config.duration,
    );

    final isTop = widget.config.position == OverlayPosition.top;

    _slideAnimation = Tween<double>(begin: isTop ? -80 : 80, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.4, curve: Curves.easeIn),
      ),
    );

    _controller.forward();
    if (widget.config.showProgressBar) {
      _progressController.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTop = widget.config.position == OverlayPosition.top;
    final padding = MediaQuery.of(context).padding;

    return Positioned(
      top: isTop ? 50 + padding.top : null,
      bottom: !isTop ? 50 + padding.bottom : null,
      left: 20,
      right: 20,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _slideAnimation.value),
            child: Opacity(
              opacity: _opacityAnimation.value,
              child: Material(
                type: MaterialType.transparency,
                child: Center(
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(widget.config.style.borderRadius),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: widget.config.style.blur,
                        sigmaY: widget.config.style.blur,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(
                              alpha: widget.config.style.backgroundOpacity),
                          borderRadius: BorderRadius.circular(
                              widget.config.style.borderRadius),
                          border: Border.all(
                            color: Colors.white.withValues(
                                alpha: widget.config.style.borderOpacity),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: widget.config.color.withValues(alpha: 0.2),
                              blurRadius: 20,
                              spreadRadius: -5,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  widget.config.icon,
                                  color: widget.config.color,
                                  size: 24,
                                ),
                                const SizedBox(width: 12),
                                Flexible(
                                  child: Text(
                                    widget.config.message,
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      letterSpacing: -0.2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (widget.config.showProgressBar) ...[
                              const SizedBox(height: 12),
                              AnimatedBuilder(
                                animation: _progressController,
                                builder: (context, child) {
                                  return Container(
                                    width: double.infinity,
                                    height: 2,
                                    decoration: BoxDecoration(
                                      color:
                                          Colors.white.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(1),
                                    ),
                                    child: FractionallySizedBox(
                                      alignment: Alignment.centerLeft,
                                      widthFactor:
                                          1.0 - _progressController.value,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: widget.config.color,
                                          borderRadius:
                                              BorderRadius.circular(1),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
