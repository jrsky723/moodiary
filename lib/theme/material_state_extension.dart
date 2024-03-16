import 'package:flutter/material.dart';

extension MaterialStateSet on Set<MaterialState> {
  bool isSelected() => contains(MaterialState.selected);
  bool isDisabled() => contains(MaterialState.disabled);
  bool isHovered() => contains(MaterialState.hovered);
  bool isFocused() => contains(MaterialState.focused);
  bool isPressed() => contains(MaterialState.pressed);
  bool isDragged() => contains(MaterialState.dragged);
  bool scrolledUnder() => contains(MaterialState.scrolledUnder);
  bool hasError() => contains(MaterialState.error);
}
