import 'package:store_app/helper/api.dart';
import 'package:store_app/models/product_model.dart';

class GetProductByIdService {
  final String _baseUrl = 'https://api.escuelajs.co/api/v1';

  Future<ProductModel?> getProductById(int id) async {
    final data = await Api.getData(endpoint: '$_baseUrl/products/$id');

    if (data != null) {
      print('Product data received: $data');
      return ProductModel.fromJson(data);
    } else {
      print('No product data found for id $id');
      return null;
    }
  }
}
