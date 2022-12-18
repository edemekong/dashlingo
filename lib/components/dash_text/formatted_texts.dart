import 'package:linkify/linkify.dart';

final _blankRegex = RegExp(
  r'^(<blank?=)',
  caseSensitive: false,
  dotAll: false,
);

class CustomLinkifier extends Linkifier {
  const CustomLinkifier();

  @override
  List<LinkifyElement> parse(elements, options) {
    final list = <LinkifyElement>[];

    for (final element in elements) {
      if (element is TextElement) {
        final RegExpMatch? match = _blankRegex.firstMatch(element.text);

        if (match == null) {
          list.add(element);
        } else {
          final text = element.text.replaceFirst(match.group(0)!, '');
          if (match.group(1)?.isNotEmpty == true) {
            list.add(TextElement(match.group(1)!));
          }

          if (match.group(2)?.isNotEmpty == true) {
            var originalUrl = match.group(2)!;
            String? end;

            if ((options.excludeLastPeriod) && originalUrl[originalUrl.length - 1] == ".") {
              end = ".";
              originalUrl = originalUrl.substring(0, originalUrl.length - 1);
            }

            var url = originalUrl;

            if (((options.humanize) || (options.removeWww))) {
              if (options.humanize) {
                url = url.replaceFirst(RegExp(r'<blank?='), '');
              }

              list.add(BlankElement(originalUrl, url));
            } else {}

            list.add(BlankElement(originalUrl));

            if (end != null) {
              list.add(TextElement(end));
            }
          }

          if (text.isNotEmpty) {
            list.addAll(parse([TextElement(text)], options));
          }
        }
      } else {
        list.add(element);
      }
    }

    return list;
  }
}

class BlankElement extends LinkableElement {
  BlankElement(String blank, [String? text]) : super(text, blank);

  @override
  String toString() {
    return "LinkElement: '$url' ($text)";
  }

  @override
  bool operator ==(other) => equals(other);

  @override
  bool equals(other) => other is BlankElement && super.equals(other);
}
