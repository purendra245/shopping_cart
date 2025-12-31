import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/components/my_list_tile.dart';
import 'package:shopping_cart/di/module.dart';
import 'package:shopping_cart/presentation/cubits/cubit/players_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PlayersCubit>()..getPlayers(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: const Text('Players', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
        ),
        body: BlocBuilder<PlayersCubit, PlayersState>(
          builder: (context, state) {
            if (state is PlayersLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is PlayersError) {
              return Center(child: Text(state.message));
            } else if (state is PlayersLoaded) {
              return ListView.builder(
                itemCount: state.playerResponse.data.length,
                itemBuilder: (context, index) {
                  final player = state.playerResponse.data[index];
                  return MyListTile(player: player);
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
