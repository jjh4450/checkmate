import 'package:flutter/material.dart';
import 'package:checkmate/const/colors.dart';
import 'package:checkmate/data/auth_data.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback show;
  const SignUpScreen(this.show, {super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  static const double _spacing = 16.0;
  static const double _buttonHeight = 56.0;
  static const double _imageHeight = 300.0;
  
  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();
  final _focusNode3 = FocusNode();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  @override
  void initState() {
    super.initState();
    [_focusNode1, _focusNode2, _focusNode3].forEach((node) {
      node.addListener(() => setState(() {}));
    });
  }

  @override
  void dispose() {
    [_focusNode1, _focusNode2, _focusNode3].forEach((node) => node.dispose());
    [_emailController, _passwordController, _passwordConfirmController]
        .forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(_spacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _buildHeader(),
                const SizedBox(height: 30),
                _buildImage(),
                const SizedBox(height: 30),
                _buildEmailField(),
                const SizedBox(height: _spacing),
                _buildPasswordField(),
                const SizedBox(height: _spacing),
                _buildConfirmPasswordField(),
                const SizedBox(height: 24),
                _buildSignUpButton(),
                const SizedBox(height: 20),
                _buildLoginLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Text(
      'Create Account',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?",
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 15,
          ),
        ),
        TextButton(
          onPressed: widget.show,
          child: Text(
            'Login',
            style: TextStyle(
              color: customGreen,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpButton() {
    return ElevatedButton(
      onPressed: _handleSignUp,
      style: ElevatedButton.styleFrom(
        backgroundColor: customGreen,
        minimumSize: Size(double.infinity, _buttonHeight),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text(
        'Sign Up',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _handleSignUp() {
    AuthenticationRemote().register(
      _emailController.text,
      _passwordController.text,
      _passwordConfirmController.text,
    );
  }

  Widget _buildEmailField() => _buildTextField(
        controller: _emailController,
        focusNode: _focusNode1,
        hintText: 'Email',
        icon: Icons.email,
      );

  Widget _buildPasswordField() => _buildTextField(
        controller: _passwordController,
        focusNode: _focusNode2,
        hintText: 'Password',
        icon: Icons.lock,
        obscureText: true,
      );

  Widget _buildConfirmPasswordField() => _buildTextField(
        controller: _passwordConfirmController,
        focusNode: _focusNode3,
        hintText: 'Confirm Password',
        icon: Icons.lock,
        obscureText : true
      );

  Widget _buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      style: const TextStyle(fontSize: 16, color: Colors.black87),
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: focusNode.hasFocus ? customGreen : Colors.grey[400],
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[500]),
        filled: true,
        fillColor: Colors.white,
        border: _buildInputBorder(),
        enabledBorder: _buildInputBorder(),
        focusedBorder: _buildInputBorder(focused: true),
      ),
    );
  }

  OutlineInputBorder _buildInputBorder({bool focused = false}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: focused ? customGreen : Colors.grey[300]!,
        width: focused ? 2 : 1,
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      width: double.infinity,
      height: _imageHeight,
      decoration: BoxDecoration(
        color: backgroundColors,
        image: const DecorationImage(
          image: AssetImage('images/7.png'),
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
