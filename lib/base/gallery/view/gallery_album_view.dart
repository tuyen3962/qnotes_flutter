import 'package:flutter/material.dart';
import 'package:qnotes_flutter/base/gallery/gallery_manager.dart';
import 'package:qnotes_flutter/base/gallery/view/gallery_asset_view.dart';
import 'package:qnotes_flutter/config/theme/style/style_theme.dart';
import 'package:qnotes_flutter/extension.dart';

class GalleryAlbumView extends StatefulWidget {
  const GalleryAlbumView({
    super.key,
    this.assetPaths = const [],
  });

  final List<GalleryAssetPath> assetPaths;

  @override
  State<GalleryAlbumView> createState() => _GalleryAlbumViewState();
}

class _GalleryAlbumViewState extends State<GalleryAlbumView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding(all: 12),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.9,
      child: Column(children: [
        Text('Danh sách album ảnh',
            style: StyleThemeData.styleSize16Weight700()),
        SizedBox(height: 12.h),
        Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) =>
                    _buildAssetPathView(widget.assetPaths[index]),
                separatorBuilder: (context, index) => SizedBox(height: 12.h),
                itemCount: widget.assetPaths.length))
      ]),
    );
  }

  Widget _buildAssetPathView(GalleryAssetPath assetPath) {
    return GestureDetector(
      onTap: () => Navigator.pop(context, assetPath.pathEntity?.id),
      child: Row(
        children: [
          GalleryAssetView(
            radius: 12.w,
            boxFit: BoxFit.fill,
            galleryAsset: assetPath.assets.first,
            size: 100.w,
            showVideoDuration: false,
          ),
          SizedBox(width: 12),
          Expanded(
              child: Text(
                  '${assetPath.pathEntity?.name ?? ''} (${assetPath.totalAsset})',
                  style: StyleThemeData.styleSize14Weight600()))
        ],
      ),
    );
  }
}
