import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math show Random;

import 'package:flutter_bloc/flutter_bloc.dart';

class Project2Page extends StatelessWidget {
  const Project2Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NameCubit>(
      create: (_) => NameCubit(),
      child: Project2View(),
    );
  }
}

class Project2View extends StatelessWidget {
  const Project2View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Name Cubit'),
      ),
      body: BlocBuilder<NameCubit, String?>(builder: ((context, state) {
        final textButton = TextButton(
          onPressed: () {
            context.read<NameCubit>().getRandomName();
          },
          child: const Text('Fetch User'),
        );

        if (state != null) {
          return Center(
            child: Column(
              children: [Text(state), textButton],
            ),
          );
        } else {
          return Center(child: textButton);
        }
      })),
    );
  }
}

const Iterable<String> _userList = <String>[
  'Dessie',
  'Candelario',
  'Daron',
  'Tyshawn',
  'Viva',
  'Sasha',
  'Laurianne',
  'Alexa',
  'Olga',
  'Fiona',
  'Hudson'
];

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length));
}

class NameCubit extends Cubit<String?> {
  NameCubit() : super(null);

  void getRandomName() => emit(_userList.getRandomElement());
}
