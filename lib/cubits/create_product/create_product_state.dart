sealed class CreateProductState {}

final class CreateProductInitialState extends CreateProductState {}

final class CreateProductLoadingState extends CreateProductState {}

final class CreateProductSuccessState extends CreateProductState {
  final String message;
  CreateProductSuccessState({this.message = "Product created successfully"});
}

final class CreateProductErrorState extends CreateProductState {
  final String? message;

  CreateProductErrorState({this.message});
}
