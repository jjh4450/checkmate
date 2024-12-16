import 'package:flutter/material.dart';
import 'package:checkmate/const/colors.dart';
import 'package:checkmate/data/auth_data.dart';
import 'package:lottie/lottie.dart';

class LogIN_Screen extends StatefulWidget {
  final VoidCallback show;
  LogIN_Screen(this.show, {super.key});

  @override
  State<LogIN_Screen> createState() => _LogIN_ScreenState();
}

class _LogIN_ScreenState extends State<LogIN_Screen> {
  static const double _spacing = 16.0;
  static const double _buttonHeight = 56.0;
  static const double _imageHeight = 300.0;

  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void initState() {
    super.initState();
    [_focusNode1, _focusNode2].forEach((node) {
      node.addListener(() => setState(() {}));
    });
  }

  @override
  void dispose() {
    [_focusNode1, _focusNode2].forEach((node) => node.dispose());
    [email, password].forEach((controller) => controller.dispose());
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
                const SizedBox(height: 24),
                _buildLoginButton(),
                const SizedBox(height: 20),
                _buildSignUpLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Text(
      'Check Mate login',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 15,
          ),
        ),
        TextButton(
          onPressed: widget.show,
          child: Text(
            'Sign Up',
            style: TextStyle(
              color: customBlack,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () => AuthenticationRemote().login(email.text, password.text),
      style: ElevatedButton.styleFrom(
        backgroundColor: customBlack,
        minimumSize: Size(double.infinity, _buttonHeight),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text(
        'Login',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildEmailField() => _buildTextField(
        controller: email,
        focusNode: _focusNode1,
        hintText: 'Email',
        icon: Icons.email,
      );

  Widget _buildPasswordField() => _buildTextField(
        controller: password,
        focusNode: _focusNode2,
        hintText: 'Password',
        icon: Icons.lock,
        obscureText: true,
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
      obscureText: obscureText,
      style: const TextStyle(fontSize: 16, color: Colors.black87),
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: focusNode.hasFocus ? customBlack : Colors.grey[400],
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
        color: focused ? customBlack : Colors.grey[300]!,
        width: focused ? 2 : 1,
      ),
    );
  }

  Widget _buildImage() {
    return Lottie.asset(
      'images/7.json',
      width: double.infinity,
      height: 250,
      fit: BoxFit.contain,
      alignment: Alignment.center,
    );
  }
}
