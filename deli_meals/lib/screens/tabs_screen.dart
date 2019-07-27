import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './categories_screen.dart';
import './favorites_screen.dart';
import '../widgets/main_drawer.dart';
import '../models/meal.dart';
import '../screens/category_meals_screen.dart';
import '../screens/meal_detail_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  final List<Meal> availableMeals;
  final Function toggleFavorite;
  final Function isMealFavorite;

  final Map<String, Widget Function(BuildContext)> routes;

  TabsScreen(
    this.favoriteMeals,
    this.availableMeals,
    this.toggleFavorite,
    this.isMealFavorite,
    this.routes,
  );

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  Widget _buildCupertinoAppBar() {
    return CupertinoNavigationBar(
      middle: Text(_pages[_selectedPageIndex]['title']),
    );
  }

  Widget _buildAndroidAppBar() {
    return AppBar(
      title: Text(_pages[_selectedPageIndex]['title']),
    );
  }

  Widget _buildAndroidPage() {
    return Scaffold(
      appBar: _buildAndroidAppBar(),
      drawer: Drawer(
        child: MainDrawer(),
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        // type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            // backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
            // backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            title: Text('Favorites'),
          ),
        ],
      ),
    );
  }

  Widget _buildCupertinoPage() {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        activeColor: Colors.blue[900],
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Favorites'),
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedPageIndex = index;
          });
        },
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          routes: {
            ...widget.routes,
          },
          builder: (BuildContext context) {
            return CupertinoPageScaffold(
              navigationBar: _buildCupertinoAppBar(),
              child: SafeArea(
                child: Center(
                  child: _pages[_selectedPageIndex]['page'],
                ), //_pages[_selectedPageIndex]['page'],
              ),
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    _pages = [
      {
        'title': 'Categories',
        'page': CategoriesScreen(),
      },
      {
        'title': 'Favorite',
        'page': FavoriteScreen(widget.favoriteMeals),
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return !Platform.isIOS ? _buildCupertinoPage() : _buildAndroidPage();
  }
}
