import 'package:date_world/common/basewidget/title_row_widget.dart';
import 'package:date_world/features/address/controllers/address_controller.dart';
import 'package:date_world/features/auth/controllers/auth_controller.dart';
import 'package:date_world/features/auth/screens/login_screen.dart';
import 'package:date_world/features/banner/controllers/banner_controller.dart';
import 'package:date_world/features/banner/widgets/banners_widget.dart';
import 'package:date_world/features/banner/widgets/single_banner_widget.dart';
import 'package:date_world/features/brand/controllers/brand_controller.dart';
import 'package:date_world/features/brand/widgets/brand_list_widget.dart';
import 'package:date_world/features/cart/controllers/cart_controller.dart';
import 'package:date_world/features/cart/screens/cart_screen.dart';
import 'package:date_world/features/category/controllers/category_controller.dart';
import 'package:date_world/features/category/widgets/category_list_widget.dart';
import 'package:date_world/features/clearance_sale/widgets/clearance_sale_list_widget.dart';
import 'package:date_world/features/deal/controllers/featured_deal_controller.dart';
import 'package:date_world/features/deal/controllers/flash_deal_controller.dart';
import 'package:date_world/features/deal/screens/featured_deal_screen_view.dart';
import 'package:date_world/features/deal/screens/flash_deal_screen_view.dart';
import 'package:date_world/features/deal/widgets/featured_deal_list_widget.dart';
import 'package:date_world/features/deal/widgets/flash_deals_list_widget.dart';
import 'package:date_world/features/home/shimmers/flash_deal_shimmer.dart';
import 'package:date_world/features/home/widgets/announcement_widget.dart';
import 'package:date_world/features/home/widgets/aster_theme/find_what_you_need_shimmer.dart';
import 'package:date_world/features/home/widgets/featured_product_widget.dart';
import 'package:date_world/features/home/widgets/search_home_page_widget.dart';
import 'package:date_world/features/notification/controllers/notification_controller.dart';
import 'package:date_world/features/product/controllers/product_controller.dart';
import 'package:date_world/features/product/enums/product_type.dart';
import 'package:date_world/features/product/widgets/home_category_product_widget.dart';
import 'package:date_world/features/product/widgets/latest_product_list_widget.dart';
import 'package:date_world/features/product/widgets/products_list_widget.dart';
import 'package:date_world/features/profile/controllers/profile_contrroller.dart';
import 'package:date_world/features/search_product/screens/search_product_screen.dart';
import 'package:date_world/features/shop/controllers/shop_controller.dart';
import 'package:date_world/features/splash/controllers/splash_controller.dart';
import 'package:date_world/features/splash/domain/models/config_model.dart';
import 'package:date_world/localization/language_constrants.dart';
import 'package:date_world/main.dart';
import 'package:date_world/theme/controllers/theme_controller.dart';
import 'package:date_world/utill/custom_themes.dart';
import 'package:date_world/utill/dimensions.dart';
import 'package:date_world/utill/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  static Future<void> loadData(bool reload) async {
    final flashDealController =
        Provider.of<FlashDealController>(Get.context!, listen: false);
    final shopController =
        Provider.of<ShopController>(Get.context!, listen: false);
    final categoryController =
        Provider.of<CategoryController>(Get.context!, listen: false);
    final bannerController =
        Provider.of<BannerController>(Get.context!, listen: false);
    final addressController =
        Provider.of<AddressController>(Get.context!, listen: false);
    final productController =
        Provider.of<ProductController>(Get.context!, listen: false);
    final brandController =
        Provider.of<BrandController>(Get.context!, listen: false);
    final featuredDealController =
        Provider.of<FeaturedDealController>(Get.context!, listen: false);
    final notificationController =
        Provider.of<NotificationController>(Get.context!, listen: false);
    final cartController =
        Provider.of<CartController>(Get.context!, listen: false);
    final profileController =
        Provider.of<ProfileController>(Get.context!, listen: false);

    if (flashDealController.flashDealList.isEmpty || reload) {
      // await flashDealController.getFlashDealList(reload, false);
    }

    categoryController.getCategoryList(reload);

    bannerController.getBannerList(reload);

    shopController.getTopSellerList(reload, 1, type: "top");

    shopController.getAllSellerList(reload, 1, type: "all");

    if (addressController.addressList == null ||
        (addressController.addressList != null &&
            addressController.addressList!.isEmpty) ||
        reload) {
      addressController.getAddressList();
    }

    cartController.getCartData(Get.context!);

    productController.getHomeCategoryProductList(reload);

    brandController.getBrandList(reload);

    featuredDealController.getFeaturedDealList(reload);

    productController.getLProductList('1', reload: reload);

    productController.getLatestProductList(1, reload: reload);

    productController.getFeaturedProductList('1', reload: reload);

    productController.getRecommendedProduct();

    productController.getClearanceAllProductList('1');

    if (notificationController.notificationModel == null ||
        (notificationController.notificationModel != null &&
            notificationController.notificationModel!.notification!.isEmpty) ||
        reload) {
      notificationController.getNotificationList(1);
    }

    if (Provider.of<AuthController>(Get.context!, listen: false).isLoggedIn() &&
        profileController.userInfoModel == null) {
      profileController.getUserInfo(Get.context!);
    }
  }
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  void passData(int index, String title) {
    index = index;
    title = title;
  }

  bool singleVendor = false;

  @override
  void initState() {
    super.initState();
    singleVendor = Provider.of<SplashController>(context, listen: false)
            .configModel!
            .businessMode ==
        "single";
  }

  @override
  Widget build(BuildContext context) {
    bool isGuestMode =
        !Provider.of<AuthController>(Get.context!, listen: false).isLoggedIn();

    final ConfigModel? configModel =
        Provider.of<SplashController>(context, listen: false).configModel;

    List<String?> types = [
      getTranslated('new_arrival', context),
      getTranslated('top_product', context),
      getTranslated('best_selling', context),
      getTranslated('discounted_product', context)
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Colors.black,
      //  appBar:  PreferredSize(preferredSize: const Size.fromHeight(100),
      //      child:

      //      Container(
      //       height: 100,
      //       margin: const EdgeInsets.only(
      //         bottom: 32
      //       ),
      //           padding: const EdgeInsets.only(top: 30, left: 16,
      //            right: 16, bottom: 5),
      //           // color: Theme.of(context).primaryColor,
      //           child: Column(
      //             children: [
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                 Row(
      //                   children: [

      //     Image.asset(Images.logoWithNameImage,
      //     // color: Colors.white,
      //      height: 50,width: 150,),
      //                   ],
      //                 ),

      //                 Consumer<ProfileController>(
      //       builder: (context,profile,_) {

      //         if (profile.userInfoModel==null) {

      //           return InkWell(

      //             onTap: (){
      //  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
      //             },
      //             child: Row(
      //               mainAxisSize: MainAxisSize.min,
      //               children: [
      //             TextButton(onPressed: (){

      //             }, child:  Text(getTranslated('sign_in', context)!, style: const TextStyle(
      //               color: Colors.black ,fontSize: 16
      //             ),)),

      //                 const Icon(Icons.person_outline, color: Colors.black),
      //               ],
      //             ),
      //           );

      //         }
      //                       return Row(
      //                         children: [

      //                          !isGuestMode?  Text(
      //                           "${ profile.userInfoModel?.fName}"
      //                            ,
      //                                                     style:  const TextStyle(
      //                                                       fontWeight: FontWeight.w600,
      //                            color: Colors.black
      //                          ),

      //                          )
      //                          :
      //                          const Icon(Icons.person_outline, color: Colors.black),
      //                           const SizedBox(width: 8),
      //                           Stack(
      //                             children: [
      //                                Icon(Icons.shopping_cart_outlined, color: Theme.of(context).primaryColor),
      //                               InkWell(
      //                                 onTap: (){
      //                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen(

      //                                      )));

      //                                 },
      //                                 child: Positioned(
      //                                   right: 0,
      //                                   top: 0,
      //                                   child: Container(
      //                                     padding: const EdgeInsets.all(2),
      //                                     decoration: const BoxDecoration(
      //                                       color: Colors.orange,
      //                                       shape: BoxShape.circle,
      //                                     ),
      //                                     child: const Text(
      //                                       "",
      //                                       style: TextStyle(
      //                                         color: Colors.white,
      //                                         fontSize: 12,
      //                                       ),
      //                                     ),
      //                                   ),
      //                                 ),
      //                               ),
      //                             ],
      //                           ),
      //                         ],
      //                       );
      //                     }
      //                   ),
      //                 ],
      //               )
      //             ]
      //           )
      //           )

      //           ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await HomePage.loadData(true);
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              // SliverAppBar(
              //   floating: true,
              //   elevation: 0,
              //   centerTitle: false,
              //   automaticallyImplyLeading: false,
              //   backgroundColor: Theme.of(context).highlightColor,
              //   title: Image.asset(Images.logoWithNameImage, height: 50),
              //   toolbarHeight: 80,
              //   actions: [
              //     Consumer<ProfileController>(builder: (context, profile, _) {
              //       if (profile.userInfoModel == null) {
              //         return GestureDetector(
              //           onTap: () {
              //             Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (context) => const LoginScreen()));
              //           },
              //           child: Row(
              //             mainAxisSize: MainAxisSize.min,
              //             spacing: 4,
              //             children: [
              //               Text(getTranslated('sign_in', context)!,
              //                   style: const TextStyle(
              //                       color: Colors.black, fontSize: 16)),
              //               const Icon(Icons.person_outline,
              //                   color: Colors.black),
              //             ],
              //           ),
              //         );
              //       }
              //       return Row(
              //         children: [
              //           !isGuestMode
              //               ? SizedBox(
              //             width: 100,
              //             child: Text(
              //               "${profile.userInfoModel?.fName}",
              //               maxLines: 1,
              //               overflow: TextOverflow.ellipsis,
              //               style: const TextStyle(
              //                 fontWeight: FontWeight.w600,
              //                 color: Colors.black,
              //               ),
              //             ),
              //           )
              //               : const Icon(Icons.person_outline,
              //               color: Colors.black),
              //
              //           const SizedBox(width: 8),
              //           InkWell(
              //             onTap: (){
              //               Navigator.push(
              //                   context,
              //                   MaterialPageRoute(
              //                       builder: (context) =>
              //                       const CartScreen()));
              //             },
              //             child: Stack(
              //               clipBehavior: Clip.none,
              //               children: [
              //                 Icon(Icons.shopping_cart_outlined,
              //                     color: Theme.of(context).primaryColor),
              //                 Positioned(
              //                   right: 0,
              //                   top: 0,
              //                   child: Container(
              //                     padding: const EdgeInsets.all(2),
              //                     decoration: const BoxDecoration(
              //                       color: Colors.orange,
              //                       shape: BoxShape.circle,
              //                     ),
              //                     child: const Text(
              //                       "",
              //                       style: TextStyle(
              //                         color: Colors.white,
              //                         fontSize: 12,
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //           const SizedBox(width: 8),
              //         ],
              //       );
              //     }),
              //   ],
              // ),
              SliverAppBar(
                floating: true,
                pinned: true,
                elevation: 0,
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context).highlightColor,
                toolbarHeight: 80,
                title: Consumer<ProfileController>(
                  builder: (context, profile, _) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Expanded(child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(Images.logoWithNameImage),
                        )),

                        const SizedBox(width: 12),

                        Expanded(
                          child: profile.userInfoModel == null
                              ? Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const LoginScreen(),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    getTranslated('sign_in', context)!,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(Icons.person_outline, color: Colors.black),
                                ],
                              ),
                            ),
                          )

                              : Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              Flexible(
                                child: Text(
                                  "${profile.userInfoModel?.fName}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 12),


                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const CartScreen(),
                                    ),
                                  );
                                },
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Icon(
                                      Icons.shopping_cart_outlined,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    Positioned(
                                      right: -6,
                                      top: -6,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(
                                          color: Colors.orange,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Text(
                                          '',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              SliverToBoxAdapter(
                  child: Provider.of<SplashController>(context, listen: false)
                              .configModel!
                              .announcement!
                              .status ==
                          '1'
                      ? Consumer<SplashController>(
                          builder: (context, announcement, _) {
                          return (announcement.configModel!.announcement!
                                          .announcement !=
                                      null &&
                                  announcement.onOff)
                              ? AnnouncementWidget(
                                  announcement:
                                      announcement.configModel!.announcement)
                              : const SizedBox();
                        })
                      : const SizedBox()),
              SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverDelegate(
                    child: InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SearchScreen())),
                      child: const Hero(
                          tag: 'search',
                          child: Material(child: SearchHomePageWidget())),
                    ),
                  )),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    const BannersWidget(),
                    const SizedBox(height: Dimensions.paddingSizeDefault),

                    const CategoryListWidget(isHomePage: true),
                    const SizedBox(height: Dimensions.paddingSizeDefault),

                    Consumer<FlashDealController>(
                        builder: (context, megaDeal, child) {
                      return megaDeal.flashDeal == null
                          ? const FlashDealShimmer()
                          : megaDeal.flashDealList.isNotEmpty
                              ? Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.paddingSizeDefault),
                                    child: TitleRowWidget(
                                      title:
                                          getTranslated('flash_deal', context)
                                              ?.toUpperCase(),
                                      eventDuration: megaDeal.flashDeal != null
                                          ? megaDeal.duration
                                          : null,
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    const FlashDealScreenView()));
                                      },
                                      isFlash: true,
                                    ),
                                  ),
                                  const SizedBox(
                                      height: Dimensions.paddingSizeSmall),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.paddingSizeDefault),
                                    child: Text(
                                      getTranslated(
                                              'hurry_up_the_offer_is_limited_grab_while_it_lasts',
                                              context) ??
                                          '',
                                      style: textRegular.copyWith(
                                          color: Provider.of<ThemeController>(
                                                      context,
                                                      listen: false)
                                                  .darkTheme
                                              ? Theme.of(context).hintColor
                                              : Theme.of(context).primaryColor,
                                          fontSize: Dimensions.fontSizeDefault),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(
                                      height: Dimensions.paddingSizeSmall),
                                  const FlashDealsListWidget()
                                ])
                              : const SizedBox.shrink();
                    }),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                    Consumer<FeaturedDealController>(
                        builder: (context, featuredDealProvider, child) {
                      return featuredDealProvider.featuredDealProductList !=
                              null
                          ? featuredDealProvider
                                  .featuredDealProductList!.isNotEmpty
                              ? Column(
                                  children: [
                                    Stack(children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 150,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onTertiary,
                                      ),
                                      Column(children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: Dimensions
                                                  .paddingSizeDefault),
                                          child: TitleRowWidget(
                                            title:
                                                '${getTranslated('featured_deals', context)}',
                                            onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        const FeaturedDealScreenView())),
                                          ),
                                        ),
                                        const FeaturedDealsListWidget(),
                                      ]),
                                    ]),
                                    const SizedBox(
                                        height: Dimensions.paddingSizeDefault),
                                  ],
                                )
                              : const SizedBox.shrink()
                          : const FindWhatYouNeedShimmer();
                    }),

                    const ClearanceListWidget(),
                    const SizedBox(height: Dimensions.paddingSizeDefault),

                    Consumer<BannerController>(
                        builder: (context, footerBannerProvider, child) {
                      return footerBannerProvider.footerBannerList != null &&
                              footerBannerProvider.footerBannerList!.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeDefault),
                              child: SingleBannersWidget(
                                  bannerModel: footerBannerProvider
                                      .footerBannerList?[0]))
                          : const SizedBox();
                    }),
                    const SizedBox(height: Dimensions.paddingSizeDefault),

                    Consumer<ProductController>(
                        builder: (context, productController, _) {
                      return const FeaturedProductWidget();
                    }),
                    const SizedBox(height: Dimensions.paddingSizeDefault),

                    // singleVendor? const SizedBox() :
                    // Consumer<ShopController>(
                    //   builder: (context, topSellerProvider, child) {
                    //     return (topSellerProvider.sellerModel != null && (topSellerProvider.sellerModel!.sellers!=null && topSellerProvider.sellerModel!.sellers!.isNotEmpty))?
                    //     TitleRowWidget(title: getTranslated('top_seller', context),
                    //         onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) =>
                    //         const AllTopSellerScreen( title: 'top_stores',)))):
                    //     const SizedBox();
                    //   }),
                    singleVendor
                        ? const SizedBox(height: 0)
                        : const SizedBox(height: Dimensions.paddingSizeSmall),

                    // singleVendor ? const SizedBox() :
                    // Consumer<ShopController>(
                    //     builder: (context, topSellerProvider, child) {
                    //       return (topSellerProvider.sellerModel != null && (topSellerProvider.sellerModel!.sellers!=null && topSellerProvider.sellerModel!.sellers!.isNotEmpty))?
                    //       Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                    //           child: SizedBox(height: ResponsiveHelper.isTab(context)? 170 : 165, child: TopSellerView(isHomePage: true, scrollController: _scrollController,))):const SizedBox();}),

                    // const Padding(padding: EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                    //     child: RecommendedProductWidget()),

                    const Padding(
                        padding: EdgeInsets.only(
                            bottom: Dimensions.paddingSizeDefault),
                        child: LatestProductListWidget()),

                    // if(configModel?.brandSetting == "1") TitleRowWidget(
                    //   title: getTranslated('brand', context),
                    //   onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BrandsView())),
                    // ),

                    SizedBox(
                        height: configModel?.brandSetting == "1"
                            ? Dimensions.paddingSizeSmall
                            : 0),

                    if (configModel!.brandSetting == "1") ...[
                      const BrandListWidget(isHomePage: true),
                      const SizedBox(height: Dimensions.paddingSizeDefault),
                    ],

                    const HomeCategoryProductWidget(isHomePage: true),
                    const SizedBox(height: Dimensions.paddingSizeDefault),

                    // const FooterBannerSliderWidget(),
                    const SizedBox(height: Dimensions.paddingSizeDefault),

                    Consumer<ProductController>(
                        builder: (ctx, prodProvider, child) {
                      return Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        Dimensions.paddingSizeDefault,
                                        0,
                                        Dimensions.paddingSizeSmall,
                                        0),
                                    child: Row(children: [
                                      Expanded(
                                          child: Text(
                                              prodProvider.title == 'xyz'
                                                  ? getTranslated(
                                                      'new_arrival', context)!
                                                  : prodProvider.title!,
                                              style: titleHeader)),
                                      prodProvider.latestProductList != null
                                          ? PopupMenuButton(
                                              padding: const EdgeInsets.all(0),
                                              itemBuilder: (context) {
                                                return [
                                                  PopupMenuItem(
                                                    value:
                                                        ProductType.newArrival,
                                                    child: Text(
                                                        getTranslated(
                                                                'new_arrival',
                                                                context) ??
                                                            '',
                                                        style: textRegular
                                                            .copyWith(
                                                          color: prodProvider
                                                                      .productType ==
                                                                  ProductType
                                                                      .newArrival
                                                              ? Theme.of(
                                                                      context)
                                                                  .primaryColor
                                                              : Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge
                                                                  ?.color,
                                                        )),
                                                  ),
                                                  PopupMenuItem(
                                                    value:
                                                        ProductType.topProduct,
                                                    child: Text(
                                                        getTranslated(
                                                                'top_product',
                                                                context) ??
                                                            '',
                                                        style: textRegular
                                                            .copyWith(
                                                          color: prodProvider
                                                                      .productType ==
                                                                  ProductType
                                                                      .topProduct
                                                              ? Theme.of(
                                                                      context)
                                                                  .primaryColor
                                                              : Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge
                                                                  ?.color,
                                                        )),
                                                  ),
                                                  PopupMenuItem(
                                                    value:
                                                        ProductType.bestSelling,
                                                    child: Text(
                                                        getTranslated(
                                                                'best_selling',
                                                                context) ??
                                                            '',
                                                        style: textRegular
                                                            .copyWith(
                                                          color: prodProvider
                                                                      .productType ==
                                                                  ProductType
                                                                      .bestSelling
                                                              ? Theme.of(
                                                                      context)
                                                                  .primaryColor
                                                              : Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge
                                                                  ?.color,
                                                        )),
                                                  ),
                                                  PopupMenuItem(
                                                    value: ProductType
                                                        .discountedProduct,
                                                    child: Text(
                                                        getTranslated(
                                                                'discounted_product',
                                                                context) ??
                                                            '',
                                                        style: textRegular
                                                            .copyWith(
                                                          color: prodProvider
                                                                      .productType ==
                                                                  ProductType
                                                                      .discountedProduct
                                                              ? Theme.of(
                                                                      context)
                                                                  .primaryColor
                                                              : Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge
                                                                  ?.color,
                                                        )),
                                                  ),
                                                ];
                                              },
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius
                                                      .circular(Dimensions
                                                          .paddingSizeSmall)),
                                              child: Padding(
                                                  padding: const EdgeInsets
                                                      .fromLTRB(
                                                      Dimensions
                                                          .paddingSizeExtraSmall,
                                                      Dimensions
                                                          .paddingSizeSmall,
                                                      Dimensions
                                                          .paddingSizeExtraSmall,
                                                      Dimensions
                                                          .paddingSizeSmall),
                                                  child: Image.asset(
                                                      Images.dropdown,
                                                      scale: 3)),
                                              onSelected: (ProductType value) {
                                                if (value ==
                                                    ProductType.newArrival) {
                                                  Provider.of<ProductController>(
                                                          context,
                                                          listen: false)
                                                      .changeTypeOfProduct(
                                                          value, types[0]);
                                                } else if (value ==
                                                    ProductType.topProduct) {
                                                  Provider.of<ProductController>(
                                                          context,
                                                          listen: false)
                                                      .changeTypeOfProduct(
                                                          value, types[1]);
                                                } else if (value ==
                                                    ProductType.bestSelling) {
                                                  Provider.of<ProductController>(
                                                          context,
                                                          listen: false)
                                                      .changeTypeOfProduct(
                                                          value, types[2]);
                                                } else if (value ==
                                                    ProductType
                                                        .discountedProduct) {
                                                  Provider.of<ProductController>(
                                                          context,
                                                          listen: false)
                                                      .changeTypeOfProduct(
                                                          value, types[3]);
                                                }
                                                //  Provider.of<ProductController>(context, listen: false).getLatestProductList(1, reload: true);
                                              },
                                            )
                                          : const SizedBox()
                                    ])),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.paddingSizeSmall),
                                    child: ProductListWidget(
                                        isHomePage: false,
                                        productType: ProductType.newArrival,
                                        scrollController: _scrollController)),
                                const SizedBox(
                                    height: Dimensions.homePagePadding)
                              ]));
                    }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  double height;

  SliverDelegate({required this.child, this.height = 70});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != height ||
        oldDelegate.minExtent != height ||
        child != oldDelegate.child;
  }
}
