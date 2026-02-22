import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  // Friendly soft indigo color often used in modern accessible apps
  final Color primaryColor = const Color(0xFF6366F1);
  final Color bgColor = const Color(0xFFF8FAFC);
  final Color inputColor = const Color(0xFFF1F5F9);
  final Color textDark = const Color(0xFF0F172A);
  final Color textLight = const Color(0xFF64748B);

  void _handleLogin() {
    context.go('/home');
  }

  void _handleGoogle() {
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Top Image Header with Curved Bottom
            SizedBox(
              height: size.height * 0.38,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Book background image
                  Image.asset(
                    'assets/images/splash_bg.jpg',
                    fit: BoxFit.cover,
                    // Error fallback to a colored container
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: primaryColor,
                      child: const Center(
                        child: Icon(
                          Icons.menu_book,
                          size: 80,
                          color: Colors.white24,
                        ),
                      ),
                    ),
                  ),
                  // Dark overlay gradient so the image isn't too harsh
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.1),
                          Colors.black.withValues(alpha: 0.5),
                        ],
                      ),
                    ),
                  ),
                  // App Name over the image
                  SafeArea(
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.auto_stories_rounded,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'My BookShelf',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 2. White Card with Form overlapping the image
            Transform.translate(
              offset: const Offset(0, -32), // Pull it up over the image
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Welcome Back 👋',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Log in to your account to continue',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, color: textLight),
                    ),
                    const SizedBox(height: 32),

                    // Email Field
                    _buildInputField(
                      controller: _emailController,
                      hint: 'Email Address',
                      icon: Icons.email_rounded,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),

                    // Password Field
                    _buildInputField(
                      controller: _passwordController,
                      hint: 'Password',
                      icon: Icons.lock_rounded,
                      obscureText: _obscurePassword,
                      suffix: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                          color: textLight,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: primaryColor,
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        child: const Text('Forgot password?'),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Log In Button
                    ElevatedButton(
                      onPressed: _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Divider
                    Row(
                      children: [
                        Expanded(
                          child: Divider(color: inputColor, thickness: 2),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Or',
                            style: TextStyle(
                              color: textLight,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(color: inputColor, thickness: 2),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Google Login Button
                    OutlinedButton(
                      onPressed: _handleGoogle,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: textDark,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: inputColor, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Small colored Google icon
                          Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/c/c1/Google_%22G%22_logo.svg',
                            height: 20,
                            width: 20,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                                  Icons.g_mobiledata_rounded,
                                  size: 24,
                                ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Continue with Google',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Sign Up Text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(color: textLight, fontSize: 15),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    TextInputType? keyboardType,
    Widget? suffix,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: TextStyle(color: textDark, fontSize: 16),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: textLight),
        prefixIcon: Icon(icon, color: textLight),
        suffixIcon: suffix,
        filled: true,
        fillColor: inputColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
