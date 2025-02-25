import 'package:flulu/data/services/product/product_favorites_service.dart';
import 'package:flutter/material.dart';
import '../../../domain/models/product/product_model.dart';

class ProductDetailsController {
  final FavoritesService _favoritesService;
  final ProductModel product;

  ProductDetailsController({
    required FavoritesService favoritesService,
    required this.product,
  }) : _favoritesService = favoritesService;

  ValueNotifier<List<ProductModel>> get favoritesNotifier =>
      _favoritesService.favoritesNotifier;

  bool isFavorite() => _favoritesService.isFavorite(product.id);

  Future<void> toggleFavorite() async {
    await _favoritesService.toggleFavorite(product);
  }
}
