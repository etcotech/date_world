import 'package:date_world/features/auth/controllers/auth_controller.dart';
import 'package:date_world/features/auth/widgets/sign_up_widget.dart';
import 'package:date_world/features/dashboard/screens/dashboard_screen.dart';
import 'package:date_world/localization/language_constrants.dart';
import 'package:date_world/utill/custom_themes.dart';
import 'package:date_world/utill/dimensions.dart';
import 'package:date_world/utill/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget{
  final bool fromLogout;
  const AuthScreen({super.key, this.fromLogout = false});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {


  @override
  void initState() {
    Provider.of<AuthController>(context, listen: false).updateSelectedIndex(0, notify: false);
    super.initState();
  }
  bool scrolled = false;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (val) async {
        Future.delayed(Duration.zero, () {
          if (Provider.of<AuthController>(context, listen: false).selectedIndex != 0) {
            Provider.of<AuthController>(context, listen: false).updateSelectedIndex(0);
          } else {
            if(Navigator.canPop(context)) {
              Navigator.of(context).pop();
            }else{
              if (widget.fromLogout) {
                if (!Provider.of<AuthController>(context, listen: false).isLoading) {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const DashBoardScreen()), (route) => false);
                }
              } else {
                //Navigator.of(context).pop();
              }
              //showModalBottomSheet(backgroundColor: Colors.transparent, context: context, builder: (_)=> const AppExitCard());
            }
          }
          //return val;
        });
      },
      child: Scaffold(
        body: Consumer<AuthController>(
          builder: (context, authProvider,_) {
            return Column(children: [
                Stack(children: [

                  Container(height: 180, decoration: BoxDecoration(color: Theme.of(context).primaryColor)),
                  Image.asset(Images.loginBg,fit: BoxFit.cover,height: 180, opacity : const AlwaysStoppedAnimation(.15)),

                  Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .06),
                    child: Column(
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Image.asset(Images.logoImage, width: 130, height: 80)]),

                        Text(getTranslated('sign_up', context)!, style: titilliumRegular.copyWith(
                          color: Theme.of(context).highlightColor,
                          fontSize: Dimensions.fontSizeLarge,
                        )),
                      ],
                    )),

                  /// back button
                  // Positioned(
                  //   top: Dimensions.paddingSizeThirtyFive,
                  //   left:  Provider.of<LocalizationController>(context, listen: false).isLtr ? Dimensions.paddingSizeLarge : null,
                  //   right: Provider.of<LocalizationController>(context, listen: false).isLtr ? null : Dimensions.paddingSizeLarge,
                  //   child: IconButton(
                  //     icon: const Icon(Icons.arrow_back_ios, size: 30, color: Colors.white),
                  //     onPressed: () {
                  //       if(widget.fromLogout) {
                  //         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const DashBoardScreen()), (route) => false);
                  //       } else {
                  //         Navigator.of(context).pop();
                  //       }
                  //     },
                  //   )
                  // ),

                ]),

                AnimatedContainer(transform: Matrix4.translationValues(0, -12, 0),
                  curve: Curves.fastOutSlowIn,
                  decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusExtraLarge))),
                  duration: const Duration(seconds: 2),
                  child: Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Padding(padding: const EdgeInsets.symmetric(horizontal:  Dimensions.marginSizeLarge),
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          // InkWell(onTap: () => authProvider.updateSelectedIndex(0),
                          //     child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          //       Text(getTranslated('login', context)!, style: authProvider.selectedIndex == 0 ?
                          //       textRegular.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeLarge) :
                          //       textRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
                          //       Container(height: 3, width: 25, margin: const EdgeInsets.only(top: 8),
                          //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                          //             color: authProvider.selectedIndex == 0 ? Theme.of(context).primaryColor : Colors.transparent))])),
                          // const SizedBox(width: Dimensions.paddingSizeExtraLarge),

                          InkWell(onTap: () => authProvider.updateSelectedIndex(1),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [

                              // Text(getTranslated('sign_up', context)!, style:
                              // titilliumSemiBold.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeLarge)),
                              Container(height: 0, width: 25, margin: const EdgeInsets.only(top: 8),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                                color: Theme.of(context).primaryColor))

                            ])),


                        ])),
                    ],),
                  ),
                ),

              const Expanded(child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, ),
                //child: authProvider.selectedIndex == 0 ? const SignInWidget() : const SignUpWidget(),
                child: SignUpWidget(),
              )),

            ],
            );
          }
        ),
      ),
    );
  }
}

