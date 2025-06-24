import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/screens/roadmap_screen.dart';
import '/services/auth_service.dart';

// --- UI Constants for Easy Theming and Maintenance ---
class _UIConstants {
  // Professional Green Color Palette
  static const Color primaryGreen = Color(0xFF00695C); // A deep, professional teal green
  static const Color secondaryGreen = Color(0xFF004D40); // A darker shade for gradients
  static const Color accentGreen = Color(0xFF4DB6AC); // A lighter, friendly accent
  static const Color lightGreenBackground = Color(0xFFF0F7F7); // A very light green for backgrounds
  static const Color darkTextColor = Color(0xFF1F2937); // Dark charcoal for readability

  // Consistent Padding and Radii
  static const double pagePadding = 20.0;
  static const double cardPadding = 24.0;
  static const double widgetSpacing = 18.0;
  static const double borderRadius = 16.0;
}


// A ConsumerStatefulWidget to access providers and use animations
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  final goalController = TextEditingController();
  final experienceController = TextEditingController();
  final skillsController = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    goalController.dispose();
    experienceController.dispose();
    skillsController.dispose();
    super.dispose();
  }

  void generateRoadmap() {
    if (formKey.currentState!.validate()) {
      final query = {
        'goal': goalController.text,
        'experience': experienceController.text,
        'skills': skillsController.text
            .split(',')
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .toList(),
      };
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => RoadmapScreen(query: query)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define input decoration here to reuse it and keep the build method cleaner
    final inputDecoration = InputDecoration(
      labelStyle: const TextStyle(color: _UIConstants.primaryGreen),
      filled: true,
      fillColor: _UIConstants.lightGreenBackground,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_UIConstants.borderRadius),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_UIConstants.borderRadius),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_UIConstants.borderRadius),
        borderSide: const BorderSide(color: _UIConstants.primaryGreen, width: 2.0),
      ),
    );
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Pathfinder AI ',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: 'Sign Out',
            onPressed: () {
              ref.read(authServiceProvider).signOut();
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _UIConstants.primaryGreen,
              _UIConstants.secondaryGreen,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(_UIConstants.pagePadding),
              child: SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(_UIConstants.borderRadius),
                      side: BorderSide(color: Colors.white.withOpacity(0.2)),
                    ),
                    color: Colors.white.withOpacity(0.98),
                    child: Padding(
                      padding: const EdgeInsets.all(_UIConstants.cardPadding),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Describe Your Learning Goal',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: _UIConstants.darkTextColor,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: _UIConstants.cardPadding),
                            TextFormField(
                              controller: goalController,
                              decoration: inputDecoration.copyWith(
                                labelText: 'Primary Goal',
                                prefixIcon: const Icon(
                                  Icons.flag_outlined,
                                  color: _UIConstants.primaryGreen,
                                ),
                              ),
                              validator: (value) =>
                                  (value == null || value.isEmpty)
                                      ? 'Please enter your goal'
                                      : null,
                              maxLines: 2,
                              style: const TextStyle(color: Colors.black),
                            ),
                            const SizedBox(height: _UIConstants.widgetSpacing),
                            TextFormField(
                              controller: experienceController,
                              decoration: inputDecoration.copyWith(
                                labelText: 'Current Experience Level',
                                prefixIcon: const Icon(
                                  Icons.bar_chart_outlined,
                                  color: _UIConstants.primaryGreen,
                                ),
                              ),
                              validator: (value) =>
                                  (value == null || value.isEmpty)
                                      ? 'Please describe your experience'
                                      : null,
                              maxLines: 2,
                              style: const TextStyle(color: Colors.black),
                            ),
                            const SizedBox(height: _UIConstants.widgetSpacing),
                            TextFormField(
                              controller: skillsController,
                              decoration: inputDecoration.copyWith(
                                labelText: 'Existing Skills (comma-separated)',
                                prefixIcon: const Icon(
                                  Icons.code_outlined,
                                  color: _UIConstants.primaryGreen,
                                ),
                              ),
                              style: const TextStyle(color: Colors.black),
                            ),
                            const SizedBox(height: 32),
                            ElevatedButton.icon(
                              onPressed: generateRoadmap,
                              icon: const Icon(Icons.auto_awesome, color: Colors.white),
                              label: const Text('Generate My Learning Path'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _UIConstants.primaryGreen,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      _UIConstants.borderRadius)),
                                elevation: 5,
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}