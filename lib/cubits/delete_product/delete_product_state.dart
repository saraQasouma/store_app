class DeleteProductState {}

final class DeleteProductInitialState extends DeleteProductState {}

final class DeleteProductLoadingState extends DeleteProductState {}

final class DeleteProductSuccessState extends DeleteProductState {}

final class DeleteProductErrorState extends DeleteProductState {
  final String? message;

  DeleteProductErrorState({this.message});
}
