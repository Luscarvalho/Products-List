import 'dart:convert';
import 'package:flulu/data/repositories/product/product_local_repository_interface.dart';
import 'package:flulu/domain/models/product/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductLocalRepository implements IProductLocalRepository {
  static const String _favoritesKey = 'favorites';

  @override
  Future<List<ProductModel>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getStringList(_favoritesKey) ?? [];

    return favoritesJson.map((jsonString) {
      final map = json.decode(jsonString);
      return ProductModel.fromJson(map);
    }).toList();
  }

  @override
  Future<void> saveFavorites(List<ProductModel> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson =
        favorites.map((product) => json.encode(product.toJson())).toList();
    await prefs.setStringList(_favoritesKey, favoritesJson);
  }
}
