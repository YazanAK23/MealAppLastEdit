import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/meal_detail_screen.dart';
import 'package:meal_app/widgets/meal_item.dart';
import 'package:meal_app/providers/favorites_provider.dart';

class MealsScreen extends ConsumerWidget {
  final String? title;
  final List<Meal> meals;

  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return title == null
        ? content(context, ref)
        : Scaffold(
            appBar: AppBar(
              title: Text(title!),
            ),
            body: content(context, ref),
          );
  }

  Widget content(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: meals.length,
      itemBuilder: (ctx, index) {
        return MealItem(
          meal: meals[index],
          onSelectedMeal: (Meal meal) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => MealDetailScreen(
                  meal: meal,
                  onToggleFavorite: (meal) {
                    ref.read(favoriteMealsProvider.notifier).toggleFavorite(meal);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
