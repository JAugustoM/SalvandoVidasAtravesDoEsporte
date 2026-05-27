import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:salvando_vidas/ui/home/widgets/body.dart';
import 'package:salvando_vidas/data/stores/home/counter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = Counter();
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
