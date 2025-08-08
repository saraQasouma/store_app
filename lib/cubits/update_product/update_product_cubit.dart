import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/cubits/update_product/update_product_state.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/services/update_product_service.dart';

class UpdateProductCubit extends Cubit<UpdateProductState> {
  UpdateProductCubit() : super(UpdateProductInitialState());

  Future<void> updateProduct(int id, ProductModel updatedProduct) async {
    try {
      emit(UpdateProductLoadingState());

      await UpdateProductService().updateProduct(id, updatedProduct);

      emit(UpdateProductSuccessState());
    } catch (e) {
      emit(UpdateProductErrorState(message: e.toString()));
    }
  }
}
