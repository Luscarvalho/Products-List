import 'package:flulu/data/repositories/product/product_local_repository_interface.dart';
import '../../../domain/models/product/product_model.dart';

class FavoritesService {
  final IProductLocalRepository _localRepository;
  final Set<ProductModel> _favorites = {};

  FavoritesService({
    required IProductLocalRepository localRepository,
  }) : _localRepository = localRepository;

  List<ProductModel> get favorites => _favorites.toList();

  bool isFavorite(int id) => _favorites.any((product) => product.id == id);

  Future<void> loadFavorites() async {
    final favoritesList = await _localRepository.getFavorites();
    _favorites.clear();
    _favorites.addAll(favoritesList);
  }

  Future<void> toggleFavorite(ProductModel product) async {
    if (isFavorite(product.id)) {
      _favorites.removeWhere((p) => p.id == product.id);
    } else {
      _favorites.add(product);
    }
    await _localRepository.saveFavorites(_favorites.toList());
  }
}
