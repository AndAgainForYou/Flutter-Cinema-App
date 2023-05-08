import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const MyBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(width: 1, color: Color(0xFFA5A0B0)))),
      child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.live_tv_outlined),
            label: 'Now',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airplane_ticket_outlined),
            label: 'Tickets',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        unselectedItemColor: const Color(0xFFA5A0B0),
        selectedItemColor: Colors.white,
        backgroundColor: const Color(0xFF121025),
      ),
    );
  }
}
