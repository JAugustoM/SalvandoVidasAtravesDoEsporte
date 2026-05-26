import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:salvando_vidas/data/stores/home/counter.dart';

Widget homeCounter(BuildContext context, Counter counter) {
  return Center(
    child: Column(
      mainAxisAlignment: .center,
      children: [
        const Text('You have pushed the button this many times:'),
        Observer(
          key: Key("Counter"),
          builder: (_) => Text(
            '${counter.value}',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ],
    ),
  );
}
