import 'package:flutter/material.dart';
import 'package:food_app/objects/food_item.dart';
import 'package:food_app/objects/index.dart';
import 'package:food_app/pages/info_page.dart';
import 'search_page.dart';
import 'compare_page.dart';

class GeneralPage extends StatefulWidget {
  const GeneralPage({Key? key}) : super(key: key);

  @override
  _GeneralPageScreenState createState() => _GeneralPageScreenState();
}

class _GeneralPageScreenState extends State<GeneralPage> {
  int _selectedIndex = 1;
  List<FoodItem> compareList = [];

  late SearchPage _searchPage;
  final InfoPage _screenTwo = InfoPage();
  late ComparePage _comparePage;

  late final List<Widget> _screens;

  final GlobalKey<ComparePageState> comparePageKey = GlobalKey<ComparePageState>();
  final GlobalKey<SearchPageState> searchPageKey = GlobalKey<SearchPageState>();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if(index==2){
        callRefreshFromCompare();
      }
      if(index==1){
        print("1");
        callRefreshFromSearch();
      }
    });
  }

  void callRefreshFromCompare() {
    comparePageKey.currentState?.resfresh();
  }

  void callRefreshFromSearch() {
     searchPageKey.currentState?.resfresh();
  }

  @override
  void initState() {
    super.initState();
    _comparePage =       ComparePage(key: comparePageKey, compareList: compareList);
    _searchPage = SearchPage(compareList: compareList,);
    _screens = <Widget>[
      _screenTwo,
      _searchPage,
      _comparePage,
    ];
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
        selectedItemColor: Color.fromARGB(255, 0, 113, 91),
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
