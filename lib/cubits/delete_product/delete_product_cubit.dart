import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/cubits/delete_product/delete_product_state.dart';
import 'package:store_app/services/delete_product_service.dart';

class DeleteProductCubit extends Cubit<DeleteProductState> {
  DeleteProductCubit() : super(DeleteProductInitialState());

  Future<void> deleteProduct(int id) async {
    try {
      emit(DeleteProductLoadingState());

      final success = await DeleteProductService().deleteProduct(id);

      if (success) {
        emit(DeleteProductSuccessState());
      } else {
        emit(DeleteProductErrorState(message: "Failed to delete product"));
      }
    } catch (e) {
      emit(DeleteProductErrorState(message: e.toString()));
    }
  }
}
