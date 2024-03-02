import 'package:qnotes_flutter/base/widget/base_controller.dart';
import 'package:qnotes_flutter/screen/preview_image/preview_image_page.dart';
import 'package:qnotes_flutter/screen/preview_image/preview_image_parameter.dart';

class PreviewImageController extends BaseController<PreviewImagePageState> {
  final PreviewImageParameter parameter;

  PreviewImageController(super.state, {required this.parameter});
}
