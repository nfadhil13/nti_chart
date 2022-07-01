part of '../nti_chart.dart';

class TextAttribute {
  final Locale? locale;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;
  final String? semanticLabel;
  final bool? softWrap;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextHeightBehavior? textHeightBehavior;
  final double? textScaleFactor;
  final TextWidthBasis? textWidthBasis;

  const TextAttribute(
      {this.locale,
      this.style,
      this.maxLines,
      this.overflow,
      this.semanticLabel,
      this.softWrap,
      this.strutStyle,
      this.textAlign,
      this.textHeightBehavior,
      this.textScaleFactor,
      this.textWidthBasis});

  Text createText(String text) {
    return Text(
      text,
      locale: locale,
      style: style,
      maxLines: maxLines,
      overflow: overflow,
      semanticsLabel: semanticLabel,
      softWrap: softWrap,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textHeightBehavior: textHeightBehavior,
      textScaleFactor: textScaleFactor,
      textWidthBasis: textWidthBasis,
    );
  }
}
