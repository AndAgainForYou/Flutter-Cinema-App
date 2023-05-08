import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cinema_application/src/presentation/filmPage/roomScreen/room_screen.dart';
import 'package:flutter_cinema_application/src/presentation/filmPage/sessionsScreen/bloc/sessions_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SessionsPage extends StatefulWidget {
  final String name;
  final String movieImage;
  final int movieId;

  const SessionsPage(
      {Key? key,
      required this.name,
      required this.movieId,
      required this.movieImage})
      : super(key: key);

  @override
  SessionsPageState createState() => SessionsPageState();
}

class SessionsPageState extends State<SessionsPage> {
  late SessionsBloc sessionsBloc;

  @override
  void initState() {
    super.initState();
  }

  void dates(int date) => {
        DateFormat('yyyy-MM-dd HH:mm')
            .format(DateTime.fromMillisecondsSinceEpoch(date * 1000))
      };

  @override
  Widget build(BuildContext context) {
    sessionsBloc = BlocProvider.of<SessionsBloc>(context);
    sessionsBloc.add(GetSessionsEvent(widget.movieId));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF121025),
        iconTheme: const IconThemeData(color: Color(0xFF9E98A9)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Sessions",
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
        child: Stack(children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 250,
                  width: 400,
                  decoration: BoxDecoration(
                    border:
                        Border.all(width: 1, color: const Color(0xFF9E98A9)),
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.movieImage,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 12.0, left: 12.0, right: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.name,
                          style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Text(
                          'st S-Bandera, 2a',
                          style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                                color: Color(0xFF9E98A9),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, top: 2.0, bottom: 10.0),
                    child: Text(
                      'Sessions:',
                      style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                            color: Color(0xFF9E98A9),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<SessionsBloc, SessionsState>(
                      builder: (context, state) {
                    if (state is SessionsDataState) {
                      return ListView.builder(
                        itemCount: state.sessions['data'].length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final session = state.sessions['data'][index];
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, left: 12.0),
                                child: SizedBox(
                                  width: 130,
                                  height: 70,
                                  child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            width: 1.0,
                                            color: Color(0xFF9E98A9)),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => RoomPage(
                                                    sessionId: session['id'],
                                                    sessionDate: DateFormat(
                                                            'HH:mm')
                                                        .format(DateTime
                                                            .fromMillisecondsSinceEpoch(
                                                                session['date'] *
                                                                    1000)),
                                                    sessionType:
                                                        session['type'],
                                                  )),
                                        );
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            DateFormat('HH:mm').format(DateTime
                                                .fromMillisecondsSinceEpoch(
                                                    session['date'] * 1000)),
                                            style: GoogleFonts.openSans(
                                              textStyle: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Text(
                                            session['type'],
                                            style: GoogleFonts.openSans(
                                              textStyle: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      return const Text('no data');
                    }
                  }),
                ),
                const Divider(
                  color: Color(0xFF9E98A9),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
