import 'package:store_app/models/product_model.dart';

abstract class GetProductByIdState {}

class GetProductByIdInitial extends GetProductByIdState {}

class GetProductByIdLoading extends GetProductByIdState {}

class GetProductByIdSuccess extends GetProductByIdState {
  final ProductModel product;

  GetProductByIdSuccess(this.product);
}

class GetProductByIdError extends GetProductByIdState {
  final String message;

  GetProductByIdError(this.message);
}
