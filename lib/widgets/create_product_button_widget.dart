import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/cubits/create_product/create_product_cubit.dart';
import 'package:store_app/models/product_model.dart';

class CreateProductButtonWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController priceController;
  final TextEditingController descriptionController;
  final TextEditingController categoryIdController;
  final TextEditingController imagesController;

  const CreateProductButtonWidget({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.priceController,
    required this.descriptionController,
    required this.categoryIdController,
    required this.imagesController,
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
        'Create Product',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  void _submitForm(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final newProduct = ProductModel(
        id: 0,
        title: titleController.text,
        slug: titleController.text.toLowerCase().replaceAll(' ', '-'),
        price: double.parse(priceController.text),
        description: descriptionController.text,
        category: Category(
          id: int.parse(categoryIdController.text),
          name: '',
          image: '',
          slug: '',
        ),
        images: imagesController.text.split(',').map((e) => e.trim()).toList(),
      );
      await context.read<CreateProductCubit>().createProduct(newProduct);

      // context.read<GetProductsCubit>().getProducts();
      //  Navigator.pop(context, true);
    }
  }
}
