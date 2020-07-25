import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screen_decor/models/photo_model.dart';

class ImageDetail extends StatefulWidget {
  final PhotoModel photoModel;

  const ImageDetail({Key key, this.photoModel}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ImageDetailState();
  }
}

class ImageDetailState extends State<ImageDetail> {
  PhotoModel photoModel;
  @override
  void initState() {
    photoModel = widget.photoModel;
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: photoModel.id,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: CachedNetworkImage(
            height: MediaQuery.of(context).size.height * 0.3,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
                  .withOpacity(0.5),
            ),
            imageUrl: photoModel.urls.regular,
          ),
        ),
      ),
    );
  }
}
