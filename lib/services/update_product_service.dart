import 'package:store_app/helper/api.dart';
import 'package:store_app/models/product_model.dart';

class UpdateProductService {
  final String _baseUrl = 'https://api.escuelajs.co/api/v1';

  Future<ProductModel?> updateProduct(int id, ProductModel product) async {
    final data = await Api.putData(
        endpoint: '$_baseUrl/products/$id', data: product.toJson());

    if (data != null) {
      print('Product updated successfully: $data');
      return ProductModel.fromJson(data);
    } else {
      print('Failed to update product');
      return null;
    }
  }
}
