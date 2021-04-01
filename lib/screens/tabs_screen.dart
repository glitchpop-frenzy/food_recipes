import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../widgets/main_drawer.dart';
import './favourites_screen.dart';
import '../models/meal.dart';
import './categories_screen.dart';

class TabsScreen extends StatefulWidget {
  List<Meal> favoriteMeal;
  TabsScreen(this.favoriteMeal);
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, dynamic>> _pages;

  int _selectedPage = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  void initState() {
    _pages = [
      {'page': CategoriesScreen(), 'title': 'Categories'},
      {'page': FavouritesScreen(widget.favoriteMeal), 'title': 'Your Favorites'}
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPage]['title']),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPage]['page'],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Colors.limeAccent,
          unselectedItemColor: Colors.black,
          selectedItemColor: Theme.of(context).accentColor,
          currentIndex: _selectedPage,
          selectedFontSize: 18,
          unselectedFontSize: 15,
          type: BottomNavigationBarType.shifting,
          selectedLabelStyle: TextStyle(
              fontFamily: 'RobotoCondensed', fontWeight: FontWeight.bold),
          items: [
            BottomNavigationBarItem(
              backgroundColor: Colors.red,
              icon: Icon(Icons.category),
              title: Text('Categories'),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.red,
              icon: Icon(Icons.star),
              title: Text('Favourites'),
            )
          ]),
    );
  }
}
