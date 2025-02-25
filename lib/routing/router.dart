import 'package:flulu/domain/models/product/product_model.dart';
import 'package:flulu/features/product/product_details/product_details_page.dart';
import 'package:flulu/features/product/product_favorites/product_favorites_page.dart';
import 'package:flulu/features/product/product_list/product_list_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';

GoRouter router = GoRouter(
  initialLocation: Routes.home,
  debugLogDiagnostics: true,
  observers: [
    CustomNavigatorObserver(),
  ],
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, _) {
        return const ProductListPage();
      },
      routes: [
        GoRoute(
          path: Routes.productDetailRelative,
          builder: (context, state) {
            final product = state.extra as ProductModel;
            return ProductDetailsPage(
              product: product,
            );
          },
        ),
        GoRoute(
          path: Routes.favoritesRelative,
          builder: (context, _) {
            return const ProductFavoritesPage();
          },
        ),
      ],
    ),
  ],
);

class CustomNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('Nova rota: ${route.settings.name}');
    debugPrint('Rota anterior: ${previousRoute?.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('Voltou para: ${previousRoute?.settings.name}');
    debugPrint('Saiu de: ${route.settings.name}');
  }
}
