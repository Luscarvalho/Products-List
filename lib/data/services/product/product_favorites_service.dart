import 'package:flulu/data/repositories/product/product_local_repository_interface.dart';
import 'package:flutter/material.dart';
import '../../../domain/models/product/product_model.dart';

class FavoritesService {
  final IProductLocalRepository _localRepository;
  final ValueNotifier<List<ProductModel>> favoritesNotifier =
      ValueNotifier<List<ProductModel>>([]);

  FavoritesService({
    required IProductLocalRepository localRepository,
  }) : _localRepository = localRepository;

  List<ProductModel> get favorites => favoritesNotifier.value;

  bool isFavorite(int id) =>
      favoritesNotifier.value.any((product) => product.id == id);

  Future<void> loadFavorites() async {
    final favoritesList = await _localRepository.getFavorites();
    favoritesNotifier.value = favoritesList.toList();
  }

  Future<void> toggleFavorite(ProductModel product) async {
    final currentFavorites = favoritesNotifier.value.toList();

    if (isFavorite(product.id)) {
      currentFavorites.removeWhere((p) => p.id == product.id);
    } else {
      currentFavorites.add(product);
    }

    await _localRepository.saveFavorites(currentFavorites);

    favoritesNotifier.value = currentFavorites;
  }
}
