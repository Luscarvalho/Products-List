import 'package:flulu/data/services/product/product_favorites_service.dart';
import 'package:flutter/material.dart';
import '../../../domain/models/product/product_model.dart';

class ProductFavoritesController {
  final FavoritesService _favoritesService;

  ProductFavoritesController({
    required FavoritesService favoritesService,
  }) : _favoritesService = favoritesService;

  ValueNotifier<List<ProductModel>> get favoritesNotifier =>
      _favoritesService.favoritesNotifier;

  List<ProductModel> get favorites => _favoritesService.favorites;

  bool isFavorite(int id) => _favoritesService.isFavorite(id);

  Future<void> toggleFavorite(ProductModel product) async {
    await _favoritesService.toggleFavorite(product);
  }
}
