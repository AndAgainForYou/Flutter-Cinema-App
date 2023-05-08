import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cinema_application/src/data/bloc/data_bloc.dart';
import 'package:flutter_cinema_application/src/data/bloc/data_event.dart';
import 'package:flutter_cinema_application/src/data/bloc/data_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TicketsPage extends StatefulWidget {
  const TicketsPage({
    Key? key,
  }) : super(key: key);

  @override
  TicketsPageState createState() => TicketsPageState();
}

class TicketsPageState extends State<TicketsPage> {
  late DataBloc dataBloc;

  @override
  void initState() {
    super.initState();
    dataBloc = BlocProvider.of<DataBloc>(context);
    dataBloc.add(GetUserTicketsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF121025),
        title: Text(
          'My Tickets',
          style: GoogleFonts.openSans(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Color(0xFF9E98A9),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<DataBloc, DataState>(
        builder: (context, state) {
          if (state is UserDataTicketsState) {
            final tickets = state.userTicketsData['data'];
            return ListView.builder(
              itemCount: tickets.length,
              itemBuilder: (context, index) {
                final tickets = state.userTicketsData['data'][index];
                // final ticket = ticketsData[index];
                // print(tickets[index]['id']);
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF9E98A9)),
                    ),
                    height: 380,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 18.0,
                          ),
                          child: Text(
                            '${tickets['name']}',
                            style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Column(
                            children: [
                              Text(
                                'Date:',
                                style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF9E98A9),
                                  ),
                                ),
                              ),
                              Text(
                                DateFormat('HH:mm').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        tickets['date'] * 1000)),
                                style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/2/2f/Rickrolling_QR_code.png',
                            width: 190,
                            height: 190,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
