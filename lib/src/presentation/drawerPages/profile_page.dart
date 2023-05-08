import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cinema_application/src/presentation/drawerPages/bloc/profile_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  late ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _profileBloc.add(GetProfileEvent());

    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Color(0xFF9E98A9)),
          backgroundColor: const Color(0xFF121025),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Profile",
            style: GoogleFonts.openSans(
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Color(0xFF9E98A9),
              ),
            ),
          ),
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is UserDataLoadedState) {
              final user = state.userData['data'];
              return Column(
                children: [
                  Center(
                      child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Profile',
                          style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF9E98A9),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            'https://st.depositphotos.com/3420137/4720/v/950/depositphotos_47209371-stock-illustration-banana-seamless-1.jpg'),
                      ),
                    ],
                  )),
                  SizedBox(
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 28.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nickname',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 8.0, left: 8.0),
                            child: Text(
                              user['name'].toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF9E98A9),
                              ),
                            ),
                          ),
                          const Divider(
                            color: Color(0xFF9E98A9),
                          ),
                          Text(
                            'Id',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 8.0, left: 8.0),
                            child: Text(
                              '${user['id']}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF9E98A9),
                              ),
                            ),
                          ),
                          const Divider(
                            color: Color(0xFF9E98A9),
                          ),
                          Text(
                            'Phone number',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 8.0, left: 8.0),
                            child: Text(
                              '${user['phoneNumber']}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF9E98A9),
                              ),
                            ),
                          ),
                          const Divider(
                            color: Color(0xFF9E98A9),
                          ),
                          Text(
                            'Created at',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 8.0, left: 8.0),
                            child: Text(
                              ' ${DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(user['createdAt'] * 1000))}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF9E98A9),
                              ),
                            ),
                          ),
                          const Divider(
                            color: Color(0xFF9E98A9),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
