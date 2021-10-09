// External
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Internal
import 'package:dots_client/pages/main/events.dart';
import 'package:dots_client/pages/main/bloc.dart';
import 'package:dots_client/theme.dart';
import 'package:dots_client/pages/main/state.dart';

/// A [StatelessWidget] which demonstrates
/// how to consume and interact with a [CounterBloc].
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Counter')),
        body: Center(
          child: BlocBuilder<CounterBloc, CounterState>(
            builder: (context, count) {
              return Text('$count',
                  style: Theme.of(context).textTheme.headline1);
            },
          ),
        ),
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () => context.read<CounterBloc>().add(Increment()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: FloatingActionButton(
                child: const Icon(Icons.remove),
                onPressed: () => context.read<CounterBloc>().add(Decrement()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: FloatingActionButton(
                child: const Icon(Icons.brightness_6),
                onPressed: () => context.read<ThemeCubit>().toggleTheme(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
