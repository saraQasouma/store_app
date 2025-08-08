import 'package:store_app/helper/api.dart';
import 'package:store_app/models/product_model.dart';

class CreateProductService {
  final String _baseUrl = 'https://api.escuelajs.co/api/v1';

  Future<ProductModel?> createProduct(ProductModel product) async {
    final data = await Api.postData(
      endpoint: '$_baseUrl/products/',
      data: {
        "title": product.title,
        "price": product.price,
        "description": product.description,
        "categoryId": product.category.id,
        "images": product.images,
      },
    );
    if (data != null) {
      print('Response data: $data');
      return ProductModel.fromJson(data);
    } else {
      print('No data returned from API');
      return null;
    }
  }
}
