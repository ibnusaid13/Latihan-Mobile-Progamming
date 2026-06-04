import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'login_api.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  // State untuk UI
  bool _isObscure = true;
  bool _isLoading = false;

  final Dio _dio = Dio(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background bersih
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Bagian Header
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          "Create Account",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Sign up to get started",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // Form Input Name
                  TextFormField(
                    validator: (value) => Validator.validateName(value ?? ""),
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: "Full Name",
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      prefixIcon: const Icon(Icons.person_outline, color: Colors.blue),
                      filled: true,
                      fillColor: Colors.blueGrey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Form Input Email
                  TextFormField(
                    validator: (value) => Validator.validateEmail(value ?? ""),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      prefixIcon: const Icon(Icons.email_outlined, color: Colors.blue),
                      filled: true,
                      fillColor: Colors.blueGrey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Form Input Password
                  TextFormField(
                    obscureText: _isObscure,
                    validator: (value) => Validator.validatePassword(value ?? ""),
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      prefixIcon: const Icon(Icons.lock_outline, color: Colors.blue),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey[600],
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                      filled: true,
                      fillColor: Colors.blueGrey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // Tombol Register
                  SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleRegister,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                            )
                          : const Text(
                              "Register",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Opsi Kembali ke Login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(color: Colors.grey[700], fontSize: 15),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context); // Kembali ke halaman Login
                        },
                        child: const Text(
                          "Log in",
                          style: TextStyle(
                            color: Colors.blue, 
                            fontWeight: FontWeight.bold, 
                            fontSize: 15
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Munculkan indikator loading
      });

      Map<String, dynamic> userData = {
        "name": nameController.text,
        "email": emailController.text,
        "password": passwordController.text,
      };

      try {
        Response response = await _apiClient(_dio).registerUser(userData);
        
        if (response.statusCode == 200 || response.statusCode == 201) {
          // Menampilkan dialog sukses
          if (!mounted) return;
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                title: const Text("Success", style: TextStyle(color: Colors.blue)),
                content: const Text("Registrasi berhasil! Silakan Log in."),
                actions: <Widget>[
                  TextButton(
                    child: const Text("OK", style: TextStyle(color: Colors.blue)),
                    onPressed: () {
                      Navigator.of(context).pop(); 
                      Navigator.pushReplacement(
                        context, 
                        MaterialPageRoute(builder: (context) => const Login())
                      );
                    },
                  ),
                ],
              );
            },
          );
        } else {
          _showErrorSnackbar('Gagal melakukan registrasi, coba lagi.');
        }
      } on DioError catch (e) {
        String errorMessage = 'Terjadi kesalahan pada server';
        if (e.response != null && e.response?.data != null) {
          if (e.response?.data is Map) {
            errorMessage = e.response?.data['message'] ?? e.response?.data['Message'] ?? errorMessage;
          } else {
             errorMessage = e.message ?? errorMessage;
          }
        }
        _showErrorSnackbar('Error: $errorMessage');
      } catch (e) {
        _showErrorSnackbar('Error: $e');
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false; // Matikan indikator loading
          });
        }
      }
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red.shade400,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
  }
}

class Validator {
  static String? validateName(String value) {
    if (value.length < 3) {
      return 'Nama terlalu pendek.';
    } else {
      return null;
    }
  }

  static String? validateEmail(String value) {
    Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return 'Masukkan alamat email yang valid.';
    } else {
      return null;
    }
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return "Password tidak boleh kosong";
    }
    return null;
  }
}

class _apiClient {
  final Dio _dio;
  _apiClient(this._dio); 

  Future<Response> registerUser(Map<String, dynamic> userData) async {
    try {
      FormData formData = FormData.fromMap(userData);
      
      Response response = await _dio.post(
        'https://mobileapp.e-budgeting.com/api/register',
        data: formData, 
      );
      return response;
    } on DioError {
      rethrow; 
    }
  }
}