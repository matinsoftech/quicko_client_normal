import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/vendor.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/widgets/buttons/route.button.dart';
import 'package:fuodz/widgets/custom_image.view.dart';
import 'package:fuodz/widgets/tags/delivery.tag.dart';
import 'package:fuodz/widgets/tags/pickup.tag.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/vendor/top_vendor.i18n.dart';

class VendorListItem extends StatelessWidget {
  const VendorListItem({
    this.vendor,
    this.onPressed,
    Key key,
  }) : super(key: key);

  final Vendor vendor;
  final Function(Vendor) onPressed;
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //
        Stack(
          children: [
            //
            Hero(
              tag: vendor.heroTag,
              child: CustomImage(
                imageUrl: vendor.featureImage,
                height: 120,
                width: context.screenWidth,
              ),
            ),
            //location routing
            (!vendor.latitude.isEmptyOrNull && !vendor.longitude.isEmptyOrNull)
                ? Positioned(
                    child: RouteButton(vendor),
                    bottom: 10,
                    right: 10,
                  )
                : UiSpacer.emptySpace(),

            //closed
            Positioned(
              child: Visibility(
                visible: !vendor.isOpen,
                child: VxBox(
                  child: "Closed".i18n.text.xl2.white.bold.makeCentered(),
                )
                    .color(
                      AppColor.closeColor.withOpacity(0.6),
                    )
                    .make(),
              ),
              bottom: 0,
              right: 0,
              left: 0,
              top: 0,
            ),
          ],
        ),

        //
        //
        HStack(
          [
            VStack(
              [
                //name
                vendor.name.text.xl.medium
                    .maxLines(1)
                    .overflow(TextOverflow.ellipsis)
                    .make(),
                //description
                Wrap(
                  children: [
                    //rating
                    "${vendor.rating.numCurrency} "
                        .text
                        .color(AppColor.ratingColor)
                        .medium
                        .make(),
                    Icon(
                      FlutterIcons.star_ent,
                      color: AppColor.ratingColor,
                      size: 16,
                    ),

                    //
                    UiSpacer.horizontalSpace(),
                    //
                    Visibility(
                      visible: vendor.distance != null,
                      child: Wrap(
                        children: [
                          Icon(
                            FlutterIcons.direction_ent,
                            color: AppColor.primaryColor,
                            size: 16,
                          ),
                          " ${vendor?.distance?.numCurrency}km".text.make(),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ).p8().expand(),
            //tags
            VStack(
              [
                //
                UiSpacer.horizontalSpace(),
                Visibility(
                  visible: vendor.minOrder != null,
                  child: "Min. ${AppStrings.currencySymbol}${vendor.minOrder}"
                      .text
                      .sm
                      .coolGray600
                      .make(),
                ),
                UiSpacer.horizontalSpace(),
                Visibility(
                  visible: vendor.maxOrder != null,
                  child: "Max. ${AppStrings.currencySymbol}${vendor.maxOrder}"
                      .text
                      .sm
                      .coolGray600
                      .make(),
                ),
              ],
              crossAlignment: CrossAxisAlignment.end,
            ).p8(),
          ],
        ),
        //
        HStack(
          [
            //can deliver
            vendor.delivery == 1
                ? DeliveryTag().pOnly(right: 10)
                : UiSpacer.emptySpace(),

            //can pickup
            vendor.pickup == 1
                ? PickupTag().pOnly(right: 10)
                : UiSpacer.emptySpace(),
          ],
          crossAlignment: CrossAxisAlignment.end,
        ).p8()
      ],
    )
        .onInkTap(
          () => this.onPressed(this.vendor),
        )
        .wThreeForth(context)
        .card
        .clip(Clip.antiAlias)
        .roundedSM
        .make();
  }
}
