import 'package:date_world/features/checkout/widgets/coupon_bottom_sheet_widget.dart';
import 'package:date_world/features/coupon/controllers/coupon_controller.dart';
import 'package:date_world/helper/price_converter.dart';
import 'package:date_world/localization/language_constrants.dart';
import 'package:date_world/utill/custom_themes.dart';
import 'package:date_world/utill/dimensions.dart';
import 'package:date_world/utill/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CouponApplyWidget extends StatelessWidget {
  final TextEditingController couponController;
  final double orderAmount;
  const CouponApplyWidget({super.key, required this.couponController, required this.orderAmount});

  @override
  Widget build(BuildContext context) {
    return Consumer<CouponController>(
      builder: (context, couponProvider, _) {
        return Padding(padding: const EdgeInsets.only(left:Dimensions.paddingSizeDefault,right:Dimensions.paddingSizeDefault),
          child: Container(height: 50, width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color:Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                border: Border.all(width: .5, color: Theme.of(context).primaryColor.withValues(alpha:.25))),

            child: (couponProvider.discount != null && couponProvider.discount != 0)?
            Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(children: [
                    SizedBox(height: 25,width: 25, child: Image.asset(Images.appliedCoupon)),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                    child: Text(couponProvider.couponCode, style: textBold.copyWith(
                      fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodyLarge?.color),),),

                  Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                      child: 
                         Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Images.SAR,
                      
                     
                      width: 12,height: 12,
                      color: Theme.of(context).hintColor ),
                      Text('(-${PriceConverter.convertPrice(context, couponProvider.discount)} off)',
                        style: textMedium.copyWith(color: 
                        Theme.of(context).primaryColor)
                        )
                    ]))
                        
                        
                        )]),

                InkWell(onTap: ()=> couponProvider.removeCoupon(),
                    child: Icon(Icons.clear, color: Theme.of(context).colorScheme.error))])):


            InkWell(onTap: ()=> showModalBottomSheet(context: context,
                isScrollControlled: true, backgroundColor: Colors.transparent,
                builder: (c) =>   CouponBottomSheetWidget(orderAmount: orderAmount)),
              child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('${getTranslated('add_coupon', context)}', style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge),),
                  Text('${getTranslated('add_more', context)}', style: textMedium.copyWith(color: Theme.of(context).primaryColor)),

                ],),
              ),
            ),
          ),
        );
      }
    );
  }
}
