import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/cubits/get_product_by_id/get_product_by_id_cubit.dart';
import 'package:store_app/cubits/get_product_by_id/get_product_by_id_state.dart';
import 'package:store_app/widgets/build_product_details_widget.dart';

class DetailProductView extends StatelessWidget {
  final int productId;

  const DetailProductView({super.key, required this.productId});

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFF4A90E2),
        ),
        title: const Text(
          'Product detail',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4A90E2)),
        ),
      ),
      body: BlocBuilder<GetProductByIdCubit, GetProductByIdState>(
        builder: (context, state) {
          if (state is GetProductByIdSuccess) {
            return BuildProductDetailsWidget(product: state.product);
          } else if (state is GetProductByIdError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.red),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
