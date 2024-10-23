import 'package:flutter/material.dart';
import 'package:food_app/objects/index.dart';
import 'package:food_app/pages/info_page.dart';
import 'prueba.dart';

class GeneralPageScreen extends StatefulWidget {
  const GeneralPageScreen({Key? key}) : super(key: key);

  @override
  _GeneralPageScreenState createState() => _GeneralPageScreenState();
}

class _GeneralPageScreenState extends State<GeneralPageScreen> {
  int _selectedIndex = 1;

  final SearchPage _searchPage = SearchPage();
  final InfoPage _screenTwo = InfoPage();
  final ScreenThree _screenThree = const ScreenThree();

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = <Widget>[
      _screenTwo,
      _searchPage,
      _screenThree,
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double ancho = MediaQuery.of(context).size.width.toDouble();
    double largo = MediaQuery.of(context).size.height.toDouble();

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
        selectedItemColor: const Color.fromARGB(255, 38, 51, 66),
        onTap: _onItemTapped,
        selectedIconTheme: const IconThemeData(
          size: 35, // Tamaño del icono seleccionado
        ),
        unselectedIconTheme: const IconThemeData(
          size: 25, // Tamaño de los iconos no seleccionados
        ),
      ),
    );
  }
}


class ScreenThree extends StatelessWidget {
  const ScreenThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Compare Screen', style: TextStyle(fontSize: 24)),
    );
  }
}
