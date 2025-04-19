/// This enum defines the asset paths for Lottie animations.
enum LottieAssets {
  /// The path for the searching animation.
  bluetoothSearch('assets/lottie/bluetooth_search.json');

  /// Creates a new instance of [LottieAssets] with the given [path].
  const LottieAssets(this.path);

  /// The path for the searching animation with a different design.
  final String path;
}
