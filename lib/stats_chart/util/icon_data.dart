part of "../../nti_chart.dart";

abstract class ImageData {
  const ImageData();
  Widget getImageWidget();

  factory ImageData.icon(Icon icon) => IconImageData(icon);

  factory ImageData.asset(
          {required String path, double? height, double? width}) =>
      ImageImageData(
          path: path,
          imageSource: ImageSource.asset,
          height: height,
          width: width);

  factory ImageData.network(
          {required String path, double? height, double? width}) =>
      ImageImageData(
          path: path,
          imageSource: ImageSource.network,
          width: width,
          height: height);

  factory ImageData.widget(Widget widget) => WidgetImageData(widget);
}

enum ImageSource { asset, network }

class IconImageData extends ImageData {
  final Icon icon;

  const IconImageData(this.icon);

  @override
  Widget getImageWidget() => icon;
}

class ImageImageData extends ImageData {
  final String path;
  final ImageSource imageSource;
  final double? width;
  final double? height;

  const ImageImageData(
      {required this.path, required this.imageSource, this.height, this.width});

  @override
  Widget getImageWidget() {
    if (imageSource == ImageSource.asset) {
      return Image.asset(path, width: width, height: height);
    }
    return Image.network(path, width: width, height: height);
  }
}

class WidgetImageData extends ImageData {
  final Widget widget;

  const WidgetImageData(this.widget);

  @override
  Widget getImageWidget() => getImageWidget();
}
