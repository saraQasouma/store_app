import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:store_app/cubits/get_products/get_products_cubit.dart';
import 'package:store_app/cubits/update_product/update_product_cubit.dart';
import 'package:store_app/cubits/update_product/update_product_state.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/widgets/labeled_input_field_widget.dart';
import 'package:store_app/widgets/update_product_button_widget.dart';

class UpdateProductView extends StatefulWidget {
  final ProductModel product;

  const UpdateProductView({
    super.key,
    required this.product,
  });

  @override
  State<UpdateProductView> createState() => _UpdateProductViewState();
}

class _UpdateProductViewState extends State<UpdateProductView> {
  late final TextEditingController _titleController;
  late final TextEditingController _priceController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _categoryIdController;
  late final TextEditingController _imagesController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.product.title);
    _priceController =
        TextEditingController(text: widget.product.price.toString());
    _descriptionController =
        TextEditingController(text: widget.product.description);
    _categoryIdController =
        TextEditingController(text: widget.product.category.id.toString());
    _imagesController =
        TextEditingController(text: widget.product.images.join(', '));
  }

  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _categoryIdController.dispose();
    _imagesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateProductCubit(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color(0xFF4A90E2),
          ),
          title: const Text(
            'Update Product',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A90E2)),
          ),
        ),
        body: BlocConsumer<UpdateProductCubit, UpdateProductState>(
          listener: (context, state) {
            if (state is UpdateProductLoadingState) {
              setState(() => _isLoading = true);
            } else {
              setState(() => _isLoading = false);
            }
            if (state is UpdateProductSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Product updated successfully!')),
              );
              context.read<GetProductsCubit>().getProducts();
              Navigator.pop(context, true);
            } else if (state is UpdateProductErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(state.message ??
                        'Error occurred while updating the product')),
              );
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: _isLoading,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      LabeledInputField(
                        label: 'Title',
                        hintText: 'Enter product title',
                        controller: _titleController,
                      ),
                      LabeledInputField(
                        label: 'Price',
                        hintText: 'Enter product price',
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        prefixText: '\$ ',
                        validator: (value) {
                          if (double.tryParse(value ?? '') == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                      ),
                      LabeledInputField(
                        label: 'Description',
                        hintText: 'Enter product description',
                        controller: _descriptionController,
                        maxLines: 3,
                      ),
                      LabeledInputField(
                        label: 'Category ID',
                        hintText: 'Enter category ID',
                        controller: _categoryIdController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (int.tryParse(value ?? '') == null) {
                            return 'Must be a whole number';
                          }
                          return null;
                        },
                      ),
                      LabeledInputField(
                        label: 'Images',
                        hintText: 'Enter image URLs (comma separated)',
                        controller: _imagesController,
                      ),
                      const SizedBox(height: 24),
                      UpdateProductButtonWidget(
                        formKey: _formKey,
                        product: widget.product,
                        titleController: _titleController,
                        priceController: _priceController,
                        descriptionController: _descriptionController,
                        categoryIdController: _categoryIdController,
                        imagesController: _imagesController,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
