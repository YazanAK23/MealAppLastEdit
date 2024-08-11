import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/providers/favorites_provider.dart';
import 'package:meal_app/providers/filters_provider.dart';
import 'package:meal_app/providers/meals_providers.dart';
import 'package:meal_app/providers/navbar_provider.dart';
import 'package:meal_app/screens/categories_screen.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/meals_screen.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:meal_app/models/meal.dart';

class TabsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPageIndex = ref.watch(navBarProvider);
    final filters = ref.watch(filtersProvider);
    final meals = ref.watch(mealsProvider);

    final availableMeals = meals.where((meal) {
      if (filters[Filter.glutenFree]! && !meal.isGlutenFree) return false;
      if (filters[Filter.lactoseFree]! && !meal.isLactoseFree) return false;
      if (filters[Filter.vegan]! && !meal.isVegan) return false;
      if (filters[Filter.vegetarian]! && !meal.isVegetarian) return false;
      return true;
    }).toList();

    void setScreen(String identifier) {
      if (identifier == 'Filters') {
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => FiltersScreen(
              currentFilters: filters,
              saveFilters: (newFilters) {
                ref.read(filtersProvider.notifier).setFilters(newFilters);
              },
            ),
          ),
        );
      } else {
        Navigator.of(context).pop();
      }
    }

    Widget activePage = CategoriesScreen(availableMeals: availableMeals);
    var activePageTitle = 'Categories';

    if (selectedPageIndex == 1) {
      final List<Meal> favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(meals: favoriteMeals);
      activePageTitle = 'Favorite';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      body: activePage,
      drawer: MainDrawer(onSelectScreen: setScreen),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => ref.read(navBarProvider.notifier).setIndex(index),
        currentIndex: selectedPageIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorite'),
        ],
      ),
    );
  }
}
