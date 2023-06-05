import 'package:flutter/material.dart';
import 'package:fuodz/models/category.dart';
import 'package:fuodz/widgets/custom_image.view.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({this.category, this.onPressed, Key key})
      : super(key: key);

  final Function(Category) onPressed;
  final Category category;
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //
        CustomImage(
          imageUrl: category.imageUrl,
          boxFit: BoxFit.contain,
          width: Vx.dp48,
          height: Vx.dp48,
        ).p8().centered().box.color(context.cardColor).outerShadow.roundedSM.clip(Clip.antiAlias).make(),
        //
        category.name.text.medium.lg
            .maxLines(1)
            .overflow(TextOverflow.ellipsis)
            .makeCentered().p2().w(Vx.dp56 * 1.5),
      ],
      crossAlignment: CrossAxisAlignment.center,
    ).onInkTap(
      () => this.onPressed(this.category),
    );
  }
}
