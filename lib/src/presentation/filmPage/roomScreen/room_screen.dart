import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cinema_application/src/presentation/filmPage/paymentScreen/payment_screen.dart';
import 'package:flutter_cinema_application/src/presentation/filmPage/roomScreen/bloc/room_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class RoomPage extends StatefulWidget {
  final int sessionId;
  final String sessionDate;
  final String sessionType;

  const RoomPage(
      {Key? key,
      required this.sessionId,
      required this.sessionDate,
      required this.sessionType})
      : super(key: key);

  @override
  RoomPageState createState() => RoomPageState();
}

class RoomPageState extends State<RoomPage> {
  late RoomBloc roomBloc;
  List<int> seats = [];

  @override
  void initState() {
    super.initState();
  }

  void _incrementCounter(int id) {
    setState(() => {seats.contains(id) ? seats.remove(id) : seats.add(id)});
  }

  @override
  Widget build(BuildContext context) {
    roomBloc = BlocProvider.of<RoomBloc>(context);
    roomBloc.add(GetCurrentSessionEvent(widget.sessionId));

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
          "Room",
          style: GoogleFonts.openSans(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Color(0xFF9E98A9),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
            disabledForegroundColor: const Color(0xFF9E98A9),
            backgroundColor: const Color(0xFF121025),
            side: const BorderSide(
                width: 1, // the thickness
                color: Color(0xFF9E98A9) // the color of the border
                )),
        onPressed: seats.isEmpty
            ? null
            : () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentPage(
                        seats: seats,
                        sessionId: widget.sessionId,
                      ),
                    ));
              },
        child: Text('Confirm Seats buying', style: GoogleFonts.openSans()),
      ),
      body: BlocBuilder<RoomBloc, RoomState>(
        builder: (context, state) {
          if (state is CurrentSessionDataState) {
            final session = state.currentSession;
            final rows = session['data']['room']['rows'];
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: 120,
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF9E98A9))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.sessionDate,
                            style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ),
                          Text(
                            widget.sessionType,
                            style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      )),
                  const Padding(
                    padding: EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Divider(
                      height: 20,
                      thickness: 3,
                      color: Color(0xFF9E98A9),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 220,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 18.0, right: 18.0, bottom: 55.0),
                        child: GridView.builder(
                          itemCount: rows.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 15,
                          ),
                          itemBuilder: (BuildContext context, int rowIndex) {
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: rows[rowIndex]['seats'].length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                              ),
                              itemBuilder:
                                  (BuildContext context, int seatIndex) {
                                final seat = rows[rowIndex]['seats'][seatIndex];
                                return Center(
                                  child: InkWell(
                                    onTap: () {
                                      _incrementCounter(seat['id']);
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: seat['isAvailable']
                                            ? const Color(0xFF9E98A9)
                                            : Colors.red,
                                        border: Border.all(
                                            color: seats.contains(seat['id'])
                                                ? Colors.pink
                                                : Colors.black,
                                            width: 1,
                                            style: BorderStyle.solid),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
