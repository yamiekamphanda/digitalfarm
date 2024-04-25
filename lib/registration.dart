import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'enterprisedashoard.dart';
import 'farmersdashboard.dart';
import 'login.dart';
import 'microfinacedashboard.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _accountExistsError;

  // Define user types
  List<String> userTypes = ['Farmer', 'Enterprise', 'Microfinance'];
  String selectedUserType = 'Farmer'; // Default user type

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _confirmPasswordVisible = !_confirmPasswordVisible;
    });
  }

  Future<void> _register(BuildContext context) async {
    if (_validateFields()) {
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        // Update user profile with first name and last name
        await userCredential.user!.updateProfile(
            displayName:
                '${firstNameController.text.trim()} ${lastNameController.text.trim()}');

        // Registration successful, navigate to respective dashboard based on user type
        switch (selectedUserType) {
          case 'Farmer':
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => FarmerDashboard()));
            break;
          case 'Enterprise':
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => EnterpriseDashboard()));
            break;
          case 'Microfinance':
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MicrofinanceDashboard()));
            break;
          default:
            // Handle unsupported user type
            print('Unsupported user type');
            break;
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          _showSnackBar(context, 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          setState(() {
            _accountExistsError = 'The account already exists for that email.';
          });
        } else {
          print('Error: ${e.message}');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  bool _validateFields() {
    bool isValid = true;

    if (emailController.text.trim().isEmpty) {
      _emailError = 'Email is required.';
      isValid = false;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(emailController.text.trim())) {
      _emailError = 'Invalid email format.';
      isValid = false;
    } else {
      _emailError = null;
    }

    if (passwordController.text.trim().isEmpty) {
      _passwordError = 'Password is required.';
      isValid = false;
    } else if (passwordController.text.trim().length < 6) {
      _passwordError = 'Password must be at least 6 characters long.';
      isValid = false;
    } else {
      _passwordError = null;
    }

    if (confirmPasswordController.text.trim() !=
        passwordController.text.trim()) {
      _confirmPasswordError = 'Passwords do not match.';
      isValid = false;
    } else {
      _confirmPasswordError = null;
    }

    setState(() {}); // Update the UI with error messages
    return isValid;
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 140.0),
          Text(
            'Create an Account',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      child: TextField(
                        controller: firstNameController,
                        decoration:
                            const InputDecoration(labelText: 'First Name'),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      child: TextField(
                        controller: lastNameController,
                        decoration:
                            const InputDecoration(labelText: 'Last Name'),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      child: TextField(
                        controller: emailController,
                        decoration: const InputDecoration(labelText: 'Email'),
                      ),
                    ),
                    if (_emailError != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          _emailError!,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    if (_accountExistsError != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          _accountExistsError!,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    const SizedBox(height: 8.0),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      child: TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: _togglePasswordVisibility,
                          ),
                        ),
                        obscureText: !_passwordVisible,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    if (_passwordError != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          _passwordError!,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    const SizedBox(height: 8.0),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      child: TextField(
                        controller: confirmPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _confirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: _toggleConfirmPasswordVisibility,
                          ),
                        ),
                        obscureText: !_confirmPasswordVisible,
                      ),
                    ),
                    if (_confirmPasswordError != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          _confirmPasswordError!,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    const SizedBox(height: 20.0),
                    DropdownButtonFormField<String>(
                      value: selectedUserType,
                      items: userTypes.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedUserType = newValue!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'User Type',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () => _register(context),
                      child: const Text('Register'),
                    ),
                    const SizedBox(height: 15.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        'Already have an account? Login here',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
