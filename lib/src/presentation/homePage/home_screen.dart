import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cinema_application/src/data/bloc/data_bloc.dart';
import 'package:flutter_cinema_application/src/data/bloc/data_event.dart';
import 'package:flutter_cinema_application/src/data/bloc/data_state.dart';
import 'package:flutter_cinema_application/src/presentation/drawerPages/profile_page.dart';
import 'package:flutter_cinema_application/src/presentation/filmPage/film_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DataBloc>(context).add(GetMoviesEvent());
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xFF9E98A9)),
        title: Text(
          "Now",
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
      drawer: Drawer(
        backgroundColor: const Color(0xFF121025),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF121025),
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFF9E98A9),
                    width: 1.0,
                  ),
                ),
              ),
              accountName: Text(
                "Danyil Zborovets",
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF9E98A9),
                  ),
                ),
              ),
              accountEmail: Text(
                "Cryptodanil@gmail.com",
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF9E98A9),
                  ),
                ),
              ),
              currentAccountPicture: const FlutterLogo(),
            ),
            ListTile(
              title: Text(
                'Profile',
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(color: Color(0xFF9E98A9)),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
            ListTile(
              enabled: false,
              title: Text(
                'Favorite films',
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(color: Color(0xFF9E98A9)),
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              enabled: false,
              title: Text(
                'Theme',
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(color: Color(0xFF9E98A9)),
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: BlocBuilder<DataBloc, DataState>(
        builder: (context, state) {
          if (state is MoviesLoadedState) {
            return ListView.builder(
              itemCount: BlocProvider.of<DataBloc>(context).moviesData.length,
              itemBuilder: (context, index) {
                final movie =
                    BlocProvider.of<DataBloc>(context).moviesData[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FilmPage(
                                name: movie['name'],
                                movieId: movie['id'],
                                country: movie['country'],
                                movieImage: movie['image'],
                                rating: movie['rating'],
                                plot: movie['plot'],
                                age: movie['age'],
                                duration: movie['duration'],
                                screenwriter: movie['screenwriter'],
                                starring: movie['starring'],
                                studio: movie['studio'],
                                year: movie['year'],
                              )),
                    );
                  },
                  child: Card(
                    color: const Color(0xFF121025),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            width: 400,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: const Color(0xFF9E98A9)),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    movie['image'],
                                  ),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          SizedBox(
                            width: 400,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        movie['name'],
                                        style: GoogleFonts.openSans(
                                          textStyle: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF9E98A9),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        movie['year'].toString(),
                                        style: GoogleFonts.openSans(
                                          textStyle: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF9E98A9),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Icon(
                                    MdiIcons.dotsVertical,
                                    size: 20,
                                    color: Color(0xFF9E98A9),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
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
