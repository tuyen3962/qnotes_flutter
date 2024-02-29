import 'package:base_flutter_source/base/widget/base_controller.dart';
import 'package:base_flutter_source/screen/preview_image/preview_image_page.dart';
import 'package:base_flutter_source/screen/preview_image/preview_image_parameter.dart';

class PreviewImageController extends BaseController<PreviewImagePageState> {
  final PreviewImageParameter parameter;

  PreviewImageController(super.state, {required this.parameter});
}
