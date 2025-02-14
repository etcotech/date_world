import 'package:date_world/common/basewidget/custom_image_widget.dart';
import 'package:date_world/common/basewidget/not_logged_in_bottom_sheet_widget.dart';
import 'package:date_world/features/auth/controllers/auth_controller.dart';
import 'package:date_world/features/profile/controllers/profile_contrroller.dart';
import 'package:date_world/features/profile/screens/profile_screen1.dart';
import 'package:date_world/utill/custom_themes.dart';
import 'package:date_world/utill/dimensions.dart';
import 'package:date_world/utill/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileInfoSectionWidget extends StatelessWidget {
  const ProfileInfoSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool isGuestMode = !Provider.of<AuthController>(context, listen: false).isLoggedIn();
    return Consumer<ProfileController>(
        builder: (context,profile,_) {
          return Container(decoration: const BoxDecoration(

          )
              // color: Provider.of<ThemeController>(context).darkTheme ?
              // Theme.of(context).primaryColor.withValues(alpha:.30) : Theme.of(context).primaryColor),
          ,  child: Stack(children: [
              Container(transform: Matrix4.translationValues(-10, 0, 0),
                child: Padding(padding: const EdgeInsets.only(top: 20.0),
                  child: SizedBox(width: 110, child: Image.asset(Images.shadow, opacity: const AlwaysStoppedAnimation(0.75))))),

              Positioned(right: -110,bottom: -100,
                child: Container(width: 200,height: 200,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Theme.of(context).cardColor.withValues(alpha:.05), width: 25)))),

              Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 70.0,Dimensions.paddingSizeDefault, 30),
                child: Row(children: [
                  InkWell(onTap: () {
                      if(isGuestMode) {
                        showModalBottomSheet(backgroundColor: Colors.transparent,context:context, builder: (_)=> const NotLoggedInBottomSheetWidget());
                      }else {if(profile.userInfoModel != null) {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfileScreen1()));
                        }
                      }
                    },
                    child: ClipRRect(borderRadius: BorderRadius.circular(100),
                        child: Container(width: 70,height: 70,  decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          border: Border.all(color: Colors.white, width: 3),
                          shape: BoxShape.circle,),
                          child: Provider.of<AuthController>(context, listen: false).isLoggedIn()?
                          CustomImageWidget(image: '${profile.userInfoModel?.imageFullUrl?.path}', width: 70,height: 70,fit: BoxFit.cover,placeholder: Images.guestProfile):
                          Image.asset(Images.guestProfile),)),
                  ),
                  const SizedBox(width: Dimensions.paddingSizeDefault),

                  Expanded(child: Column(crossAxisAlignment:
                   CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(!isGuestMode?
                    '${profile.userInfoModel?.fName??''} ${profile.userInfoModel?.lName??''}' :
                     'Guest',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                        style:
                         textMedium.copyWith( fontSize: Dimensions.fontSizeLarge)),

                    if(!isGuestMode && profile.userInfoModel?.phone != null && profile.userInfoModel!.phone!.isNotEmpty)
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    if(!isGuestMode)
                    Text(profile.userInfoModel?.phone??'', style: 
                    textRegular.copyWith( fontSize: Dimensions.fontSizeLarge)),
                  ],)),
isGuestMode?const SizedBox():
                  InkWell(onTap: ()=>          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfileScreen1())),
                    child: const Padding(padding: EdgeInsets.all(8.0),
                      child: SizedBox(width: 40, child:
                      
                      Icon(Icons.arrow_forward_ios)
                       
                       )
                       
                       ),
                  )
                  
                  ])),
            ]));
        });
  }
}
