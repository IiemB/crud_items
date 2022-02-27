import 'package:crud_items/features/items/cubit/shimmer_cubit.dart';
import 'package:crud_items/features/items/models/item/item_model.dart';
import 'package:crud_items/services/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class ItemDetailPage extends StatelessWidget {
  static const routeName = '/ItemDetailPage';

  final ItemModel item;
  const ItemDetailPage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<ShimmerCubit, bool>(
          bloc: getIt<ShimmerCubit>()..updateState(),
          builder: (context, state) {
            return Visibility(
              visible: state,
              replacement: Shimmer.fromColors(
                baseColor: Colors.black,
                highlightColor: Colors.black45,
                enabled: true,
                child: ListView(
                  children: List.filled(
                    4,
                    const Card(
                      child: ListTile(
                        title: Text('I'),
                        subtitle: Text('I'),
                      ),
                    ),
                  ),
                ),
              ),
              child: ListView(
                children: [
                  Card(
                    child: ListTile(
                      title: const Text('Item id'),
                      subtitle: Text(item.id.toString()),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Item name'),
                      subtitle: Text(item.name),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Item price'),
                      subtitle: Text(item.price.toString()),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Item description'),
                      subtitle: Text(item.descriptions),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
