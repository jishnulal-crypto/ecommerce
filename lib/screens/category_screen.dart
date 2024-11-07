import 'dart:math';

import 'package:ecommerce_with_flutter_firebase_and_stripe/main.dart';
import 'package:ecommerce_with_flutter_firebase_and_stripe/models/category.dart';
import 'package:ecommerce_with_flutter_firebase_and_stripe/utils/prefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Category> _categories = [];
  List<int> _extends = [];

  final rnd = Random();

  @override
  void initState() {
    _loadCategory();
    super.initState();
  }

  void _loadCategory() async {
    final categories = await categoryRepository.fetchCategories();

    final extents = List<int>.generate(
      categories.length,
      (index) => rnd.nextInt(3) + 2,
    );

    setState(() {
      _categories = categories;
      _extends = extents;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        categoryRepository.createCategories();
      }),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Categories'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              // Log out the user
              await FirebaseAuth.instance.signOut();
              PreferencesHelper.clearLoginState();
              Navigator.pushReplacementNamed(context, '/splash');
            },
          ),
        ],
      ),
      body: MasonryGridView.count(
        padding: const EdgeInsets.only(
          top: 120,
          left: 4.0,
          right: 4.0,
        ),
        crossAxisCount: 3,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final height = _extends[index] * 100;
          final category = _categories[index];
          return InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/catalog',
                arguments: category.name,
              );
            },
            child: Hero(
              tag: category.id,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(category.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                height: height.toDouble(),
              ),
            ),
          );
        },
      ),
    );
  }
}
