import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:store_app/cubits/create_product/create_product_cubit.dart';
import 'package:store_app/cubits/create_product/create_product_state.dart';
import 'package:store_app/widgets/create_product_button_widget.dart';
import 'package:store_app/widgets/labeled_input_field_widget.dart';

class CreateProductView extends StatefulWidget {
  const CreateProductView({super.key});

  @override
  State<CreateProductView> createState() => _CreateProductViewState();
}

class _CreateProductViewState extends State<CreateProductView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryIdController = TextEditingController(text: '1');
  final _imagesController = TextEditingController(
    text: 'https://example.com/image.jpg',
  );

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
      create: (context) => CreateProductCubit(),
      child: BlocConsumer<CreateProductCubit, CreateProductState>(
        listener: (context, state) {
          if (state is CreateProductLoadingState) {
            setState(() => _isLoading = true);
          } else {
            setState(() => _isLoading = false);
          }

          if (state is CreateProductSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Product added successfully!')),
            );
            //  context.read<GetProductsCubit>().getProducts(); // لتحديث القائمة
            Navigator.pop(context, true);
          }

          if (state is CreateProductErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.message ??
                      'Error occurred while adding the product')),
            );
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: _isLoading,
            child: Scaffold(
              appBar: AppBar(
                  iconTheme: const IconThemeData(
                    color: Color(0xFF4A90E2),
                  ),
                  title: const Text(
                    'Create Product',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4A90E2)),
                  )),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      LabeledInputField(
                        label: 'Title',
                        hintText: 'Enter product title',
                        controller: _titleController,
                        required: true,
                      ),
                      LabeledInputField(
                        label: 'Price',
                        hintText: 'Enter product price',
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        prefixText: '\$ ',
                        required: true,
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
                        required: true,
                      ),
                      LabeledInputField(
                        label: 'Category ID',
                        hintText: 'Enter category ID',
                        controller: _categoryIdController,
                        keyboardType: TextInputType.number,
                        required: true,
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
                        required: true,
                      ),
                      const SizedBox(height: 24),
                      CreateProductButtonWidget(
                        formKey: _formKey,
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
            ),
          );
        },
      ),
    );
  }
}
