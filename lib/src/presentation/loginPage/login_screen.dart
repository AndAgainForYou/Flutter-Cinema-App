import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cinema_application/main.dart';
import 'package:flutter_cinema_application/src/api/api_service.dart';
import 'package:flutter_cinema_application/src/data/bloc/data_bloc.dart';
import 'package:flutter_cinema_application/src/data/bloc/data_event.dart';
import 'package:flutter_cinema_application/src/presentation/loginPage/bloc/login_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  final String phoneNumber;

  const LoginPage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _phoneController.text = widget.phoneNumber;
  }

  final _otpController = TextEditingController();

  final bool _isLoading = false;
  int? _errorMessage;

  @override
  Widget build(BuildContext context) {
    ApiService.registrationWithOtp(widget.phoneNumber);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF121025),
        iconTheme: const IconThemeData(color: Color(0xFF9E98A9)),
        title: Text(
          'OTP Login',
          style: GoogleFonts.openSans(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Color(0xFF9E98A9),
            ),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone number:',
                    labelStyle: TextStyle(color: Color(0xFF9E98A9)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Color(0xFF9E98A9))),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) => value.length == 4
                      ? BlocProvider.of<LoginBloc>(context).add(SaveTokenEvent(
                          _phoneController.text.trim(),
                          _otpController.text.trim()))
                      : log(4),
                  decoration: InputDecoration(
                    labelText: 'OTP code:',
                    labelStyle: const TextStyle(color: Color(0xFF9E98A9)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: _errorMessage != null
                                ? Colors.red
                                : const Color(0xFF9E98A9))),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.white),
                    ),
                  ),
                ),
                if (_errorMessage != null)
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Wrong OTP code',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF121025),
                      side: const BorderSide(
                          width: 1, // the thickness
                          color: Color(0xFF9E98A9) // the color of the border
                          )),
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : Text(
                          'Register',
                          style: GoogleFonts.openSans(
                            textStyle: const TextStyle(),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    setState(() {
      _errorMessage = null;
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyHomePage()),
      // (route) => true,
    );
    BlocProvider.of<DataBloc>(context).add(GetMoviesEvent());
  }
}
