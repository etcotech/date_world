import 'package:flutter/material.dart';
import 'package:date_world/common/basewidget/custom_button_widget.dart';
import 'package:date_world/features/auth/screens/login_screen.dart';
import 'package:date_world/features/dashboard/screens/dashboard_screen.dart';
import 'package:date_world/localization/language_constrants.dart';
import 'package:date_world/utill/custom_themes.dart';
import 'package:date_world/utill/dimensions.dart';
import 'package:date_world/utill/images.dart';

class NotLoggedInWidget extends StatelessWidget {
  final String? message;
  const NotLoggedInWidget({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
            child: SizedBox(width: 60,child: Image.asset(Images.loginIcon, color: Theme.of(context).primaryColor,)),),
          Text(getTranslated('please_login', context)!, style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge),),

          Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall, bottom: Dimensions.paddingSizeLarge),
            child: Text( message ?? '${getTranslated('need_to_login', context)}', textAlign: TextAlign.center),),

          Center(child: SizedBox(width: 120,child: CustomButton(buttonText: '${getTranslated('login', context)}',
              backgroundColor: Theme.of(context).primaryColor,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()))))),

        InkWell(onTap: ()=> Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> const DashBoardScreen()), (route) => false),
          child: Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeLarge),
            child: Text(getTranslated('back_to_home', context)!,
              style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge,
                  color: Theme.of(context).primaryColor, decoration: TextDecoration.underline, decorationColor: Theme.of(context).primaryColor),)),
        ),
        ],
      ),
    );
  }
}
