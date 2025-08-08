import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/cubits/get_products/get_products_cubit.dart';
import 'package:store_app/views/create_product_view.dart';
import 'package:store_app/widgets/product%20_container_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Store App',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A90E2),
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(Icons.shopping_cart, color: Color(0xFF4A90E2)),
          ),
        ],
      ),
      body: BlocBuilder<GetProductsCubit, GetProductCubitState>(
        builder: (context, state) {
          if (state is GetProductSuccessState) {
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemCount: state.productList.length,
              itemBuilder: (context, index) {
                return ProductContainerWidget(
                  productModel: state.productList[index],
                );
              },
            );
          } else if (state is GetProductErrorState) {
            return Center(
              child: Text(
                state.message ?? 'Error occurred while loading products',
                style: const TextStyle(
                    color: Colors.red, fontWeight: FontWeight.bold),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF4A90E2),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateProductView(),
            ),
          );
          if (result == true) {
            context.read<GetProductsCubit>().getProducts();
          }
        },
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: const Text(
          'Create Product',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF4A90E2),
      ),
    );
  }
}
