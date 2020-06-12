import 'package:base_library/base_library.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start/model/protocol/home_models.dart';
import 'package:flutter_start/widget/widgets.dart';

///主页
class HomePage extends StatelessWidget {
  Widget buildBanner(BuildContext context, List<BannerModel> bannerList) {
    if (ObjectUtil.isEmpty(bannerList)) {
      //列表为空
      return Container(height: 0.0);
    }
    return AspectRatio(aspectRatio: 16 / 9,
      child: Swiper(
        children: bannerList.map((item) {
          return new InkWell(
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: item.imagePath,
              placeholder: (context, url) {
                return ProgressView();
              },
              errorWidget: (context, url, obj) => Icon(Icons.error),
            ),
          );
        }).toList(),
      ),);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[],
    );
  }
}
