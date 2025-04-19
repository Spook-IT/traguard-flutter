import 'package:traguard/utils/extensions.dart';

/// This class contains constants for padding values used in the application.
class Paddings {
  /// Private constructor to prevent instantiation.
  const Paddings._();

  /*
  * ---------------
  * PADDING VALUES
  * ---------------
  */

  /// A small padding value (8.0).
  static const smallValue = 8.0;

  /// A medium padding value (16.0).
  static const mediumValue = 16.0;

  /// A large padding value (24.0).
  static const largeValue = 24.0;

  /// An extra-large padding value (32.0).
  static const xLargeValue = 32.0;

  /*
  * ------------
  * ALL PADDING
  * ------------
  */

  /// Padding applied equally to all sides using the small value.
  static final smallAll = smallValue.paddingAll;

  /// Padding applied equally to all sides using the medium value.
  static final mediumAll = mediumValue.paddingAll;

  /// Padding applied equally to all sides using the large value.
  static final largeAll = largeValue.paddingAll;

  /// Padding applied equally to all sides using the extra-large value.
  static final xLargeAll = xLargeValue.paddingAll;

  /*
  * -----------------
  * PADDING VERTICAL
  * -----------------
  */

  /// Padding applied vertically (top and bottom) using the small value.
  static final smallVertical = smallValue.paddingVertical;

  /// Padding applied vertically (top and bottom) using the medium value.
  static final mediumVertical = mediumValue.paddingVertical;

  /// Padding applied vertically (top and bottom) using the large value.
  static final largeVertical = largeValue.paddingVertical;

  /// Padding applied vertically (top and bottom) using the extra-large value.
  static final xLargeVertical = xLargeValue.paddingVertical;

  /*
  * -------------------
  * PADDING HORIZONTAL
  * -------------------
  */

  /// Padding applied horizontally (left and right) using the small value.
  static final smallHorizontal = smallValue.paddingHorizontal;

  /// Padding applied horizontally (left and right) using the medium value.
  static final mediumHorizontal = mediumValue.paddingHorizontal;

  /// Padding applied horizontally (left and right) using the large value.
  static final largeHorizontal = largeValue.paddingHorizontal;

  /// Padding applied horizontally (left and right) using the extra-large value.
  static final xLargeHorizontal = xLargeValue.paddingHorizontal;

  /*
  * ------------
  * PADDING TOP
  * ------------
  */

  /// Padding applied to the top using the small value.
  static final smallTop = smallValue.paddingTop;

  /// Padding applied to the top using the medium value.
  static final mediumTop = mediumValue.paddingTop;

  /// Padding applied to the top using the large value.
  static final largeTop = largeValue.paddingTop;

  /// Padding applied to the top using the extra-large value.
  static final xLargeTop = xLargeValue.paddingTop;

  /*
  * ---------------
  * PADDING BOTTOM
  * ---------------
  */

  /// Padding applied to the bottom using the small value.
  static final smallBottom = smallValue.paddingBottom;

  /// Padding applied to the bottom using the medium value.
  static final mediumBottom = mediumValue.paddingBottom;

  /// Padding applied to the bottom using the large value.
  static final largeBottom = largeValue.paddingBottom;

  /// Padding applied to the bottom using the extra-large value.
  static final xLargeBottom = xLargeValue.paddingBottom;

  /*
  * -------------
  * PADDING LEFT
  * -------------
  */

  /// Padding applied to the left using the small value.
  static final smallLeft = smallValue.paddingLeft;

  /// Padding applied to the left using the medium value.
  static final mediumLeft = mediumValue.paddingLeft;

  /// Padding applied to the left using the large value.
  static final largeLeft = largeValue.paddingLeft;

  /// Padding applied to the left using the extra-large value.
  static final xLargeLeft = xLargeValue.paddingLeft;

  /*
  * --------------
  * PADDING RIGHT
  * --------------
  */

  /// Padding applied to the right using the small value.
  static final smallRight = smallValue.paddingRight;

  /// Padding applied to the right using the medium value.
  static final mediumRight = mediumValue.paddingRight;

  /// Padding applied to the right using the large value.
  static final largeRight = largeValue.paddingRight;

  /// Padding applied to the right using the extra-large value.
  static final xLargeRight = xLargeValue.paddingRight;
}

/// This class contains constants for space values used in the application.
/// It is used to define spacing between UI elements.
class Spaces {
  /// Private constructor to prevent instantiation.
  const Spaces._();

  /*
  * --------------
  * SPACES VALUES
  * --------------
  */

  /// A small space value (8.0).
  static const small = 8.0;

  /// A medium space value (16.0).
  static const medium = 16.0;

  /// A large space value (24.0).
  static const large = 24.0;

  /// An extra-large space value (32.0).
  static const xLarge = 32.0;
}
