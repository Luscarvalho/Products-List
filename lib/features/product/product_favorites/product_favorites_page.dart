import 'package:flulu/domain/models/product/product_model.dart';
import 'package:flulu/features/product/product_favorites/product_favorite_controller.dart';
import 'package:flulu/features/product/widgets/product_empty.dart';
import 'package:flulu/features/product/widgets/product_list.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ProductFavoritesPage extends StatelessWidget {
  const ProductFavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = GetIt.I<ProductFavoritesController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: ValueListenableBuilder<List<ProductModel>>(
        valueListenable: controller.favoritesNotifier,
        builder: (context, favorites, _) {
          final favorites = controller.favorites;

          if (favorites.isEmpty) {
            return const ProductEmpty();
          }

          return ProductList(
            products: favorites,
            onToggleFavorite: controller.toggleFavorite,
            isFavorite: controller.isFavorite,
          );
        },
      ),
    );
  }
}
