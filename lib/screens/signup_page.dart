import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  final TextEditingController _passwordController = TextEditingController();

  bool _isNameFocused = false;
  bool _isEmailFocused = false;
  bool _isPasswordFocused = false;
  bool _isConfirmPasswordFocused = false;

  @override
  void initState() {
    super.initState();

    _nameFocusNode.addListener(() {
      setState(() {
        _isNameFocused = _nameFocusNode.hasFocus;
      });
    });
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
    _confirmPasswordFocusNode.addListener(() {
      setState(() {
        _isConfirmPasswordFocused = _confirmPasswordFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _buildAnimatedField({
    required FocusNode focusNode,
    required String label,
    String? hint,
    IconData? prefixIcon,
    bool obscureText = false,
    TextEditingController? controller,
    String? Function(String?)? validator,
  }) {
    bool isFocused = focusNode.hasFocus;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: TextFormField(
        focusNode: focusNode,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: isFocused ? null : label,
          hintText: isFocused ? hint : null,
          labelStyle: const TextStyle(
            color: Color.fromARGB(179, 213, 199, 199),
          ),
          filled: true,
          fillColor: isFocused
              ? Colors.white.withOpacity(0.4)
              : Colors.white.withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: Colors.white70)
              : null,
        ),
        style: const TextStyle(color: Colors.white),
        validator: validator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Transparent AppBar with white back icon
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      extendBodyBehindAppBar: true, // So gradient goes behind AppBar
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
                  const SizedBox(height: 40), // Space under AppBar
                  const Text(
                    "Create Account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Name Field
                  _buildAnimatedField(
                    focusNode: _nameFocusNode,
                    label: "Full Name",
                    hint: "Enter your full name",
                    prefixIcon: Icons.person,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Name is required";
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Email Field
                  _buildAnimatedField(
                    focusNode: _emailFocusNode,
                    label: "Email",
                    hint: "Enter your email",
                    prefixIcon: Icons.email,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Email is required";
                      if (!value.contains("@")) return "Enter a valid email";
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Password Field
                  _buildAnimatedField(
                    focusNode: _passwordFocusNode,
                    label: "Password",
                    hint: "Enter your password",
                    prefixIcon: Icons.lock,
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.length < 6)
                        return "Password must be at least 6 characters";
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Confirm Password Field
                  _buildAnimatedField(
                    focusNode: _confirmPasswordFocusNode,
                    label: "Confirm Password",
                    hint: "Re-enter your password",
                    prefixIcon: Icons.lock_outline,
                    obscureText: true,
                    validator: (value) {
                      if (value != _passwordController.text)
                        return "Passwords do not match";
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),

                  // Sign Up Button
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
                          const SnackBar(content: Text("Account Created")),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 18,
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
    );
  }
}
