import 'package:flutter/material.dart';
import 'map_screen.dart';
import 'ticket_screen.dart';
import 'vehicle_screen.dart';
import 'more_screen.dart'; // Importera MoreScreen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const MapScreen(), // Karta i fliken "Hitta"
    const TicketScreen(), // Biljetter-fliken
    const VehicleScreen(), // Fordon-fliken
    const MoreScreen(), // Mer-fliken
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.green, // Gör navbaren grön
        selectedItemColor: const Color.fromARGB(255, 0, 192, 26), // Färg för vald ikon och text
        unselectedItemColor: Colors.black54, // Färg för icke-valda ikoner och text
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Hitta',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rocket),
            label: 'Biljetter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Fordon',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'Mer',
          ),
        ],
      ),
    );
  }
}
