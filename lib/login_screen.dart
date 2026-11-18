import 'package:flutter/material.dart';
import 'app_state.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  final AppState appState;
  const LoginScreen({super.key, required this.appState});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = true; // Toggles between Login and Register

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  String? errorMessage;

  void _submit() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final password = _passwordController.text.trim();

    setState(() => errorMessage = null); // Clear old errors

    if (isLogin) {
      // --- LOGIN MODE ---
      if (email.isEmpty || password.isEmpty) {
        setState(() => errorMessage = "Please enter your email and password.");
        return;
      }

      if (widget.appState.login(email, password)) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(appState: widget.appState)),
        );
      } else {
        setState(() => errorMessage = "Incorrect email or password.");
      }
    } else {
      // --- REGISTER MODE ---
      // Field validation
      if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
        setState(() => errorMessage = "Please fill in all fields.");
        return;
      }
      
      if (name.length < 2) {
        setState(() => errorMessage = "Name must be at least 2 characters long.");
        return;
      }

      if (!email.contains('@') || !email.contains('.')) {
        setState(() => errorMessage = "Please enter a valid email address.");
        return;
      }

      if (phone.length != 9 || !phone.startsWith('7')) {
        setState(() => errorMessage = "Phone number must be 9 digits and start with 7.");
        return;
      }

      if (password.length < 8) {
        setState(() => errorMessage = "Password must be at least 8 characters long.");
        return;
      }

      // If everything is correct, register
      bool success = await widget.appState.register(name, email, phone, password);
      
      if (success) {
        setState(() {
          errorMessage = null;
          isLogin = true; // Switch back to login mode
          // Clear fields
          _nameController.clear();
          _phoneController.clear();
          _passwordController.clear();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account created successfully! Please log in.'),
            backgroundColor: Color(0xFF1E8E5A),
          ),
        );
      } else {
        setState(() => errorMessage = "This email is already registered.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F8FA),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.local_hospital, size: 80, color: Color(0xFF087F8C)),
                const SizedBox(height: 20),
                Text(
                  isLogin ? 'Welcome to MediCare' : 'Create an Account',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF243746)),
                ),
                const SizedBox(height: 10),
                Text(
                  isLogin ? 'Log in to manage your appointments.' : 'Tell us a little about you.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Color(0xFF587080)),
                ),
                const SizedBox(height: 30),

                // Extra fields for Register
                if (!isLogin) ...[
                  _buildTextField(_nameController, 'Full Name', Icons.person),
                  const SizedBox(height: 16),
                  _buildTextField(_phoneController, 'Phone Number (e.g. 788123456)', Icons.phone, keyboardType: TextInputType.phone),
                  const SizedBox(height: 16),
                ],

                _buildTextField(_emailController, 'Email', Icons.email, keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 16),
                _buildTextField(_passwordController, 'Password', Icons.lock, isPassword: true),
                
                const SizedBox(height: 10),
                
                // Error message display
                if (errorMessage != null)
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFDECEA),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFB3261E)),
                    ),
                    child: Text(errorMessage!, style: const TextStyle(color: Color(0xFFB3261E), fontWeight: FontWeight.bold)),
                  ),
                
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF087F8C),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text(
                    isLogin ? 'Log in' : 'Register',
                    style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                
                // Toggle between Login and Register
                TextButton(
                  onPressed: () {
                    setState(() {
                      isLogin = !isLogin;
                      errorMessage = null; // Clear errors when switching modes
                    });
                  },
                  child: Text(
                    isLogin ? "Don't have an account? Create one" : "Already have an account? Log in",
                    style: const TextStyle(color: Color(0xFF087F8C), fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isPassword = false, TextInputType? keyboardType}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF087F8C)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFDCE6EB)),
        ),
      ),
    );
  }
}