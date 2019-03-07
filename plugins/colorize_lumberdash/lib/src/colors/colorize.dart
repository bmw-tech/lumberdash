class Colorize {
  static final String ESC = "\u{1B}";

  String initial = '';

  Colorize([this.initial = '']);

  Colorize apply(Styles style, [String text]) {
    if (text == null) {
      text = initial;
    }

    initial = _applyStyle(style, text);
    return this;
  }

  void white() {
    apply(Styles.WHITE);
  }

  void yellow() {
    apply(Styles.YELLOW);
  }

  void bgRed() {
    apply(Styles.BG_RED);
  }

  void red() {
    apply(Styles.RED);
  }

  String buildEscSeq(Styles style) {
    return ESC + "[${getStyle(style)}m";
  }

  String _applyStyle(Styles style, String text) {
    return buildEscSeq(style) + text + buildEscSeq(Styles.RESET);
  }

  static String getStyle(Styles style) {
    switch (style) {
      case Styles.RESET:
        return '0';
      case Styles.RED:
        return '31';
      case Styles.YELLOW:
        return '33';
      case Styles.WHITE:
        return '97';
      case Styles.BG_RED:
        return '41';
      default:
        return '';
    }
  }
}

enum Styles {
  RESET,
  RED,
  YELLOW,
  WHITE,
  BG_RED,
}
