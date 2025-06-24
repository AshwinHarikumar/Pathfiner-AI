import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/services/auth_service.dart';

// --- UI Constants for a Consistent App-Wide Theme ---
class _UIConstants {
  // Professional Green Color Palette
  static const Color primaryGreen = Color(0xFF00695C); // Deep teal green
  static const Color secondaryGreen = Color(0xFF004D40); // Darker shade
  static const Color accentGreen = Color(0xFF4DB6AC); // Lighter accent for success states
  static const Color lightGreenBackground = Color(0xFFF0F7F7); // Light background for inputs
  static const Color darkTextColor = Color(0xFF1F2937); // Dark charcoal for readability
  static const Color errorColor = Color(0xFFD32F2F); // A standard material red for errors

  // Consistent Padding and Radii
  static const double pagePadding = 24.0;
  static const double cardPadding = 28.0;
  static const double widgetSpacing = 16.0;
  static const double borderRadius = 16.0;
}

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: _UIConstants.errorColor,
      ),
    );
  }

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        await ref.read(authServiceProvider).signInWithEmail(
              _emailController.text.trim(),
              _passwordController.text.trim(),
            );
        // AuthGate will handle navigation
      } catch (e) {
        _showErrorSnackBar('Sign in failed: ${e.toString()}');
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        await ref.read(authServiceProvider).signUpWithEmail(
              _emailController.text.trim(),
              _passwordController.text.trim(),
            );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Success! Please check your email for a confirmation link.'),
            backgroundColor: _UIConstants.accentGreen,
          ),
        );
      } catch (e) {
        _showErrorSnackBar('Sign up failed: ${e.toString()}');
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Reusable input decoration for a consistent look
    final inputDecoration = InputDecoration(
      labelStyle: const TextStyle(color: _UIConstants.primaryGreen),
      filled: true,
      fillColor: _UIConstants.lightGreenBackground,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_UIConstants.borderRadius),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_UIConstants.borderRadius),
        borderSide: const BorderSide(color: _UIConstants.primaryGreen, width: 2.0),
      ),
    );
    
    return Scaffold(
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(_UIConstants.pagePadding),
            child: SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(_UIConstants.borderRadius),
                  ),
                  color: Colors.white.withOpacity(0.98),
                  child: Padding(
                    padding: const EdgeInsets.all(_UIConstants.cardPadding),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Welcome',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: _UIConstants.darkTextColor,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Your Learning Journey Starts Here',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: _UIConstants.darkTextColor.withOpacity(0.7)
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),
                          TextFormField(
                            controller: _emailController,
                            cursorColor: Colors.black87,
                            decoration: inputDecoration.copyWith(
                              labelText: 'Email',
                              prefixIcon: const Icon(Icons.email_outlined, color: _UIConstants.primaryGreen),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) =>
                                (value == null || !value.contains('@'))
                                    ? 'Please enter a valid email'
                                    : null,
                            style: const TextStyle(color: Colors.black),
                          ),
                          const SizedBox(height: _UIConstants.widgetSpacing),
                          TextFormField(
                            controller: _passwordController,
                            decoration: inputDecoration.copyWith(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock_outline, color: _UIConstants.primaryGreen),
                            ),
                            obscureText: true,
                            validator: (value) =>
                                (value == null || value.length < 6)
                                    ? 'Password must be at least 6 characters'
                                    : null,
                            style: const TextStyle(color: Colors.black),
                          ),
                          const SizedBox(height: 24),
                          if (_isLoading)
                            const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  _UIConstants.primaryGreen,
                                ),
                              ),
                            )
                          else
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ElevatedButton(
                                  onPressed: _signIn,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _UIConstants.primaryGreen,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(_UIConstants.borderRadius),
                                    ),
                                    elevation: 5,
                                  ),
                                  child: const Text('Sign In',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(height: 12),
                                TextButton(
                                  onPressed: _signUp,
                                  child: const Text(
                                    'Don\'t have an account? Sign Up',
                                    style: TextStyle(color: _UIConstants.primaryGreen),
                                  ),
                                ),
                              ],
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
    );
  }
}