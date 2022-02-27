import 'package:crud_items/features/items/cubit/item_cubit.dart';
import 'package:crud_items/features/items/cubit/shimmer_cubit.dart';
import 'package:crud_items/features/items/pages/add_edit_item.dart';
import 'package:crud_items/features/items/widgets/item_card.dart';
import 'package:crud_items/services/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_packages/i_packages.dart';
import 'package:shimmer/shimmer.dart';

class ItemListPage extends StatefulWidget {
  static const routeName = '/';
  const ItemListPage({Key? key}) : super(key: key);

  @override
  State<ItemListPage> createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  @override
  void initState() {
    BlocProvider.of<ItemCubit>(context).getItemList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Items List'),
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
                    10,
                    const Card(
                      child: ListTile(
                        title: Text('I'),
                        subtitle: Text('I'),
                      ),
                    ),
                  ),
                ),
              ),
              child: BlocConsumer<ItemCubit, ItemState>(
                listener: (context, state) {
                  state.maybeMap(
                    orElse: () {},
                    loading: (v) {
                      ISnackbar.showLoadingSnackbar(
                        context,
                        loadingText: v.msg,
                      );
                    },
                    success: (v) {
                      ISnackbar.showSuccessSnackbar(context, message: v.msg);
                    },
                    error: (v) {
                      ISnackbar.showErrorSnakbar(context, message: v.msg);
                    },
                  );
                },
                buildWhen: (a, b) => b is ItemStateLoaded,
                builder: (context, state) {
                  return state.maybeMap(
                    orElse: () =>
                        const Center(child: CircularProgressIndicator()),
                    loaded: (v) => v.items.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.check_box_outline_blank_sharp,
                                  size: 200,
                                ),
                                Text('No item found'),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: v.items.length,
                            itemBuilder: (context, index) =>
                                ItemCard(itemModel: v.items[index]),
                          ),
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(
          context,
          AddEditItemPage.routeName,
          arguments: <String, dynamic>{
            'action': AddEditItemPageAction.toAdd,
            'item': null
          },
        ),
        label: const Text('Add Item'),
      ),
    );
  }
}
