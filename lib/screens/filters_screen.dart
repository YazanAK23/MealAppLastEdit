import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/providers/filters_provider.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:meal_app/screens/tabs_screen.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  final Map<Filter, bool> currentFilters;
  final Function(Map<Filter, bool>) saveFilters;

  const FiltersScreen({super.key, required this.currentFilters, required this.saveFilters});

  @override
  ConsumerState<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  late Map<Filter, bool> _filters;

  @override
  void initState() {
    super.initState();
    _filters = widget.currentFilters;
  }

  Widget _buildSwitchListTile(String title, String subtitle, Filter filter) {
    return SwitchListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: EdgeInsets.only(left: 34, right: 22),
      value: _filters[filter]!,
      onChanged: (newValue) {
        setState(() {
          _filters[filter] = newValue;
        });
      },
    );
  }

  void _saveFilters() {
    ref.read(filtersProvider.notifier).setFilters(_filters);
    widget.saveFilters(_filters);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => TabsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveFilters,
          ),
        ],
      ),
      drawer: MainDrawer(
        onSelectScreen: (identifier) {
          Navigator.of(context).pop();
          if (identifier == 'meals') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (ctx) => TabsScreen(),
              ),
            );
          }
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSwitchListTile(
              "Gluten-Free",
              "Only include gluten-free meals.",
              Filter.glutenFree,
            ),
            _buildSwitchListTile(
              "Lactose-Free",
              "Only include lactose-free meals.",
              Filter.lactoseFree,
            ),
            _buildSwitchListTile(
              "Vegan",
              "Only include vegan meals.",
              Filter.vegan,
            ),
            _buildSwitchListTile(
              "Vegetarian",
              "Only include vegetarian meals.",
              Filter.vegetarian,
            ),
          ],
        ),
      ),
    );
  }
}
