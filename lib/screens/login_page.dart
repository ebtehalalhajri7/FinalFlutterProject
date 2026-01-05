import 'package:flutter/material.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  // Focus nodes for email and password
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  bool _isEmailFocused = false;
  bool _isPasswordFocused = false;

  @override
  void initState() {
    super.initState();

    _emailFocusNode.addListener(() {
      setState(() {
        _isEmailFocused = _emailFocusNode.hasFocus;
      });
    });

    _passwordFocusNode.addListener(() {
      setState(() {
        _isPasswordFocused = _passwordFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 37, 15, 49),
              Color.fromARGB(255, 65, 29, 83),
              Color.fromARGB(255, 102, 48, 121),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Welcome Back",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Email Field
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    child: TextFormField(
                      focusNode: _emailFocusNode,
                      decoration: InputDecoration(
                        labelText: _isEmailFocused ? null : "Email",
                        hintText: _isEmailFocused ? "Enter your email" : null,
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(179, 213, 199, 199),
                        ),
                        filled: true,
                        fillColor: _isEmailFocused
                            ? const Color.fromARGB(
                                255,
                                214,
                                208,
                                208,
                              ).withOpacity(0.4)
                            : Colors.white.withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.white70,
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email is required";
                        }
                        if (!value.contains("@")) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password Field
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    child: TextFormField(
                      focusNode: _passwordFocusNode,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: _isPasswordFocused ? null : "Password",
                        hintText: _isPasswordFocused
                            ? "Enter your password"
                            : null,
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(179, 213, 199, 199),
                        ),
                        filled: true,
                        fillColor: _isPasswordFocused
                            ? const Color.fromARGB(
                                255,
                                214,
                                208,
                                208,
                              ).withOpacity(0.4)
                            : Colors.white.withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.white70,
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Login Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 5,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Login Successful")),
                        );
                      }
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Go to Sign Up
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SignUpPage()),
                      );
                    },
                    child: const Text(
                      "Create new account",
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
