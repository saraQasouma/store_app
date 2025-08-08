import 'package:store_app/helper/api.dart';
import 'package:store_app/models/product_model.dart';

class GetProductsService {
  final String _baseUrl = 'https://api.escuelajs.co/api/v1';

  Future<List<ProductModel>> getProducts() async {
    final data = await Api.getData(endpoint: '$_baseUrl/products');
    List<ProductModel> productList = [];
    if (data != null && data is List) {
      for (var product in data) {
        productList.add(ProductModel.fromJson(product));
      }

      return productList;
    } else {
      print('Unexpected data format or null');
      return [];
    }
  }
}
