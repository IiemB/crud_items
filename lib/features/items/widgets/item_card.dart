import 'package:crud_items/features/items/cubit/item_cubit.dart';
import 'package:crud_items/features/items/models/item/item_model.dart';
import 'package:crud_items/features/items/pages/add_edit_item.dart';
import 'package:crud_items/features/items/pages/item_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemCard extends StatelessWidget {
  final ItemModel itemModel;

  const ItemCard({Key? key, required this.itemModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(itemModel.name),
        subtitle: Text(itemModel.price.toString()),
        maintainState: true,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceEvenly,
            spacing: 8,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom().copyWith(
                    backgroundColor: MaterialStateProperty.all<Color?>(
                      Theme.of(context).errorColor,
                    ),
                  ),
                  onPressed: () => BlocProvider.of<ItemCubit>(context)
                      .deleteItem(itemModel.id),
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete'),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    AddEditItemPage.routeName,
                    arguments: <String, dynamic>{
                      'item': itemModel,
                      'action': AddEditItemPageAction.toEdit,
                    },
                  ),
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit'),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    ItemDetailPage.routeName,
                    arguments: <String, dynamic>{'item': itemModel},
                  ),
                  icon: const Icon(Icons.remove_red_eye),
                  label: const Text('View'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
