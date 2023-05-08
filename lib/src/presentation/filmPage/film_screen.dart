import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cinema_application/src/data/bloc/data_bloc.dart';
import 'package:flutter_cinema_application/src/data/bloc/data_state.dart';
import 'package:flutter_cinema_application/src/presentation/filmPage/sessionsScreen/sessions_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class FilmPage extends StatefulWidget {
  final String name;
  final String movieImage;
  final String rating;
  final String country;
  final String plot;
  final String screenwriter;
  final String starring;
  final String studio;
  final int age;
  final int duration;
  final int year;
  final int movieId;

  const FilmPage({
    Key? key,
    required this.name,
    required this.movieId,
    required this.movieImage,
    required this.rating,
    required this.country,
    required this.screenwriter,
    required this.starring,
    required this.studio,
    required this.duration,
    required this.age,
    required this.year,
    required this.plot,
  }) : super(key: key);

  @override
  FilmPageState createState() => FilmPageState();
}

class FilmPageState extends State<FilmPage> {
  late DataBloc dataBloc;

  @override
  void initState() {
    super.initState();
    dataBloc = BlocProvider.of<DataBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xFF9E98A9)),
        title: Text(
          widget.name,
          style: GoogleFonts.openSans(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Color(0xFF9E98A9),
            ),
          ),
        ),
        backgroundColor: const Color(0xFF121025),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF121025),
            side: const BorderSide(
                width: 1, // the thickness
                color: Color(0xFF9E98A9) // the color of the border
                )),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SessionsPage(
                      name: widget.name,
                      movieId: widget.movieId,
                      movieImage: widget.movieImage,
                    )),
          );
        },
        child: Text(
          'See sessions for today',
          style: GoogleFonts.openSans(
            textStyle: const TextStyle(),
          ),
        ),
      ),
      body: BlocBuilder<DataBloc, DataState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Stack(children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      height: 250,
                      width: 400,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: const Color(0xFF9E98A9)),
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
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.name,
                                        style: GoogleFonts.openSans(
                                          textStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Text(
                                        widget.country,
                                        style: GoogleFonts.openSans(
                                          textStyle: const TextStyle(
                                              color: Color(0xFF9E98A9),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Divider(
                                color: Color(0xFF9E98A9),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Plot description',
                                      style: GoogleFonts.openSans(
                                          textStyle: const TextStyle(
                                        color: Color(0xFF9E98A9),
                                      )),
                                    ),
                                    Text(
                                      widget.plot,
                                      style: GoogleFonts.openSans(
                                          textStyle: const TextStyle(
                                              color: Colors.white)),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Age category',
                                      style: GoogleFonts.openSans(
                                          textStyle: const TextStyle(
                                        color: Color(0xFF9E98A9),
                                      )),
                                    ),
                                    Text(
                                      widget.age.toString(),
                                      style: GoogleFonts.openSans(
                                          textStyle: const TextStyle(
                                              color: Colors.white)),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Screenwriters',
                                      style: GoogleFonts.openSans(
                                          textStyle: const TextStyle(
                                        color: Color(0xFF9E98A9),
                                      )),
                                    ),
                                    Text(
                                      widget.screenwriter,
                                      style: GoogleFonts.openSans(
                                          textStyle: const TextStyle(
                                              color: Colors.white)),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Duration',
                                      style: GoogleFonts.openSans(
                                          textStyle: const TextStyle(
                                        color: Color(0xFF9E98A9),
                                      )),
                                    ),
                                    Text(
                                      '${widget.duration.toString()} min',
                                      style: GoogleFonts.openSans(
                                          textStyle: const TextStyle(
                                              color: Colors.white)),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Starring',
                                      style: GoogleFonts.openSans(
                                          textStyle: const TextStyle(
                                        color: Color(0xFF9E98A9),
                                      )),
                                    ),
                                    Text(
                                      widget.starring,
                                      style: GoogleFonts.openSans(
                                          textStyle: const TextStyle(
                                              color: Colors.white)),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Year',
                                      style: GoogleFonts.openSans(
                                          textStyle: const TextStyle(
                                        color: Color(0xFF9E98A9),
                                      )),
                                    ),
                                    Text(
                                      widget.year.toString(),
                                      style: GoogleFonts.openSans(
                                          textStyle: const TextStyle(
                                              color: Colors.white)),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 12.0, bottom: 48.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Studio',
                                      style: GoogleFonts.openSans(
                                          textStyle: const TextStyle(
                                        color: Color(0xFF9E98A9),
                                      )),
                                    ),
                                    Text(
                                      widget.studio,
                                      style: GoogleFonts.openSans(
                                          textStyle: const TextStyle(
                                              color: Colors.white)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ]),
          );
        },
      ),
    );
  }
}
