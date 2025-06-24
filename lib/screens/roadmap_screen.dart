import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/providers/roadmap_provider.dart';
// Assuming RoadmapStepWidget is a custom widget you have defined
import '/widgets/roadmap_step_widget.dart';

// --- UI Constants for a Consistent App-Wide Theme ---
class _UIConstants {
  // Professional Green Color Palette
  static const Color primaryGreen = Color(0xFF00695C);
  static const Color secondaryGreen = Color(0xFF004D40);
  static const Color darkTextColor = Color(0xFF1F2937);
  static const Color errorColor = Color(0xFFD32F2F);

  // Consistent Padding and Radii
  static const double pagePadding = 16.0;
  static const double borderRadius = 16.0;
}

class RoadmapScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> query;

  const RoadmapScreen({super.key, required this.query});

  @override
  ConsumerState<RoadmapScreen> createState() => _RoadmapScreenState();
}

class _RoadmapScreenState extends ConsumerState<RoadmapScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final roadmapAsyncValue = ref.watch(roadmapProvider(widget.query));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Your Learning Path',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white, // Ensures back button is white
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _UIConstants.primaryGreen,
              _UIConstants.secondaryGreen,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SafeArea(
            child: roadmapAsyncValue.when(
              data: (roadmap) {
                // Only forward animation when data is ready
                _animationController.forward();
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(_UIConstants.pagePadding),
                    itemCount: roadmap.steps.length,
                    itemBuilder: (context, index) {
                      final step = roadmap.steps[index];
                      return Card(
                        elevation: 4.0,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(_UIConstants.borderRadius),
                        ),
                        clipBehavior: Clip.antiAlias, // Ensures child respects the border radius
                        child: RoadmapStepWidget(step: step), // Your custom widget
                      );
                    },
                  ),
                );
              },
              error: (err, stack) => _StyledErrorState(error: err.toString()),
              loading: () => const _StyledLoadingState(),
            ),
          ),
        ),
      ),
    );
  }
}

/// A styled widget to display while the roadmap is being generated.
class _StyledLoadingState extends StatelessWidget {
  const _StyledLoadingState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 4.0,
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Generating Your Learning Path...',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// A styled widget to display when an error occurs.
class _StyledErrorState extends StatelessWidget {
  final String error;
  const _StyledErrorState({required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_UIConstants.borderRadius),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.warning_amber_rounded,
                  color: _UIConstants.errorColor,
                  size: 50,
                ),
                const SizedBox(height: 16),
                Text(
                  'Something Went Wrong',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: _UIConstants.darkTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  error,
                  style: TextStyle(color: _UIConstants.darkTextColor.withOpacity(0.7)),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}