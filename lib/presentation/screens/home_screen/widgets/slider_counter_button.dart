// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class SliderCounterButton extends StatefulWidget {
  const SliderCounterButton({
    Key? key,
    this.direction = Axis.horizontal,
    this.initialValue,
    this.onChanged,
    this.withSpring = true,
  }) : super(key: key);

  /// the orientation of the stepper its horizontal or vertical.
  final Axis direction;

  /// the initial value of the stepper
  final int? initialValue;

  /// called whenever the value of the stepper changed
  final ValueChanged<int>? onChanged;

  /// if you want a springSimulation to happens the the user let go the stepper
  /// defaults to true
  final bool withSpring;

  // Coded By Raj Chowdhury

  @override
  _SliderCounterButtonstate createState() => _SliderCounterButtonstate();
}

class _SliderCounterButtonstate extends State<SliderCounterButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late int _value;
  late double _startAnimationPosX;
  late double _startAnimationPosY;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue ?? 0;
    _controller =
        AnimationController(vsync: this, lowerBound: -0.5, upperBound: 0.5);
    _controller.value = 0.0;
    _controller.addListener(() {});

    if (widget.direction == Axis.horizontal) {
      _animation = Tween<Offset>(
              begin: const Offset(0.0, 0.0), end: const Offset(1.5, 0.0))
          .animate(_controller);
    } else {
      _animation = Tween<Offset>(
              begin: const Offset(0.0, 0.0), end: const Offset(0.0, 1.5))
          .animate(_controller);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.direction == Axis.horizontal) {
      _animation = Tween<Offset>(
              begin: const Offset(0.0, 0.0), end: const Offset(1.5, 0.0))
          .animate(_controller);
    } else {
      _animation = Tween<Offset>(
              begin: const Offset(0.0, 0.0), end: const Offset(0.0, 1.5))
          .animate(_controller);
    }
  }

  // !test = init();

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: SizedBox(
        width: widget.direction == Axis.horizontal ? 280.0 : 100.0,
        height: widget.direction == Axis.horizontal ? 100.0 : 280.0,
        child: Material(
          type: MaterialType.canvas,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(60.0),
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                left: widget.direction == Axis.horizontal ? 10.0 : null,
                bottom: widget.direction == Axis.horizontal ? null : 10.0,
                child: Icon(Icons.remove,
                    size: 40.0, color: Theme.of(context).colorScheme.primary),
              ),
              Positioned(
                right: widget.direction == Axis.horizontal ? 10.0 : null,
                top: widget.direction == Axis.horizontal ? null : 10.0,
                child: Icon(Icons.add,
                    size: 40.0, color: Theme.of(context).colorScheme.primary),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onHorizontalDragStart: _onPanStart,
                  onHorizontalDragUpdate: _onPanUpdate,
                  onHorizontalDragEnd: _onPanEnd,
                  child: SlideTransition(
                    position: _animation,
                    child: Material(
                      color: Colors.white,
                      shape: const CircleBorder(),
                      elevation: 5.0,
                      child: Center(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return ScaleTransition(
                                scale: animation, child: child);
                          },
                          child: Text(
                            'O',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 56.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double offsetFromGlobalPos(Offset globalPosition) {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset local = box.globalToLocal(globalPosition);
    _startAnimationPosX = ((local.dx * 0.75) / box.size.width) - 0.4;
    _startAnimationPosY = ((local.dy * 0.75) / box.size.height) - 0.4;
    if (widget.direction == Axis.horizontal) {
      return ((local.dx * 0.75) / box.size.width) - 0.4;
    } else {
      return ((local.dy * 0.75) / box.size.height) - 0.4;
    }
  }

  void _onPanStart(DragStartDetails details) {
    _controller.stop();
    _controller.value = offsetFromGlobalPos(details.globalPosition);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    _controller.value = offsetFromGlobalPos(details.globalPosition);
  }

  void _onPanEnd(DragEndDetails details) {
    _controller.stop();
    bool isHor = widget.direction == Axis.horizontal;
    bool changed = false;
    if (_controller.value <= -0.20) {
      setState(() => isHor ? _value-- : _value++);
      changed = true;
    } else if (_controller.value >= 0.20) {
      setState(() => isHor ? _value++ : _value--);
      changed = true;
    }
    if (widget.withSpring) {
      final SpringDescription kDefaultSpring =
          SpringDescription.withDampingRatio(
        mass: 0.9,
        stiffness: 250.0,
        ratio: 0.6,
      );
      if (widget.direction == Axis.horizontal) {
        _controller.animateWith(
            SpringSimulation(kDefaultSpring, _startAnimationPosX, 0.0, 0.0));
      } else {
        _controller.animateWith(
            SpringSimulation(kDefaultSpring, _startAnimationPosY, 0.0, 0.0));
      }
    } else {
      _controller.animateTo(0.0,
          curve: Curves.bounceOut, duration: const Duration(milliseconds: 500));
    }

    if (changed && widget.onChanged != null) {
      widget.onChanged!(_value);
    }
  }
}
