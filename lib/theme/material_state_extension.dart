import 'package:flutter/material.dart';

extension MaterialStateSet on Set<WidgetState> {
  bool isSelected() => contains(WidgetState.selected);
  bool isDisabled() => contains(WidgetState.disabled);
  bool isHovered() => contains(WidgetState.hovered);
  bool isFocused() => contains(WidgetState.focused);
  bool isPressed() => contains(WidgetState.pressed);
  bool isDragged() => contains(WidgetState.dragged);
  bool scrolledUnder() => contains(WidgetState.scrolledUnder);
  bool hasError() => contains(WidgetState.error);
}
