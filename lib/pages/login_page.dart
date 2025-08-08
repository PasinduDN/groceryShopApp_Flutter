import 'package:flutter/material.dart';
import 'package:grocery_shop/services/auth_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';
  bool _isLoading = false;

  Future<void> _handleSignUp(AuthService authService) async {
    if (!_validateInputs()) return;

    setState(() => _isLoading = true);
    final user = await authService.signUpWithEmailAndPassword(
      _emailController.text,
      _passwordController.text,
    );
    if (user == null) {
      setState(() {
        _errorMessage = 'Could not sign up. The email may already be in use.';
      });
    }
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _handleSignIn(AuthService authService) async {
    if (!_validateInputs()) return;

    setState(() => _isLoading = true);
    final user = await authService.signInWithEmailAndPassword(
      _emailController.text,
      _passwordController.text,
    );
    if (user == null) {
      setState(() {
        _errorMessage = 'Could not sign in. Please check your credentials.';
      });
    }
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  bool _validateInputs() {
    setState(() => _errorMessage = '');
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() => _errorMessage = 'Email and password cannot be empty.');
      return false;
    }
    if (!_emailController.text.contains('@') || !_emailController.text.contains('.')) {
      setState(() => _errorMessage = 'Please enter a valid email address.');
      return false;
    }
    if (_passwordController.text.length < 6) {
      setState(() => _errorMessage = 'Password must be at least 6 characters.');
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Login / Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 20),
            if (_isLoading)
              const CircularProgressIndicator()
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _handleSignIn(authService),
                    child: const Text('Sign In'),
                  ),
                  ElevatedButton(
                    onPressed: () => _handleSignUp(authService),
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}