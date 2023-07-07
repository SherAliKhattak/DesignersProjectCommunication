import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// when user clicks on an image it will display in a new screen
class ImageViewer extends StatelessWidget {
  final String imageUrl;
  const ImageViewer({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(
        centerTitle: true,
        
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: (() => Get.back()),
        ),
      ),
      body: Center(
        child: CachedNetworkImage(imageUrl: imageUrl),
      ),
    );
  }
}
