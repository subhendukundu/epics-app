import 'package:epics/view/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart' hide AnimatedScale;

class PositionSeekWidget extends StatefulWidget {
  final Duration currentPosition;
  final Duration duration;
  final Function(Duration) seekTo;

  const PositionSeekWidget({
    this.currentPosition,
    this.duration,
    this.seekTo,
  });

  @override
  _PositionSeekWidgetState createState() => _PositionSeekWidgetState();
}

class _PositionSeekWidgetState extends State<PositionSeekWidget> {
  Duration _visibleValue;
  bool listenOnlyUserInterraction = false;
  double get percent => widget.duration.inMilliseconds == 0
      ? 0
      : _visibleValue.inMilliseconds / widget.duration.inMilliseconds;

  @override
  void initState() {
    super.initState();
    _visibleValue = widget.currentPosition;
  }

  @override
  void didUpdateWidget(PositionSeekWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listenOnlyUserInterraction) {
      _visibleValue = widget.currentPosition;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 250,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 40,
              child: Text(durationToString(widget.currentPosition),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: PINK_COLOR)),
            ),
            Expanded(
              child: NeumorphicSlider(
                min: 0,
                height: 8,
                max: widget.duration.inMilliseconds.toDouble(),
                value: percent * widget.duration.inMilliseconds.toDouble(),
                style: SliderStyle(variant: PINK_COLOR, accent: PINK_COLOR),
                onChangeEnd: (newValue) {
                  setState(() {
                    listenOnlyUserInterraction = false;
                    widget.seekTo(_visibleValue);
                  });
                },
                onChangeStart: (_) {
                  setState(() {
                    listenOnlyUserInterraction = true;
                  });
                },
                onChanged: (newValue) {
                  setState(() {
                    final to = Duration(milliseconds: newValue.floor());
                    _visibleValue = to;
                  });
                },
              ),
            ),
            SizedBox(
                width: 40,
                child: Text(durationToString(widget.duration),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(color: PINK_COLOR))),
          ],
        ),
      ),
    );
  }
}

String durationToString(Duration duration) {
  String twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  final twoDigitMinutes =
      twoDigits(duration.inMinutes.remainder(Duration.minutesPerHour));
  final twoDigitSeconds =
      twoDigits(duration.inSeconds.remainder(Duration.secondsPerMinute));
  return '$twoDigitMinutes:$twoDigitSeconds';
}
