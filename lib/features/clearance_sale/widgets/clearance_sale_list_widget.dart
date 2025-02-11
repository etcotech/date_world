import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:date_world/common/basewidget/product_widget.dart';
import 'package:date_world/features/clearance_sale/screens/clearance_sale_all_product_screen.dart';
import 'package:date_world/features/clearance_sale/widgets/clearance_title_row_widget.dart';
import 'package:date_world/features/product/controllers/product_controller.dart';
import 'package:date_world/helper/responsive_helper.dart';
import 'package:date_world/features/home/widgets/aster_theme/find_what_you_need_shimmer.dart';
import 'package:date_world/localization/language_constrants.dart';
import 'package:date_world/utill/dimensions.dart';
import 'package:provider/provider.dart';

class ClearanceListWidget extends StatelessWidget {
  const ClearanceListWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductController>(
        builder: (context, productController, child) {
          return productController.clearanceProductModel != null
              ? (productController.clearanceProductModel?.products != null && productController.clearanceProductModel!.products!.isNotEmpty)
              ? Column(
              children: [Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
              child: ClearanceTitleRowWidget(title: '${getTranslated('clearance_sale_banner', context)}',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ClearanceSaleAllProductScreen())),),),
                SizedBox(height: ResponsiveHelper.isTab(context)? MediaQuery.of(context).size.width * .58 : 320,
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
                      enableInfiniteScroll: true,
                    ),
                    itemCount: productController.clearanceProductModel?.products?.length,
                    itemBuilder: (context, index, _) => ProductWidget(productModel: productController.clearanceProductModel!.products![index], productNameLine: 1)
                ),
              ),
            ],
          ) : const SizedBox() : const FindWhatYouNeedShimmer();
        });
  }
}
