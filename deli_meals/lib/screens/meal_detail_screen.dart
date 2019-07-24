import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  static final routeName = '/meal-detail';
  final Function toggleFavoriteHandler;
  final Function isMealFavoriteHandler;

  MealDetailScreen(this.toggleFavoriteHandler, this.isMealFavoriteHandler);

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  Widget buildStepItem(int stepIndex, Meal selectedMeal, BuildContext context) {
    if (!Platform.isIOS) {
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        child: Row(
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                Text(
                  '${(stepIndex + 1)}',
                  style: Theme.of(context).textTheme.body1.copyWith(color: Colors.white, fontSize: 18,),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                child: Text(
                  selectedMeal.steps[stepIndex],
                  overflow: TextOverflow.clip,
                  style: Theme.of(context).textTheme.body1,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return ListTile(
        leading: CircleAvatar(
          child: Text('${(stepIndex + 1)}'),
        ),
        title: Text(selectedMeal.steps[stepIndex]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    final child = SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              selectedMeal.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          buildSectionTitle(context, 'Ingredients'),
          buildContainer(
            ListView.builder(
              itemCount: selectedMeal.ingredients.length,
              itemBuilder: (ctx, index) => Card(
                color: Theme.of(ctx).accentColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  child: Text(selectedMeal.ingredients[index]),
                ),
              ),
            ),
          ),
          buildSectionTitle(context, 'Steps'),
          buildContainer(
            ListView.builder(
              itemCount: selectedMeal.steps.length,
              itemBuilder: (ctx, index) => Column(
                children: <Widget>[
                  buildStepItem(index, selectedMeal, context),
                  Divider(),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return !Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text('${selectedMeal.title}'),
            ),
            child: SafeArea(child: child),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('${selectedMeal.title}'),
            ),
            body: child,
            floatingActionButton: FloatingActionButton(
              child: Icon(
                isMealFavoriteHandler(mealId) ? Icons.star : Icons.star_border,
              ),
              onPressed: () {
                toggleFavoriteHandler(mealId);
              },
            ),
          );
  }
}
