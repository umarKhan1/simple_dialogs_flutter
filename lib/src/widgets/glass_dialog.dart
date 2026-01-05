import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/overlay_models.dart';

class GlassDialog extends StatefulWidget {
  final DialogConfig config;
  final VoidCallback onDismiss;

  const GlassDialog({
    super.key,
    required this.config,
    required this.onDismiss,
  });

  @override
  State<GlassDialog> createState() => _GlassDialogState();
}

class _GlassDialogState extends State<GlassDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _blurAnimation;

  Offset _dragOffset = Offset.zero;
  double _wobble = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    _blurAnimation =
        Tween<double>(begin: 0, end: widget.config.style.blur).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.5, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleDismiss() async {
    await _controller.reverse();
    widget.onDismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            onTap: widget.config.barrierDismissible ? _handleDismiss : null,
            child: AnimatedBuilder(
              animation: _blurAnimation,
              builder: (context, child) {
                return BackdropFilter(
                  filter: ColorFilter.mode(
                    Colors.black.withValues(alpha: 0.2 * (_controller.value)),
                    BlendMode.srcOver,
                  ),
                  child: Container(color: Colors.transparent),
                );
              },
            ),
          ),
          Center(
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  _dragOffset += details.delta;
                  _wobble = (_dragOffset.dx / 100).clamp(-0.2, 0.2);
                });
              },
              onPanEnd: (details) {
                if (_dragOffset.distance > 150) {
                  _handleDismiss();
                } else {
                  setState(() {
                    _dragOffset = Offset.zero;
                    _wobble = 0.0;
                  });
                }
              },
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setTranslationRaw(_dragOffset.dx, _dragOffset.dy, 0.0)
                  ..rotateZ(_wobble)
                  ..scaleByDouble(
                      1.0 - (_dragOffset.distance / 1000).clamp(0.0, 0.2),
                      1.0 - (_dragOffset.distance / 1000).clamp(0.0, 0.2),
                      1.0,
                      1.0),
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: AnimatedBuilder(
                    animation: _blurAnimation,
                    builder: (context, child) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(
                            widget.config.style.borderRadius),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: _blurAnimation.value,
                            sigmaY: _blurAnimation.value,
                          ),
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 400),
                            margin: const EdgeInsets.all(24),
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(
                                  alpha: widget.config.style.backgroundOpacity),
                              borderRadius: BorderRadius.circular(
                                  widget.config.style.borderRadius),
                              border: Border.all(
                                color: Colors.white.withValues(
                                    alpha: widget.config.style.borderOpacity),
                                width: 0.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 40,
                                  spreadRadius: -10,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 40,
                                  height: 4,
                                  margin: const EdgeInsets.only(bottom: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                Text(
                                  widget.config.title,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                if (widget.config.description != null) ...[
                                  const SizedBox(height: 12),
                                  Text(
                                    widget.config.description!,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      color:
                                          Colors.white.withValues(alpha: 0.7),
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                                if (widget.config.content != null) ...[
                                  const SizedBox(height: 20),
                                  widget.config.content!,
                                ],
                                const SizedBox(height: 32),
                                _buildActions(),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    final hasSecondary = widget.config.secondaryActionLabel != null;

    return Row(
      children: [
        if (hasSecondary) ...[
          Expanded(
            child: SizedBox(
              height: 54,
              child: OutlinedButton(
                onPressed: () {
                  widget.config.onSecondaryAction?.call();
                  _handleDismiss();
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white70,
                  side: BorderSide(
                    color: Colors.white.withValues(alpha: 0.1),
                    width: 1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  widget.config.secondaryActionLabel!,
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
        ],
        Expanded(
          child: SizedBox(
            height: 54,
            child: ElevatedButton(
              onPressed: () {
                widget.config.onPrimaryAction?.call();
                _handleDismiss();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withValues(alpha: 0.15),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: Colors.white.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
              ),
              child: Text(
                widget.config.primaryActionLabel,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
