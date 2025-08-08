import 'package:store_app/helper/api.dart';

class DeleteProductService {
  final String _baseUrl = 'https://api.escuelajs.co/api/v1';

  Future<bool> deleteProduct(int id) async {
    final statusCode = await Api.deleteData(endpoint: '$_baseUrl/products/$id');
    if (statusCode == 200 || statusCode == 204) {
      print('Product deleted successfully');
      return true;
    } else {
      print('Failed to delete product');
      return false;
    }
  }
}
