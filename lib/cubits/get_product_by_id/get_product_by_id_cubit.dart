import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/services/get_product_by_id.dart';
import 'get_product_by_id_state.dart';

class GetProductByIdCubit extends Cubit<GetProductByIdState> {
  GetProductByIdCubit() : super(GetProductByIdInitial());

  Future<void> fetchProduct(int id) async {
    emit(GetProductByIdLoading());
    final product = await GetProductByIdService().getProductById(id);

    if (product != null) {
      emit(GetProductByIdSuccess(product));
    } else {
      emit(GetProductByIdError('Failed to fetch product'));
    }
  }
}
