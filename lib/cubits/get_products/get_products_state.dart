part of 'get_products_cubit.dart';

@immutable
sealed class GetProductCubitState {}

final class GetProductInitialState extends GetProductCubitState {}

final class GetProductLoadingState extends GetProductCubitState {}

final class GetProductSuccessState extends GetProductCubitState {
  final List<ProductModel> productList;

  GetProductSuccessState({required this.productList});
}

final class GetProductErrorState extends GetProductCubitState {
  final String? message;

  GetProductErrorState({this.message});
}

/*class ProductLoadedState extends GetProductCubitState {
  final ProductModel product;
  ProductLoadedState(this.product);
}*/
