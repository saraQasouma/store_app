class UpdateProductState {}

final class UpdateProductInitialState extends UpdateProductState {}

final class UpdateProductLoadingState extends UpdateProductState {}

final class UpdateProductSuccessState extends UpdateProductState {}

final class UpdateProductErrorState extends UpdateProductState {
  final String? message;

  UpdateProductErrorState({this.message});
}
