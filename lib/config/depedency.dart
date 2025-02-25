import 'package:dio/dio.dart';
import 'package:flulu/data/repositories/product/product_local_repository.dart';
import 'package:flulu/data/repositories/product/product_local_repository_interface.dart';
import 'package:flulu/data/repositories/product/product_repository_interface.dart';
import 'package:flulu/data/repositories/product/produt_repository.dart';
import 'package:flulu/data/services/product/product_service.dart';
import 'package:flulu/data/services/product/product_service_interface.dart';
import 'package:flulu/features/product/product_details/product_detail_controller.dart';
import 'package:flulu/features/product/product_favorites/product_favorite_controller.dart';
import 'package:flulu/features/product/product_list/product_list_controller.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupInjection() {
  getIt.registerLazySingleton(() => Dio());

  getIt.registerLazySingleton<IProductRepository>(
      () => ProductRepository(dio: getIt()));

  getIt.registerLazySingleton<IProductLocalRepository>(
      () => ProductLocalRepository());

  getIt.registerLazySingleton<IProductService>(
      () => ProductService(localRepository: getIt<IProductLocalRepository>()));

  getIt.registerLazySingleton<ProductListController>(
    () => ProductListController(
      repository: getIt<IProductRepository>(),
      favoritesService: getIt<IProductService>(),
    ),
  );

  getIt.registerLazySingleton<ProductFavoritesController>(
    () => ProductFavoritesController(
      favoritesService: getIt<IProductService>(),
    ),
  );

  getIt.registerLazySingleton<ProductDetailsController>(
    () => ProductDetailsController(
      favoritesService: getIt<IProductService>(),
    ),
  );
}
