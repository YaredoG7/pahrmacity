import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:splash/screens/account_screen.dart';
import 'package:splash/screens/landing_screen.dart';
import 'package:splash/screens/module/location_screen.dart';
import 'package:splash/screens/register_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home-screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    LandingScreen(),
    //AccountScreen(),
    LocationScreen(),
    //AccountScreen(),
    CustomRegisterScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon:
                Icon(_selectedIndex == 0 ? IconlyLight.home : IconlyBold.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 1
                ? IconlyLight.discovery
                : IconlyBold.shieldDone),
            label: 'Pharmacies',
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 2 ? IconlyLight.buy : IconlyBold.buy),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                _selectedIndex == 3 ? IconlyLight.profile : IconlyBold.profile),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
