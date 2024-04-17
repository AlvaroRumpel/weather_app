part of 'weather_page.dart';

class _CustomFabAnimatior extends FloatingActionButtonAnimator {
  @override
  Offset getOffset({
    required Offset begin,
    required Offset end,
    required double progress,
  }) {
    return Offset.lerp(begin, end, progress) ?? begin;
  }

  @override
  Animation<double> getRotationAnimation({required Animation<double> parent}) {
    return Tween<double>(begin: 0, end: 1).animate(parent);
  }

  @override
  Animation<double> getScaleAnimation({required Animation<double> parent}) {
    return Tween<double>(begin: 1, end: 1).animate(parent);
  }
}
