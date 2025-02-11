import 'package:flutter/material.dart';
import 'package:date_world/localization/controllers/localization_controller.dart';
import 'package:date_world/localization/language_constrants.dart';
import 'package:date_world/theme/controllers/theme_controller.dart';
import 'package:date_world/utill/custom_themes.dart';
import 'package:date_world/utill/dimensions.dart';
import 'package:provider/provider.dart';

class SearchHomePageWidget extends StatelessWidget {
  const SearchHomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraExtraSmall),
      child: Container(padding:  const EdgeInsets.symmetric(
          horizontal: Dimensions.homePagePadding, vertical: Dimensions.paddingSizeSmall),

        alignment: Alignment.center,
        child: Container(padding:  EdgeInsets.only(
          left: Provider.of<LocalizationController>(context, listen: false).isLtr?
          Dimensions.homePagePadding : Dimensions.paddingSizeExtraSmall,
            right: Provider.of<LocalizationController>(context, listen: false).isLtr? Dimensions.paddingSizeExtraSmall : Dimensions.homePagePadding),
          height: 60, alignment: Alignment.centerLeft,
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.onPrimary,
            boxShadow: Provider.of<ThemeController>(context).darkTheme ? null :
            [BoxShadow(color: Theme.of(context).hintColor.withValues(alpha:.1), spreadRadius: 1, blurRadius: 1, offset: const Offset(0,0))],
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
 Icon(Icons.search, color: Provider.of<ThemeController>(context, listen: false).darkTheme?
              Colors.white : 
              Theme.of(context).hintColor, size: Dimensions.iconSizeSmall),
              const SizedBox(width: 8,),
            Text(getTranslated('search_hint', context)??'',
                style: textRegular.copyWith(color: Theme.of(context).hintColor)),

            // Container(width: 40,height: 40,decoration: BoxDecoration(color: Theme.of(context).primaryColor,
            //     borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeExtraSmall))),
            //   child: Icon(Icons.search, color: Provider.of<ThemeController>(context, listen: false).darkTheme?
            //   Colors.white : Theme.of(context).cardColor, size: Dimensions.iconSizeSmall),
            // ),
          ]),
        ),
      ),
    );
  }
}
