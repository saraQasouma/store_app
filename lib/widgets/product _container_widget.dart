import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/cubits/delete_product/delete_product_cubit.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/widgets/image_gradient_over_lay_widget.dart';
import 'package:store_app/widgets/image_navigation_arrows_widget.dart';
import 'package:store_app/widgets/image_page_indicator_widget.dart';
import 'package:store_app/widgets/product_info_over_lay_widget.dart';

class ProductContainerWidget extends StatefulWidget {
  final ProductModel productModel;

  const ProductContainerWidget({
    super.key,
    required this.productModel,
  });

  @override
  State<ProductContainerWidget> createState() => _ProductContainerWidgetState();
}

class _ProductContainerWidgetState extends State<ProductContainerWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _goToNextPage() {
    if (_currentPage < widget.productModel.images.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteProductCubit(),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: SizedBox(
          width: 150,
          height: 150,
          child: Stack(
            children: [
              if (widget.productModel.images.isNotEmpty)
                PageView.builder(
                  controller: _pageController,
                  itemCount: widget.productModel.images.length,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemBuilder: (context, index) => ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.productModel.images[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                )
              else
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(child: Icon(Icons.image, size: 50)),
                ),
              const ImageGradientOverLayWidget(),
              ImageNavigationArrowsWidget(
                totalPages: widget.productModel.images.length,
                currentPage: _currentPage,
                onNext: _goToNextPage,
                onPrevious: _goToPreviousPage,
              ),
              ImagePageIndicatorWidget(
                  currentPage: _currentPage,
                  pageCount: widget.productModel.images.length),
              ProductInfoOverLayWidget(
                productModel: widget.productModel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
