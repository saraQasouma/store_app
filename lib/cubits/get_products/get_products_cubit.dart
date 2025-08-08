import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/services/get_products_service.dart';

part 'get_products_state.dart';

class GetProductsCubit extends Cubit<GetProductCubitState> {
  GetProductsCubit() : super(GetProductInitialState());

  Future<void> getProducts() async {
    emit(GetProductLoadingState());
    try {
      var productList = await GetProductsService().getProducts();
      emit(GetProductSuccessState(productList: productList));
    } catch (e) {
      emit(GetProductErrorState(message: e.toString()));
    }
  }
}
