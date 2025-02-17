abstract final class Routes {
  static const home = '/';
  static const favorites = '/$favoritesRelative';
  static const favoritesRelative = 'favorites';
  static const productDetail = '/$productDetailRelative';
  static const productDetailRelative = 'product';

  static String productWithId(int id) => '$productDetail/$id';
}
