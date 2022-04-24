import 'package:blocexp/features/project1/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Project1Page extends StatelessWidget {
  const Project1Page({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: ((context) => CounterCubit()),
      child: Project1View(),
    );
  }
}

class Project1View extends StatelessWidget {
  const Project1View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 1 App Bar'),
      ),
      body: BlocBuilder<CounterCubit, int>(
        builder: ((context, state) {
          return Center(
            child: Text(
              state.toString(),
              style: Theme.of(context).textTheme.headline3,
            ),
          );
        }),
      ),
      floatingActionButton: Row(
        children: [
          TextButton(
              onPressed: () {
                context.read<CounterCubit>().increment();
              },
              child: Text('inc')),
          TextButton(
              onPressed: () {
                context.read<CounterCubit>().decrement();
              },
              child: Text('dec'))
        ],
      ),
    );
  }
}
