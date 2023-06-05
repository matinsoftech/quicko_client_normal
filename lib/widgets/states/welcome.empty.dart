import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fuodz/constants/api.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/services/auth.service.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/welcome.vm.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:fuodz/widgets/list_items/vendor_type.list_item.dart';
import 'package:fuodz/widgets/list_items/vendor_type.vertical_list_item.dart';
import 'package:fuodz/widgets/states/commingsoon.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/welcome.i18n.dart';

import '../ride_option.dart';

class EmptyWelcome extends StatelessWidget {
  const EmptyWelcome({this.vm, Key key}) : super(key: key);

  final WelcomeViewModel vm;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.10,
        title: Center(
            child: Image.asset("assets/images/quicko_text.png")
        ),
        backgroundColor: AppColor.primaryColor,
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade300,
      body: VStack(
        [
          VxBox(
            child: SafeArea(
              child: VStack(
                [
                  ("Welcome".i18n +
                      (vm.isAuthenticated()
                          ? " ${AuthServices.currentUser?.name ?? ''}"
                          : ""))
                      .text
                      .white
                      .xl
                      .semiBold
                      .make(),
                  SizedBox(height: 6,),
                  "How can I help you?".i18n.text.white.xl.medium.make(),
                  //       HStack(
                  //   [
                  //     // "I want to:".i18n.text.xl.medium.make().expand(),
                  //     // Icon(
                  //     //   vm.showGrid ? FlutterIcons.grid_fea : FlutterIcons.list_fea,
                  //     // ).p2().onInkTap(() {
                  //     //   vm.showGrid = !vm.showGrid;
                  //     //   vm.notifyListeners();
                  //     // }),
                  //   ],
                  //   crossAlignment: CrossAxisAlignment.center,
                  // ).py4(),
                  //list view
                  SizedBox(height: 15,),
                  !vm.showGrid
                      ? CustomListView(
                    noScrollPhysics: true,
                    dataSet: vm.vendorTypes,
                    isLoading: vm.isBusy,
                    itemBuilder: (context, index) {
                      final vendorType = vm.vendorTypes[index];
                      return VendorTypeListItem(
                        vendorType,
                        onPressed: () {
                          vm.pageSelected(vendorType);
                        },
                      );
                    },
                    separatorBuilder: (context, index) =>
                        UiSpacer.emptySpace(),
                  )
                      : (vm.isBusy
                        ? BusyIndicator().centered()
                        : AnimationLimiter(
                          child: MasonryGrid(
                            column: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 3.2,
                            children: List.generate(
                              vm.vendorTypes.length ?? 0,
                                  (index) {
                                final vendorType = vm.vendorTypes[index];
                                // print(vendorType.logo);
                                // String imageUrl = "https://quicko.matinsoftech.com" + vendorType.logo.split(".com").last;
                                return vendorType.id == 6 ? SizedBox() : GestureDetector(
                                  onTap: () {
                                    // if(vendorType.id == 1) {
                                    //   Navigator.of(context).push(MaterialPageRoute(builder: (_) => ComingSoon()));
                                    // } else {
                                      vm.pageSelected(vendorType);

                                    // }
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: Colors.white,
                                        ),
                                        padding: const EdgeInsets.all(10),
                                        child: Image.asset(
                                          vendorType.id == 5 ? "assets/images/packages.png" : vendorType.id == 2 ? "assets/images/food_delivery.png" : vendorType.id == 9 ? "assets/images/book.png"  : vendorType.id == 7 ? "assets/images/services.png" : vendorType.id == 8 ? "assets/images/commerce.png" :  "assets/images/parcel_delivery.png",

                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      SizedBox(
                                        height: 20,
                                        child: Text(
                                          vendorType.name,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  ),
                                );
                                // return VendorTypeVerticalListItem(
                                //   vendorType,
                                //   onPressed: () {
                                //     String commingsoon =
                                //         vm.vendorTypes[index].name;
                                //     if (commingsoon == "Taxi Booking") {
                                //       vm.pageSelected(vendorType);
                                //     } else {
                                //       Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //             builder: (context) =>
                                //                 ComingSoon()),
                                //       );
                                //     }
                                //   },
                                // );
                              },
                            ),
                          ),
                        )
                      )
                      // .py4(),
                  // .py1(),

                ],
              )
                  // .py12(),
            ),
          ).color(AppColor.primaryColor).customRounded(BorderRadius.circular(12)).p16.margin(EdgeInsets.all(10).copyWith(bottom: 0)).make().wFull(context),
          //
          const SizedBox(height: 20,),
          VStack(
            [
              CarouselSlider(
                items: [
                  ClipRRect(
                    child: Image.asset('assets/images/banner1.jpeg',),
                    borderRadius: BorderRadius.circular(12),
                    clipBehavior: Clip.antiAlias,
                  ),
                  ClipRRect(
                    child: Image.asset('assets/images/banner2.jpg',),
                    borderRadius: BorderRadius.circular(12),
                    clipBehavior: Clip.antiAlias,
                  ),
                ],
                options: CarouselOptions(
                  height: 185,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  viewportFraction: 1,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  pauseAutoPlayOnTouch: true,
                  // aspectRatio: 1.8,
                ),
              ),
              // list view

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.only(top: 20, right: 10, left: 10),
                padding: const EdgeInsets.all(20),
                child: MasonryGrid(
                  column: 1,
                  crossAxisSpacing: 10,
                  children: List.generate(
                    vm.vendorTypes.length ?? 0,
                        (index) {
                      final vendorType = vm.vendorTypes[index];
                      String commingsoon = vm.vendorTypes[index].name;
                      if (commingsoon == "Taxi Booking") {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Center(
                                child: Text(
                                  'Book Your Ride',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.primaryColor
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            GridView.count(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              childAspectRatio: 1.4,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    vm.pageSelected(vendorType);
                                    //     NavigationService.pageSelected(vendorType,
                                    // context: context);
                                    //
                                  },
                                  child: RideOption(
                                    image: 'assets/images/car.png',
                                    title: 'Car',
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    vm.pageSelected(vendorType);
                                    //     NavigationService.pageSelected(vendorType,
                                    // context: context);
                                  },
                                  child: RideOption(
                                    image: 'assets/images/bike.png',
                                    title: 'Bike',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                        //        return VendorTypeVerticalListItem(
                        //   vendorType,
                        //   onPressed: () {
                        //       print("check$vendorType");
                        //     String commingsoon = vm.vendorTypes[index].name;
                        //     if (commingsoon == "Taxi Booking") {
                        // NavigationService.pageSelected(vendorType,
                        //     context: context);
                        //     } else {
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) =>
                        //                 ComingSoon()),
                        //       );
                        //     }
                        //   },
                        // );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ),
            ],
          ).p2(),
        ],
      ).scrollVertical(),
    );
  }
}
