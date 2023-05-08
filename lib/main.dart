import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cinema_application/src/data/bloc/data_bloc.dart';
import 'package:flutter_cinema_application/src/presentation/bottom_bar.dart';
import 'package:flutter_cinema_application/src/presentation/drawerPages/bloc/profile_bloc.dart';
import 'package:flutter_cinema_application/src/presentation/filmPage/paymentScreen/bloc/payment_bloc.dart';
import 'package:flutter_cinema_application/src/presentation/filmPage/roomScreen/bloc/room_bloc.dart';
import 'package:flutter_cinema_application/src/presentation/filmPage/sessionsScreen/bloc/sessions_bloc.dart';
import 'package:flutter_cinema_application/src/presentation/loginPage/bloc/login_bloc.dart';
import 'package:flutter_cinema_application/src/presentation/registrationPage/registration_page.dart';
import 'package:flutter_cinema_application/src/presentation/homePage/home_screen.dart';
import 'package:flutter_cinema_application/src/presentation/ticketsPage/tickets_screen.dart';
import 'package:flutter_cinema_application/src/token/token_rep.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final tokenRepository = TokenRepository(prefs);

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider.value(
        value: DataBloc(tokenRepository),
      ),
      BlocProvider.value(
        value: ProfileBloc(tokenRepository),
      ),
      BlocProvider.value(
        value: SessionsBloc(tokenRepository),
      ),
      BlocProvider.value(
        value: RoomBloc(tokenRepository),
      ),
      BlocProvider.value(
        value: PaymentBloc(tokenRepository),
      ),
      BlocProvider.value(
        value: LoginBloc(tokenRepository),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF121025),
        textTheme: ThemeData.dark().textTheme,
      ),
      home: const OtpRegistrationForm(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _buildSelectedScreen(),
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildSelectedScreen() {
    switch (_selectedIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const TicketsPage();
      default:
        return const SizedBox.shrink();
    }
  }
}
