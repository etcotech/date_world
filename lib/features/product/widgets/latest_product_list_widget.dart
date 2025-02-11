import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:date_world/common/basewidget/product_widget.dart';
import 'package:date_world/common/basewidget/slider_product_shimmer_widget.dart';
import 'package:date_world/features/product/controllers/product_controller.dart';
import 'package:date_world/features/product/screens/view_all_product_screen.dart';
import 'package:date_world/features/product/enums/product_type.dart';
import 'package:date_world/helper/responsive_helper.dart';
import 'package:date_world/localization/language_constrants.dart';
import 'package:date_world/utill/dimensions.dart';
import 'package:date_world/common/basewidget/title_row_widget.dart';
import 'package:provider/provider.dart';



class LatestProductListWidget extends StatelessWidget {
  const LatestProductListWidget({super.key});




  @override
  Widget build(BuildContext context) {
    return Consumer<ProductController>(builder: (context, prodProvider, child) {
      return (prodProvider.latestProductList?.isNotEmpty ?? false)  ? Column( children: [
        TitleRowWidget(
          title: getTranslated('latest_products', context),
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => AllProductScreen(productType: ProductType.latestProduct))),
        ),

        const SizedBox(height: Dimensions.paddingSizeSmall),


        SizedBox(
          height: ResponsiveHelper.isTab(context)? MediaQuery.of(context).size.width * .58 : 320,
          child: CarouselSlider.builder(
            options: CarouselOptions(
              viewportFraction: ResponsiveHelper.isTab(context)? .5 :.65,
              autoPlay: false,
              pauseAutoPlayOnTouch: true,
              pauseAutoPlayOnManualNavigate: true,
              enlargeFactor: 0.2,
              enlargeCenterPage: true,
              pauseAutoPlayInFiniteScroll: true,
              disableCenter: true,
            ),
            itemCount: prodProvider.latestProductList?.length,
            itemBuilder: (context, index, next) {
              return ProductWidget(productModel: prodProvider.latestProductList![index], productNameLine: 1);
            },
          ),
        ),




      ]) : prodProvider.latestProductList == null ? const SliderProductShimmerWidget() : const SizedBox();
    });
  }
}

