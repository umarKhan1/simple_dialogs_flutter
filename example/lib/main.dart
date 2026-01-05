import 'package:flutter/material.dart';
import 'package:simple_dialogs_flutter/simple_dialogs_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Dialogs Example',
      navigatorKey: SimpleDialogs.navigatorKey,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
          ),
        ),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 60),
                const Icon(Icons.auto_awesome, size: 80, color: Colors.white70),
                const SizedBox(height: 20),
                Text(
                  'Simple Dialogs',
                  style: GoogleFonts.outfit(
                    fontSize: 42,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: -1,
                  ),
                ),
                Text(
                  'Advanced Customization • v2.1',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white60,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 50),
                _buildSectionTitle('DIALOG EXAMPLES'),
                _buildButton(
                  'Standard Dialog',
                  icon: Icons.layers_outlined,
                  onPressed: () => SimpleDialogs.show(
                    title: 'Example',
                    description: 'A simple one-action glass dialog.',
                  ),
                ),
                _buildButton(
                  'Dual Action Dialog',
                  icon: Icons.dynamic_feed_rounded,
                  onPressed: () => SimpleDialogs.show(
                    title: 'Confirm Action',
                    description:
                        'Would you like to proceed with this operation?',
                    secondaryActionLabel: 'Cancel',
                    primaryActionLabel: 'Confirm',
                    onSecondaryAction: () => debugPrint('Cancelled'),
                    onPrimaryAction: () => debugPrint('Confirmed'),
                  ),
                ),
                const SizedBox(height: 30),
                _buildSectionTitle('TOAST EXAMPLES'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSmallButton(Icons.arrow_upward, Colors.blue, () {
                      SimpleDialogs.toast(
                        message: 'Top Aligned Toast!',
                        position: OverlayPosition.top,
                        type: ToastType.info,
                      );
                    }),
                    _buildSmallButton(Icons.arrow_downward, Colors.green, () {
                      SimpleDialogs.toast(
                        message: 'Bottom Aligned Toast!',
                        position: OverlayPosition.bottom,
                        type: ToastType.success,
                      );
                    }),
                    _buildSmallButton(Icons.timer_off_outlined, Colors.orange,
                        () {
                      SimpleDialogs.toast(
                        message: 'No Progress Bar',
                        showProgressBar: false,
                        type: ToastType.warning,
                      );
                    }),
                    _buildSmallButton(Icons.brush_outlined, Colors.purpleAccent,
                        () {
                      SimpleDialogs.toast(
                        message: 'Custom Styled Toast',
                        style: const GlassStyle(
                          blur: 30,
                          borderRadius: 10,
                          backgroundOpacity: 0.2,
                        ),
                        customColor: Colors.purple,
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 20),
                _buildButton(
                  'Show Loader',
                  icon: Icons.hourglass_top_rounded,
                  onPressed: () {
                    SimpleDialogs.loading(message: 'Processing...');
                    Future.delayed(const Duration(seconds: 2), () {
                      SimpleDialogs.dismiss();
                    });
                  },
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          color: Colors.white38,
          letterSpacing: 2,
        ),
      ),
    );
  }

  Widget _buildSmallButton(IconData icon, Color color, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: IconButton.filled(
        onPressed: onPressed,
        icon: Icon(icon),
        style: IconButton.styleFrom(
          backgroundColor: color.withValues(alpha: 0.15),
          foregroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: color.withValues(alpha: 0.3), width: 1),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String text,
      {required IconData icon, required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40),
      child: SizedBox(
        width: double.infinity,
        height: 64,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white.withValues(alpha: 0.1),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                  color: Colors.white.withValues(alpha: 0.15), width: 1.5),
            ),
          ),
          onPressed: onPressed,
          icon: Icon(icon, size: 24),
          label: Text(
            text,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
