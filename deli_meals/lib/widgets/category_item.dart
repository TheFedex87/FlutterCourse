import 'dart:io';

import 'package:flutter/material.dart';

import '../screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  CategoryItem(this.id, this.title, this.color);

  void selectCategory(BuildContext context) {
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (_) {
    //       return CategoryMealsScreen(
    //         id,
    //         title,
    //       );
    //     },
    //   ),
    // );
    Navigator.of(context).pushNamed(
      CategoryMealsScreen.routeName,
      arguments: {'id': id, 'title': title},
    );
  }

  Widget buildCupertinoCategoryItem(Function onTapHandler, Widget child) {
    return GestureDetector(
      child: child,
      onTap: onTapHandler,
    );
  }

  Widget buildAndroidCategoryItem(
      Function onTapHandler, Widget child, BuildContext context) {
    return InkWell(
      onTap: onTapHandler,
      child: child,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Container(
      padding: const EdgeInsets.all(15),
      child: Text(
        title,
        style: Theme.of(context).textTheme.title,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.7),
            color,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
    );

    return !Platform.isIOS
        ? buildCupertinoCategoryItem(() => selectCategory(context), child)
        : buildAndroidCategoryItem(
            () => selectCategory(context), child, context);
  }
}
