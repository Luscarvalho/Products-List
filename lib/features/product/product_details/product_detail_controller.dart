import 'package:flulu/data/services/product/product_favorites_service.dart';
import 'package:flutter/material.dart';
import '../../../domain/models/product/product_model.dart';

class ProductDetailsController {
  final FavoritesService _favoritesService;

  ProductDetailsController({
    required FavoritesService favoritesService,
  }) : _favoritesService = favoritesService;

  ValueNotifier<List<ProductModel>> get favoritesNotifier =>
      _favoritesService.favoritesNotifier;

  bool isFavorite(int id) => _favoritesService.isFavorite(id);

  Future<void> toggleFavorite(ProductModel product) async {
    await _favoritesService.toggleFavorite(product);
  }
}
