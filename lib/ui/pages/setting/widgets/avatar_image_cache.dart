import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/common/app_images.dart';

class AvatarImageCache extends StatelessWidget {
  final String url;
  const AvatarImageCache({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    log(url);

    return CircleAvatar(
      radius: 60,
      child: ClipOval(
        child: CachedNetworkImage(
          width: 120,
          height: 120,
          fit: BoxFit.cover,
          imageUrl: url,
          placeholder: (context, url) => Center(
            child: SizedBox(
              height: 60,
              width: 60,
              child: CircularProgressIndicator(),
            ),
          ),
          errorWidget: (context, url, error) =>
              Image.asset(AppImages.defaultProfile, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
