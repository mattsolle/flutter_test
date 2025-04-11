import 'dart:convert';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../assets.dart';

extension ImageProviderExtension on String {
  ImageProvider? get toImageProviderOrNull {
    if (isEmpty) {
      return null;
    }

    return toImageProvider;
  }

  static const supportedTypes = [
    'jpg',
    'jpeg',
    'png',
    'webp',
    'avif',
  ];

  ImageProvider get toImageProvider {
    final isNetworkImage = startsWith('http') || startsWith('https');
    final imageExtension = split('.').last;
    final supportedImageType = supportedTypes.contains(imageExtension);

    try {
      if (isNetworkImage && supportedImageType) {
        return CachedNetworkImageProvider(this);
      }

      if (Assets.values.contains(this)) {
        return AssetImage(this);
      }

      throw UnimplementedError('Image type not supported');
    } catch (e) {
      // TODO(boginni): Log error

      return const AssetImage(Assets.placeHolder);
    }
  }
}

extension ImageProviderOrNullExtension on String? {
  ImageProvider? get toImageProviderOrNull {
    if (this == null) {
      return null;
    }

    return this!.toImageProvider;
  }
}

extension DefaultImageExtension on ImageProvider? {
  static final Uint8List _transparentImageBytes = base64Decode(
    'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1'
    'HAwCAAAAC0lEQVR42mNk+A8AAUkBH+0k+D4AAAAASUVORK5CYII=',
  );

  ImageProvider get orDefaultImage {
    if (this == null) {
      return const AssetImage(Assets.placeHolder);
    }

    return this!;
  }

  ImageProvider get orEmptyImage {
    if (this == null) {
      return MemoryImage(_transparentImageBytes);
    }

    return this!;
  }
}
