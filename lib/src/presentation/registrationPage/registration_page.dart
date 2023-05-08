import 'package:flutter/material.dart';
import 'package:flutter_cinema_application/src/api/api_service.dart';
import 'package:flutter_cinema_application/src/presentation/loginPage/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpRegistrationForm extends StatefulWidget {
  const OtpRegistrationForm({Key? key}) : super(key: key);

  @override
  OtpRegistrationFormState createState() => OtpRegistrationFormState();
}

class OtpRegistrationFormState extends State<OtpRegistrationForm> {
  final _phoneController = TextEditingController();

  final bool _isLoading = false;
  int? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF121025),
        title: Text(
          'OTP Registration',
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
                  decoration: InputDecoration(
                    labelText: 'Phone number:',
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
                  // style: TextStyle(backgroundColor: Colors.pinkAccent),
                ),
                if (_errorMessage != null)
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(
                      'Wrong phone number',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () {
                          if (_phoneController.text.trim().length == 13) {
                            ApiService.registrationWithOtp(
                                _phoneController.text.trim());
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(
                                  phoneNumber: _phoneController.text.trim(),
                                ),
                              ),
                            );
                          } else {
                            // Show error message or perform another action
                            setState(() {
                              _errorMessage = 1;
                            });
                          }
                        },
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
}
