import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/cubits/create_product/create_product_state.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/services/create_product_service.dart';

class CreateProductCubit extends Cubit<CreateProductState> {
  CreateProductCubit() : super(CreateProductInitialState());
  Future<void> createProduct(ProductModel newProduct) async {
    try {
      emit(CreateProductLoadingState());

      await CreateProductService().createProduct(newProduct);
      emit(CreateProductSuccessState());
    } catch (e) {
      emit(CreateProductErrorState(message: e.toString()));
    }
  }
}
