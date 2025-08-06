import 'package:flutter/material.dart';
import 'package:food_app/src/screens/info_page.dart';

class GeneralPage extends StatefulWidget {
  const GeneralPage({super.key});

  @override
  State<GeneralPage> createState() => _GeneralPageScreenState();
}

class _GeneralPageScreenState extends State<GeneralPage> {
  int _selectedIndex = 1;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = <Widget>[
      // Ventana de informaciones
      const InfoPage(),

      // Ventana de alimentos
      Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: const Text(
          'Foods Page',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),

      // Ventana de comparaciones
      Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: const Text(
          'Compare Page',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'Foods',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.compare_arrows),
            label: 'Compare',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 0, 113, 91),
        onTap: _onItemTapped,
        selectedIconTheme: const IconThemeData(size: 24),
        unselectedIconTheme: const IconThemeData(size: 24),
      ),
    );
  }
}