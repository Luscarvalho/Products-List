import 'package:flulu/data/repositories/product/product_local_repository_interface.dart';
import 'package:flulu/data/repositories/product/product_repository_interface.dart';
import 'package:flulu/data/services/product/product_favorites_service.dart';
import 'package:flutter/material.dart';
import '../../../domain/models/product/product_model.dart';

class ProductListController extends ChangeNotifier {
  final IProductRepository _repository;
  final IProductLocalRepository _localRepository;
  final FavoritesService _favoritesService;
  List<ProductModel> _allProducts = [];
  List<ProductModel> _filteredProducts = [];
  final Set<ProductModel> _favorites = {};
  bool isLoading = false;
  String? error;
  String _searchQuery = '';

  ProductListController({
    required IProductRepository repository,
    required IProductLocalRepository localRepository,
    required FavoritesService favoritesService,
  })  : _repository = repository,
        _localRepository = localRepository,
        _favoritesService = favoritesService;

  List<ProductModel> get products => _filteredProducts;
  // List<ProductModel> get favorites => _favorites.toList();
  List<ProductModel> get favorites => _favoritesService.favorites;

  Future<void> loadProducts() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      _allProducts = await _repository.getProducts();
      _filterProducts();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void searchProducts(String query) {
    _searchQuery = query.toLowerCase();
    _filterProducts();
    notifyListeners();
  }

  void _filterProducts() {
    if (_searchQuery.isEmpty) {
      _filteredProducts = _allProducts;
    } else {
      _filteredProducts = _allProducts
          .where((product) =>
              product.title.toLowerCase().contains(_searchQuery) ||
              product.description.toLowerCase().contains(_searchQuery))
          .toList();
    }
  }

  // bool isFavorite(int id) => _favorites.any((product) => product.id == id);

  // Future<void> loadFavorites() async {
  //   final favoritesList = await _localRepository.getFavorites();
  //   _favorites.clear();
  //   _favorites.addAll(favoritesList);
  //   notifyListeners();
  // }

  // void toggleFavorite(ProductModel product) {
  //   if (isFavorite(product.id)) {
  //     _favorites.removeWhere((p) => p.id == product.id);
  //   } else {
  //     _favorites.add(product);
  //   }
  //   _localRepository.saveFavorites(_favorites.toList());
  //   notifyListeners();
  // }

  bool isFavorite(int id) => _favoritesService.isFavorite(id);

  Future<void> loadFavorites() async {
    await _favoritesService.loadFavorites();
    notifyListeners();
  }

  Future<void> toggleFavorite(ProductModel product) async {
    await _favoritesService.toggleFavorite(product);
    notifyListeners();
  }
}
