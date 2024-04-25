import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'enterprisedashoard.dart';
import 'farmersdashboard.dart';
import 'forgot_password.dart';
import 'microfinacedashboard.dart';
import 'registration.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>(); // Key for the form

  bool wrongCredentials = false;
  bool obscurePassword = true; // State variable to toggle password visibility

  Future<void> _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        // Determine the user type based on their email address
        String email = userCredential.user!.email!;
        String userType = getUserTypeFromEmail(email);

        if (userType != 'unsupported') {
          // Navigate to the respective dashboard based on user type
          switch (userType) {
            case 'farmer':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => FarmerDashboard()),
              );
              break;
            case 'enterprise':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => EnterpriseDashboard()),
              );
              break;
            case 'microfinance':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MicrofinanceDashboard()),
              );
              break;
            default:
              print('Unsupported user type');
              break;
          }
        } else {
          // Handle unsupported user type
          print('Unsupported user type');
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          wrongCredentials = true;
        });
        print('Error: ${e.message}');
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  // Function to extract user type from email
  String getUserTypeFromEmail(String email) {
    if (email.endsWith('@farmer.com')) {
      return 'farmer';
    } else if (email.endsWith('@enterprise.com')) {
      return 'enterprise';
    } else if (email.endsWith('@microfinance.com')) {
      return 'microfinance';
    } else {
      return 'unsupported'; // Default to unsupported if the email doesn't match known patterns
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/homepicture.jpg',
                  height: 200, // Adjust the height as needed
                ),
                const SizedBox(height: 20.0),
                Form(
                  key: _formKey, // Assign the form key
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 20.0),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }
                            // Check if the email follows the standard format
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return 'Invalid email format';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 20.0),
                            suffixIcon: IconButton(
                              icon: Icon(obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  // Toggle password visibility
                                  obscurePassword = !obscurePassword;
                                });
                              },
                            ),
                          ),
                          obscureText: obscurePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                          height:
                              20.0), // Add space between back button and email field
                      if (wrongCredentials) // Display error message if wrong credentials
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Wrong email or password. Please try again.',
                            style: TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      const SizedBox(height: 8.0),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPasswordPage(),
                              ),
                            );
                          },
                          child: const Text('Forgot Password?'),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () => _login(context),
                        child: const Text('Login'),
                      ),
                      const SizedBox(height: 10.0),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()),
                          );
                        },
                        child:
                            const Text('Don\'t have an account? Register here'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
