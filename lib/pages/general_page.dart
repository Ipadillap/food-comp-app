import 'package:flutter/material.dart';
import 'package:food_app/components/food_item.dart';
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
  int quantityToCompare = 0;

  late SearchPage _searchPage;
  final InfoPage _screenTwo = InfoPage();
  late ComparePage _comparePage;

  late final List<Widget> _screens;

  final GlobalKey<ComparePageState> comparePageKey =
      GlobalKey<ComparePageState>();
  final GlobalKey<SearchPageState> searchPageKey = GlobalKey<SearchPageState>();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 2) {
        callRefreshFromCompare();
      }
      if (index == 1) {
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

  int getQuantity() {
    return quantityToCompare;
  }

  void updateQuantity(int newQuantity) {
    setState(() {
      quantityToCompare = newQuantity;
    });
  }

  @override
  void initState() {
    super.initState();
    _comparePage = ComparePage(key: comparePageKey, compareList: compareList, quantityToCompare: getQuantity);
    _searchPage = SearchPage(key: searchPageKey, compareList: compareList, quantityToCompare: getQuantity, onQuantityChanged: updateQuantity,);
    _screens = <Widget>[
      _screenTwo,
      _searchPage,
      _comparePage,
    ];
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
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'Foods',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                 Icon(Icons.compare_arrows),
                Positioned(
                  right: -15,
                  top: -6,
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 239, 79, 79),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      quantityToCompare.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            label: 'Compare',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 0, 113, 91),
        onTap: _onItemTapped,
        selectedIconTheme: const IconThemeData(
          size: 24,
        ),
        unselectedIconTheme: const IconThemeData(
          size: 24,
        ),
      ),
    );
  }
}
