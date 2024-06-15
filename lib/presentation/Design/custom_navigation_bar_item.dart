

import 'package:flutter/material.dart';

class CustomNavigationBarItem {
  /// Create a Custom Navigationbar Item.
  ///
  /// the [selectedIcon] must not be null.
  CustomNavigationBarItem({
    required this.icon,
    Widget? selectedIcon,
    this.title,
    Text? selectedTitle,
    this.badgeCount = 0,
    this.showBadge = false,
  })  : selectedIcon = selectedIcon ?? icon,
        selectedTitle = selectedTitle ?? title;

  ///
  /// The icon of the item
  /// Typically the icon is an [Icon].
  ///

  final Widget icon;

  /// An alternative icon displayed when this bottom navigation item is
  /// selected.
  ///
  /// If this icon is not provided, the bottom navigation bar will display
  /// [icon] in either state.
  final Widget selectedIcon;

  ///
  /// Item title under icon
  ///
  final Widget? title;

  ///
  /// Item selected title under icon
  ///
  final Widget? selectedTitle;

  /// Notification badge count
  final int badgeCount;

  /// hide or show badge
  final bool showBadge;
}
