import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/home.i18n.dart';

class VendorHeader extends StatefulWidget {
  const VendorHeader({
    Key key,
    this.model,
  }) : super(key: key);

  final MyBaseViewModel model;

  @override
  _VendorHeaderState createState() => _VendorHeaderState();
}

class _VendorHeaderState extends State<VendorHeader> {
  @override
  void initState() {
    super.initState();
    //
    if (widget.model.deliveryaddress.address == "Current Location") {
      widget.model.fetchCurrentLocation();
    }
  }


  @override
  Widget build(BuildContext context) {
    return HStack(
      [
        //
        HStack(
          [
            //location icon
            Icon(
              FlutterIcons.location_pin_sli,
              // size: 16,
            ).onInkTap(
              widget.model.useUserLocation,
            ),

            //
            VStack(
              [
                //
                HStack(
                  [
                    //
                    "Delivery Location".i18n.text.lg.semiBold.make(),
                    //
                    Icon(
                      FlutterIcons.chevron_down_fea,
                    ).px4(),
                  ],
                ),
                widget.model.deliveryaddress.address.text.sm.make(),
              ],
            )
                .onInkTap(
                  widget.model.pickDeliveryAddress,
                )
                .px12()
                .expand(),
          ],
        ).expand(),

        //
        Icon(
          FlutterIcons.search1_ant,
          size: 16,
          color: Colors.white,
        )
            .p8()
            .box
            .roundedFull
            .shadowSm
            .color(context.theme.accentColor)
            .make()
            .onInkTap(
              widget.model.openSearch,
            ),
      ],
    ).p12();
  }
}
