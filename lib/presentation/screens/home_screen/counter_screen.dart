import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:animated_background/animated_background.dart';
import 'package:bloc_counter_app/core/constants/enums.dart';
import 'package:bloc_counter_app/logic/cubit/cubit/counter_cubit.dart';
import 'package:bloc_counter_app/logic/cubit/cubit/counter_state.dart';
import 'package:bloc_counter_app/logic/cubit/cubit/internet_cubit.dart';
import 'package:bloc_counter_app/presentation/screens/home_screen/widgets/slider_counter_button.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    log(WidgetsBinding.instance.platformDispatcher.platformBrightness
        .toString());
    super.initState();
  }

  int value = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: AnimatedBackground(
          behaviour: RandomParticleBehaviour(
            options: ParticleOptions(
              image: WidgetsBinding
                          .instance.platformDispatcher.platformBrightness ==
                      Brightness.light
                  ? Image.asset('assets/images/icon2.png')
                  : Image.asset('assets/images/icon.png'),
              spawnOpacity: 0.0,
              opacityChangeRate: 0.25,
              minOpacity: 0.1,
              maxOpacity: 0.4,
              spawnMinSpeed: 15,
              spawnMaxSpeed: 50.0,
              spawnMinRadius: 7.0,
              spawnMaxRadius: 15.0,
              particleCount: 40,
            ),
            paint: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.0,
          ),
          vsync: this,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                    width: 300,
                    height: 300,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedSunMoon(),
                        BlocBuilder<CounterCubit, CounterState>(
                          builder: (context, state) {
                            return CounterValue(state: state);
                          },
                        )
                      ],
                    )),
                BlocBuilder<InternetCubit, InternetState>(
                  builder: (context, internetState) {
                    return internetStateMethod(internetState);
                  },
                ),
                SliderCounterButton(
                  initialValue: context.read<CounterCubit>().state.counter,
                  onChanged: (value) {
                    context.read<CounterCubit>().set(value: value);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text internetStateMethod(InternetState internetState) {
    if (internetState is InternetConnected) {
      if (internetState.connectiontype == NetworkType.mobile) {
        return const Text(
          "Connected to mobile",
          style: TextStyle(fontSize: 25, color: Colors.blue),
        );
      } else {
        return const Text(
          "Connected to WiFi",
          style: TextStyle(fontSize: 25, color: Colors.green),
        );
      }
    } else if (internetState is InternetDisconnected) {
      return const Text(
        "Disconnected",
        style: TextStyle(fontSize: 25, color: Colors.red),
      );
    }
    return const Text(
      "Loading",
      style: TextStyle(fontSize: 25, color: Colors.yellow),
    );
  }
}

class CounterValue extends StatefulWidget {
  const CounterValue({
    super.key,
    required this.state,
  });
  final CounterState state;

  @override
  State<CounterValue> createState() => _CounterValueState();
}

class _CounterValueState extends State<CounterValue> {
  late AnimationController _animationController;
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward(from: 0.0);
    return ZoomIn(
      duration: Durations.long4,
      controller: (p0) => _animationController = p0,
      child: Text(
        widget.state.counter.toString(),
        style: Theme.of(context)
            .textTheme
            .displayLarge!
            .copyWith(color: Colors.black, fontSize: 70),
      ),
    );
  }
}

class AnimatedSunMoon extends StatelessWidget {
  const AnimatedSunMoon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FlareActor(
      WidgetsBinding.instance.platformDispatcher.platformBrightness ==
              Brightness.light
          ? "assets/flare/sun.flr"
          : "assets/flare/moon.flr",
      animation: 'Moon Rings',
      // color: Colors.yellow.shade500,
    );
  }
}
