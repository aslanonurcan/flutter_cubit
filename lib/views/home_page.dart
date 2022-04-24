import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedTab = context
        .select<HomeCubit, HomeTab>(((HomeCubit cubit) => cubit.state.tab));

    return Scaffold(
      body: IndexedStack(
        index: selectedTab.index,
        children: const [
          Page1(),
          Page2(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeTabButton(
              iconData: Icons.list_rounded,
              value: HomeTab.page1,
              selectedValue: selectedTab,
            ),
            HomeTabButton(
              iconData: Icons.show_chart,
              value: HomeTab.page2,
              selectedValue: selectedTab,
            ),
          ],
        ),
      ),
    );
  }
}

class HomeTabButton extends StatelessWidget {
  const HomeTabButton(
      {Key? key,
      required this.value,
      required this.selectedValue,
      required this.iconData})
      : super(key: key);

  final HomeTab value;
  final HomeTab selectedValue;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<HomeCubit>().setTab(value);
      },
      icon: Icon(
        iconData,
        size: 32,
      ),
      color: selectedValue != value
          ? null
          : Theme.of(context).colorScheme.secondary,
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page1'),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page2'),
      ),
    );
  }
}

enum HomeTab { page1, page2 }

@immutable
class HomeState extends Equatable {
  final HomeTab tab;

  const HomeState({this.tab = HomeTab.page1});

  @override
  List<Object?> get props => [tab];
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void setTab(HomeTab tab) => emit(HomeState(tab: tab));
}
