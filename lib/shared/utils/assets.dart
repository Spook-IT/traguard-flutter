/// This enum defines the asset paths for Lottie animations.
enum LottieAssets {
  /// The path for the searching animation.
  bluetoothSearch('assets/lottie/bluetooth_search.json'),

  /// The path for switch on/off animation.
  switchOnOff('assets/lottie/switch_on_off.json'),

  /// The path for the error animation.
  error('assets/lottie/error.json');

  /// Creates a new instance of [LottieAssets] with the given [path].
  const LottieAssets(this.path);

  /// The path of the Lottie animation.
  final String path;
}

/// This enum defines the asset paths for image assets.
enum ImageAssets {
  /// The path for the tracker device image.
  trackerDevice('assets/img/tracer.png');

  /// Creates a new instance of [ImageAssets] with the given [path].
  const ImageAssets(this.path);

  /// The path of the image asset.
  final String path;
}
