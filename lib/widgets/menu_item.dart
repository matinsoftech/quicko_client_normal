import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:velocity_x/velocity_x.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    this.title,
    this.child,
    this.divider = true,
    this.topDivider = false,
    this.suffix,
    this.onPressed,
    this.prefix = true,
    this.iconData,
    Key key,
  }) : super(key: key);

  //
  final String title;
  final Widget child;
  final bool divider;
  final bool topDivider;
  final Widget suffix;
  final Function onPressed;
  final bool prefix;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //
        topDivider
            ? Divider(
                height: 1,
                thickness: 2,
              )
            : SizedBox.shrink(),

        //
        HStack(
          [
            prefix ?
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Icon(
                    iconData,
                    size: 16,
                    color: Colors.white,
                  ),
                ) : SizedBox.shrink(),

            (child ?? title.text.lg.light.make()).pOnly(left: 10).expand(),

            suffix ??
                Icon(
                  FlutterIcons.right_ant,
                  size: 22,
                  color: AppColor.primaryColor,
                ),
          ],
        ).py8().px8(),

        //
        divider
            ? Divider(
                height: 1,
                thickness: 2,
              )
            : SizedBox.shrink(),
      ],
    ).wFull(context)
        .box
        .border(color: Theme.of(context).cardColor)
        .color(Theme.of(context).cardColor)
        .shadow
        .roundedLg
        .margin(EdgeInsets.all(10))
        .make()
        .onInkTap(onPressed);
  }
}
