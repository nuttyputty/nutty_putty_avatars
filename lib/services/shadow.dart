calculateShadowColor(color) {
  return color
      .withValue(color.value - 0.1 > 0.0 ? color.value - 0.1 : 0.0)
      .toColor();
}
