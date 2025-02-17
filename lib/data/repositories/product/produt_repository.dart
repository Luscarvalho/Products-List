import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flulu/data/repositories/product/product_repository_interface.dart';
import '../../../domain/models/product/product_model.dart';

class ProductRepository implements IProductRepository {
  final Dio _dio;
  static const _baseUrl = 'https://fakestoreapi.com/products';

  ProductRepository({required Dio dio}) : _dio = dio;

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _dio.get(_baseUrl);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data
            .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Status code: ${response.statusCode}');
    } on DioException catch (e) {
      log('DioError during getProducts: ${e.message}');
      throw Exception('Failed to load products: ${e.message}');
    } catch (e) {
      log('Unexpected error during getProducts: $e');
      throw Exception('Unexpected error while loading products');
    }
  }
}
