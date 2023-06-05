import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_images.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomImage extends StatelessWidget {
  const CustomImage(
      {this.imageUrl, this.height = Vx.dp40, this.width, this.boxFit, this.vehicleType, Key key})
      : super(key: key);

  final String imageUrl;
  final double height;
  final double width;
  final BoxFit boxFit;
  final String vehicleType;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: this.imageUrl,
      errorWidget: (context, imageUrl, _) => Image.asset(
        vehicleType == "Car" ? "assets/images/car.png" : "assets/images/bike.png",
        fit: this.boxFit ?? BoxFit.contain,
      ),
      fit: this.boxFit ?? BoxFit.cover,
      progressIndicatorBuilder: (context, imageURL, progress) =>
          BusyIndicator().centered(),
    ).h(this.height).w(this.width ?? context.percentWidth);
  }
}
