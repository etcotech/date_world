import 'package:date_world/common/basewidget/title_row_widget.dart';
import 'package:date_world/features/category/controllers/category_controller.dart';
import 'package:date_world/features/category/screens/category_screen.dart';
import 'package:date_world/features/category/widgets/category_widget.dart';
import 'package:date_world/features/product/screens/brand_and_category_product_screen.dart';
import 'package:date_world/localization/controllers/localization_controller.dart';
import 'package:date_world/localization/language_constrants.dart';
import 'package:date_world/utill/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'category_shimmer_widget.dart';

class CategoryListWidget extends StatelessWidget {
  final bool isHomePage;
  const CategoryListWidget({super.key, required this.isHomePage});

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryController>(
      builder: (context, categoryProvider, child) {
        return Column(children: [

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraExtraSmall),
            child: TitleRowWidget(
              title: getTranslated('CATEGORY', context),
              onTap: () {
                if(categoryProvider.categoryList.isNotEmpty) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const CategoryScreen()));
                }
              },
            ),
          ),
          const SizedBox(height: Dimensions.paddingSizeSmall),

          categoryProvider.categoryList.isNotEmpty ?
          SizedBox( height: Provider.of<LocalizationController>(context, listen: false).isLtr ? MediaQuery.of(context).size.width/3.7 : MediaQuery.of(context).size.width/3,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: categoryProvider.categoryList.length>5? 5: categoryProvider.categoryList.length ,
              // shrinkWrap: true,
              
              itemBuilder: (BuildContext context, int index) {
                return InkWell( splashColor: Colors.transparent, highlightColor: Colors.transparent,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
                          isBrand: false,
                          id: categoryProvider.categoryList[index].id.toString(),
                          name: categoryProvider.categoryList[index].name)));
                    },
                    child: CategoryWidget(category: categoryProvider.categoryList[index],
                        index: index,length:  categoryProvider.categoryList.length),
                );
              },
            ),
          ) : const CategoryShimmerWidget(),
        ]);

      },
    );
  }
}



