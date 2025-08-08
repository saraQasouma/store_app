import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/cubits/delete_product/delete_product_cubit.dart';
import 'package:store_app/cubits/get_product_by_id/get_product_by_id_cubit.dart';
import 'package:store_app/cubits/get_products/get_products_cubit.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/views/product_detail_view.dart';

import 'package:store_app/views/update_product_view.dart';

class ProductActionButtonsWidget extends StatelessWidget {
  final ProductModel productModel;
  const ProductActionButtonsWidget({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: const Icon(Icons.delete, size: 20, color: Colors.red),
          onPressed: () async {
            await context
                .read<DeleteProductCubit>()
                .deleteProduct(productModel.id);
            await context.read<GetProductsCubit>().getProducts();
          },
        ),
        IconButton(
          icon: const Icon(Icons.edit, size: 20, color: Colors.blue),
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UpdateProductView(product: productModel),
              ),
            );
            if (result == true) {
              context.read<GetProductsCubit>().getProducts();
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.visibility, size: 20, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlocProvider(
                        create: (context) => GetProductByIdCubit()
                          ..fetchProduct(productModel.id),
                        child: DetailProductView(productId: productModel.id),
                      )),
            );
          },
        ),
      ],
    );
  }
}
