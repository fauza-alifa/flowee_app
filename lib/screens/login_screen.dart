import 'package:flowee_app/data/dummy_data.dart';
import 'package:flowee_app/screens/main_screen.dart';
import 'package:flowee_app/state/auth_controller.dart';
import 'package:flowee_app/theme/app_theme.dart';
import 'package:flowee_app/widgets/decorative_glow.dart';
import 'package:flowee_app/widgets/login_brand_header.dart';
import 'package:flowee_app/widgets/login_form_card.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: DummyUser.email);
  final _passwordController = TextEditingController(text: DummyUser.password);
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    await Future.delayed(Duration(milliseconds: 600));

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (email == DummyUser.email && password == DummyUser.password) {
      await AuthController.instance.login();
      if (!mounted) return;
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const MainScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email atau password salah. Mohon dicoba kembali'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppTheme.primary, AppTheme.primaryDark],
          ),
        ),
        // Stack menumpuk beberapa widget di atas satu sama lain. Di sini:
        // hiasan glow paling belakang, lalu konten form di atasnya.
        child: Stack(
          children: [
            const Positioned(top: -70, right: -50, child: DecorativeGlow(220)),
            const Positioned(
              bottom: -90,
              left: -70,
              child: DecorativeGlow(260),
            ),
            const Positioned(top: 190, left: -40, child: DecorativeGlow(110)),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    const LoginBrandHeader(),
                    const SizedBox(height: 36),
                    LoginFormCard(
                      formKey: _formKey,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      isLoading: _isLoading,
                      onSubmit: _login,
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
}
