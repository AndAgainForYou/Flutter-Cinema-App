import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cinema_application/main.dart';
import 'package:flutter_cinema_application/src/presentation/filmPage/paymentScreen/bloc/payment_bloc.dart';
import 'package:flutter_cinema_application/src/presentation/filmPage/paymentScreen/features/card_date_formatter.dart';
import 'package:flutter_cinema_application/src/presentation/filmPage/paymentScreen/features/card_number_formatter.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentPage extends StatefulWidget {
  final int sessionId;
  final List<int> seats;

  const PaymentPage({super.key, required this.sessionId, required this.seats});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late PaymentBloc paymentBloc;

  final _emailController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expirationDateController = TextEditingController();
  final _cvvController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  bool? _errorMessage;

  @override
  Widget build(BuildContext context) {
    paymentBloc = BlocProvider.of<PaymentBloc>(context);
    paymentBloc.add(GetBookTicketEvent(widget.sessionId, widget.seats));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF121025),
        iconTheme: const IconThemeData(color: Color(0xFF9E98A9)),
        title: Text(
          'Payment data',
          style: GoogleFonts.openSans(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Color(0xFF9E98A9),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SizedBox(
              width: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      'Credit Card Details',
                      style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )),
                  TextFormField(
                    controller: _cardNumberController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CreditCardNumberFormater(),
                      LengthLimitingTextInputFormatter(19)
                    ],
                    decoration: InputDecoration(
                      labelText: 'Card number',
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
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Email',
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
                  SizedBox(
                    width: 100,
                    child: TextFormField(
                      controller: _expirationDateController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                        CardMonthInputFormatter(),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Expiration date',
                        labelStyle: TextStyle(color: Color(0xFF9E98A9)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Color(0xFF9E98A9))),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 100,
                    child: TextFormField(
                      controller: _cvvController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Cvv',
                        labelStyle: TextStyle(color: Color(0xFF9E98A9)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Color(0xFF9E98A9))),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF121025),
                        side: const BorderSide(
                            width: 1, // the thickness
                            color: Color(0xFF9E98A9) // the color of the border
                            )),
                    child: Text(
                      'Make payment',
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
      ),
    );
  }

  void _submit() async {
    final email = _emailController.text.trim();
    final cardNumber = _cardNumberController.text.trim().replaceAll(' ', '');
    final expirationDate = _expirationDateController.text.trim();
    final cvv = _cvvController.text.trim();


    if (cardNumber == '0000000000000000') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid credit card number'),
        ),
      );
      setState(() {
        _errorMessage = true;
      });
    } else {
      paymentBloc.add(GetBuyTicketEvent(widget.sessionId, widget.seats, email,
          cardNumber, expirationDate, cvv));

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),
        (route) => false,
      );
    }
  }
}
