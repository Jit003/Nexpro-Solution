import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexpro_solution/Controller/login_controller.dart';
import 'package:nexpro_solution/Screens/Home%20Screen/home_screen.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(5, 21, 56, 1),
              Color.fromRGBO(24, 99, 164, 1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Section
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/Nexpro-Solution-Logo.png', // Add your logo image path here
                  height: 70,
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 30),
                // Form Section
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromRGBO(5, 21, 56, 1),
                        Color.fromRGBO(24, 99, 164, 1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            'Welcome to NexPro Solution',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Email Field
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: emailController,
                          onChanged: (value) =>
                              authController.email.value = value,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'example@gmail.com',
                            labelStyle: const TextStyle(
                              color: Colors.white, // Label text color
                              fontSize: 16,
                            ),
                            hintStyle: const TextStyle(
                              color: Colors.white, // Hint text color
                              fontSize: 14,
                            ),
                            prefixIcon: const Icon(Icons.email,
                                color: Colors.orangeAccent),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide:
                                  const BorderSide(color: Colors.orangeAccent),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        // Password Field
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: passwordController,
                          onChanged: (value) =>
                              authController.password.value = value,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: '*******',
                            labelStyle: const TextStyle(
                              color: Colors.white, // Label text color
                              fontSize: 16,
                            ),
                            hintStyle: const TextStyle(
                              color: Colors.white, // Hint text color
                              fontSize: 14,
                            ),
                            prefixIcon: const Icon(Icons.lock,
                                color: Colors.orangeAccent),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide:
                                  const BorderSide(color: Colors.orangeAccent),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        // Terms and Conditions
                        const SizedBox(height: 20),
                        // Register Button
                        Obx(() => authController.isLoading.value
                            ? Center(child: CircularProgressIndicator())
                            : SizedBox(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: authController.login,
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.orangeAccent),
                                    child: const Text('Login',style: TextStyle(
                                      color: Colors.white
                                    ),),
                                  ),
                                ),
                              )),
                        const SizedBox(height: 15),
                        // Social Media Section
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
