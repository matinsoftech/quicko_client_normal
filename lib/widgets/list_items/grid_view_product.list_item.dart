import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/models/product.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/widgets/custom_image.view.dart';
import 'package:fuodz/widgets/states/product_stock.dart';
import 'package:velocity_x/velocity_x.dart';

class GridViewProductListItem extends StatelessWidget {
  const GridViewProductListItem({
    this.product,
    this.onPressed,
    @required this.qtyUpdated,
    this.showStepper = false,
    Key key,
  }) : super(key: key);

  final Function(Product) onPressed;
  final Function(Product, int) qtyUpdated;
  final Product product;
  final bool showStepper;
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //
        Stack(
          children: [
            //product image
            Hero(
              tag: product.heroTag,
              child: CustomImage(
                imageUrl: product.photo,
                boxFit: BoxFit.cover,
                width: double.infinity,
                height: Vx.dp64 * 1.5,
              ),
            ),

            //price
            Positioned(
              bottom: 0,
              right: 0,
              child: HStack(
                [
                  AppStrings.currencySymbol.text.xs.white.make(),
                  product.showDiscount
                      ? "${product.price}"
                          .text
                          .xs
                          .lineThrough
                          .white
                          .make()
                          .px2()
                      : "${product.price}".text.sm.white.make(),
                  // discount price
                  product.showDiscount
                      ? "${product.discountPrice}".text.sm.white.make()
                      : UiSpacer.emptySpace(),
                ],
              ).py4().box.px8.rounded.color(AppColor.primaryColor).make(),
            ),
          ],
        ),

        //
        VStack(
          [
            product.name.text.semiBold.sm
                .maxLines(1)
                .overflow(TextOverflow.ellipsis)
                .make(),
            product.vendor.name.text.xs
                .maxLines(1)
                .overflow(TextOverflow.ellipsis)
                .make(),

            // plus/min icon here
            showStepper
                ? ProductStockState(product, qtyUpdated: qtyUpdated)
                : UiSpacer.emptySpace(),
          ],
        ).p8(),
      ],
    )
        .box
        .roundedSM
        .color(AppColor.accentColor.withOpacity(0.06))
        .clip(Clip.antiAlias)
        .outerShadowSm
        // .shadowOutline(
        //   outlineColor: AppColor.accentColor.withOpacity(0.001),
        // )
        .makeCentered()
        .onInkTap(
          () => this.onPressed(this.product),
        );
  }
}
