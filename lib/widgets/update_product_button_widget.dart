import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/cubits/update_product/update_product_cubit.dart';
import 'package:store_app/models/product_model.dart';

class UpdateProductButtonWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final ProductModel product;
  final TextEditingController titleController;
  final TextEditingController priceController;
  final TextEditingController descriptionController;
  final TextEditingController categoryIdController;
  final TextEditingController imagesController;
  // final bool isLoading;

  const UpdateProductButtonWidget({
    super.key,
    required this.formKey,
    required this.product,
    required this.titleController,
    required this.priceController,
    required this.descriptionController,
    required this.categoryIdController,
    required this.imagesController,
    //  required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4A90E2),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: () => _submitForm(context),
      child: const Text(
        'Update Product',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  void _submitForm(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final updatedProduct = ProductModel(
        id: product.id,
        title: titleController.text,
        price: double.parse(priceController.text),
        description: descriptionController.text,
        category: Category(
          id: int.parse(categoryIdController.text),
          name: product.category.name,
          image: product.category.image,
          slug: product.category.slug,
        ),
        images: imagesController.text.split(',').map((e) => e.trim()).toList(),
        slug: product.slug,
      );

      await context
          .read<UpdateProductCubit>()
          .updateProduct(product.id, updatedProduct);
    }
  }
}
