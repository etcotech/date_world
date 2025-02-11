import 'package:flutter/material.dart';
import 'package:date_world/features/wallet/domain/models/transaction_model.dart';
import 'package:date_world/helper/date_converter.dart';
import 'package:date_world/helper/price_converter.dart';
import 'package:date_world/localization/controllers/localization_controller.dart';
import 'package:date_world/localization/language_constrants.dart';
import 'package:date_world/utill/color_resources.dart';
import 'package:date_world/utill/custom_themes.dart';
import 'package:date_world/utill/dimensions.dart';
import 'package:date_world/utill/images.dart';
import 'package:provider/provider.dart';


class TransactionWidget extends StatelessWidget {
  final WalletTransactioList? transactionModel;
  final bool isLastIndex;
  const TransactionWidget({super.key, this.transactionModel, required this.isLastIndex});

  @override
  Widget build(BuildContext context) {
    final bool isLtr = Provider.of<LocalizationController>(context, listen: false).isLtr;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.homePagePadding,vertical: Dimensions.paddingSizeSmall),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          if(transactionModel!.adminBonus! > 0)
          Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
              Row(children: [
                const Image(image: AssetImage(Images.coinDebit), width: 25,height: 25,),
                const SizedBox(width: Dimensions.paddingSizeSmall,),

                Text( '+' , style: robotoBold.copyWith(color: ColorResources.getTextTitle(context), fontSize: Dimensions.fontSizeLarge),),

                Text(PriceConverter.convertPrice(context, transactionModel!.adminBonus), style: robotoBold.copyWith(color: ColorResources.getTextTitle(context), fontSize: Dimensions.fontSizeLarge),),
              ],
              ),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall,),


              Text('admin bonus', style: textRegular.copyWith(color: ColorResources.getHint(context)),),


            ],)),
            Column(crossAxisAlignment: CrossAxisAlignment.end,children: [
              Text(DateConverter.estimatedDateYear(DateTime.parse(transactionModel!.createdAt!)),
                style: textRegular.copyWith(color: ColorResources.getHint(context)),),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall,),


              Text( transactionModel!.credit! > 0 ? 'Credit': 'Debit',
                style: textRegular.copyWith(color: transactionModel!.credit! > 0 ? Colors.green: Colors.red),
              ),
            ],),
          ],),
          if(transactionModel!.adminBonus! > 0)
          Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
            child: Divider(thickness: .4,color: Theme.of(context).hintColor.withValues(alpha:.8),),),
          Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
            Row(children: [
                Image(image: AssetImage(transactionModel!.credit! > 0 ? Images.coinDebit: Images.coinCredit), width: 25,height: 25,),
              const SizedBox(width: Dimensions.paddingSizeSmall,),

             if(isLtr) Text( transactionModel!.credit! > 0 ? '+': '-',
                style: robotoBold.copyWith(color: ColorResources.getTextTitle(context),
                    fontSize: Dimensions.fontSizeLarge),
              ),

                Text(PriceConverter.convertPrice(context,
                    transactionModel!.credit! > 0 ? transactionModel!.credit: transactionModel!.debit),
                  style: robotoBold.copyWith(color: ColorResources.getTextTitle(context),
                      fontSize: Dimensions.fontSizeLarge),
                ),

              if(!isLtr) Text( transactionModel!.credit! > 0 ? '+': '-',
                style: robotoBold.copyWith(color: ColorResources.getTextTitle(context),
                    fontSize: Dimensions.fontSizeLarge),
              ),
              ],
            ),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall,),



            transactionModel?.paymentMethod != null?
            Text('${getTranslated(transactionModel?.transactionType, context)} ${getTranslated('via', context)} ${(transactionModel?.paymentMethod??'').replaceAll('_', ' ')}', style: textRegular.copyWith(color: ColorResources.getHint(context)),):
            Text('${getTranslated(transactionModel?.transactionType, context)}', style: textRegular.copyWith(color: ColorResources.getHint(context)),),


          ],)),
          Column(crossAxisAlignment: CrossAxisAlignment.end,children: [
            Text(DateConverter.estimatedDateYear(DateTime.parse(transactionModel!.createdAt!)),
              style: textRegular.copyWith(color: ColorResources.getHint(context)),),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall,),


            Text( transactionModel!.credit! > 0 ? 'Credit': 'Debit',
              style: textRegular.copyWith(color: transactionModel!.credit! > 0 ? Colors.green: Colors.red),
            ),
          ],),
          ],),

         if(!isLastIndex) Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
            child: Divider(thickness: .4,color: Theme.of(context).hintColor.withValues(alpha:.8),),),
        ],
      ),);
  }
}
