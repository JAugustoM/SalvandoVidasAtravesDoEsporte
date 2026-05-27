import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:salvando_vidas/ui/home/widgets/body.dart';
import 'package:salvando_vidas/data/stores/home/counter.dart';

final counter = Counter();

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: homeCounter(context, counter),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counter.increment();
          context.read<Logger>().i("Counter Incremented");
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
