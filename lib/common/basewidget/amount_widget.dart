import 'package:date_world/utill/custom_themes.dart';
import 'package:date_world/utill/dimensions.dart';
import 'package:date_world/utill/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AmountWidget extends StatelessWidget {
  final String? title;
  final String amount;

  const AmountWidget({super.key, required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(title!, style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge!.color!.withValues(alpha:.5))),
        
        
           Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    spacing: 3,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Images.SAR,
                      
                     
                      width: 12,height: 12,
                      color: Colors.black),
        Text(amount, style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeDefault)
        ),
                    ]))
      ]),
    );
  }
}
