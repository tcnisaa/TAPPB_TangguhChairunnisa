import 'package:flutter/material.dart';
import '../screens/profile.dart';
import '../screens/home.dart';
import '../screens/towatch.dart';
import '../screens/upcoming.dart';// Import halaman ReviewHistory

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentIndex = 0;

  // Menambahkan ReviewHistoryPage ke dalam list
  final List<Widget> _pages = [
    const HomePage(),         
    const UpcomingPage(),   
    const ToWatchPage(),
    const ProfilePage(),   
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Now Playing',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            label: 'Upcoming',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined), // Ikon untuk Review History
            label: 'To Watch',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
