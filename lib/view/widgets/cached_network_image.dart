import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

extension ImageExtension on num {
  int cacheSize(BuildContext context) {
    return (this * MediaQuery.of(context).devicePixelRatio).round();
  }
}

class CustomImageNetwork extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final BoxFit boxFit;
  final int? placeHolderHeight;
  final int? placeHolderWidth;

  const CustomImageNetwork({
    super.key,
    required this.url,
    required this.width,
    required this.height,
    required this.boxFit,
    this.placeHolderHeight,
    this.placeHolderWidth,
  });

  @override
  Widget build(BuildContext context) {
    int? cacheWidth, cacheHeight;
    Size targetSize = Size(width, height);

    cacheHeight = targetSize.height.cacheSize(context);

    cacheWidth = targetSize.width.cacheSize(context);

    return CachedNetworkImage(
      maxWidthDiskCache: cacheWidth,
      maxHeightDiskCache: cacheHeight,
      imageUrl: url,
      width: width,
      height: height,
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: boxFit),
          ),
        );
      },
      placeholder: (context, url) => Image.asset(
        '',
        height: height,
        width: width,
      ),
      errorWidget: (context, url, error) => Image.asset(
        '',
        height: height,
        width: width,
      ),
    );
  }
}
