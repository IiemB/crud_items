import 'package:crud_items/features/items/cubit/item_cubit.dart';
import 'package:crud_items/features/items/cubit/shimmer_cubit.dart';
import 'package:crud_items/features/items/models/item/item_model.dart';
import 'package:crud_items/services/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_packages/widgets/gap.dart';
import 'package:shimmer/shimmer.dart';

enum AddEditItemPageAction { toAdd, toEdit }

class AddEditItemPage extends StatefulWidget {
  static const routeName = '/AddEditItemPage';

  final AddEditItemPageAction action;
  final ItemModel? item;
  const AddEditItemPage({
    Key? key,
    required this.action,
    required this.item,
  }) : super(key: key);

  @override
  _AddEditItemPageState createState() => _AddEditItemPageState();
}

class _AddEditItemPageState extends State<AddEditItemPage> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.item != null) {
      nameController.text = widget.item!.name;
      priceController.text = widget.item!.price.toString();
      descController.text = widget.item!.descriptions;
    }
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.action == AddEditItemPageAction.toAdd
              ? 'Add Item'
              : widget.item!.name,
        ),
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
                    3,
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [TextFormField(), const IGap()],
                    ),
                  ),
                ),
              ),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: nameController,
                      textCapitalization: TextCapitalization.characters,
                      decoration: const InputDecoration(
                        hintText: 'Item name',
                        prefixIcon: Icon(Icons.card_giftcard),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                    ),
                    const IGap(),
                    TextFormField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Item price',
                        prefixIcon: Icon(Icons.currency_bitcoin),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                    ),
                    const IGap(),
                    TextFormField(
                      controller: descController,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 3,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        hintText: 'Item description',
                        prefixIcon: Icon(Icons.description),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final isValid = _formKey.currentState?.validate() ?? false;

          if (isValid) {
            final item = ItemModel(
              id: widget.action == AddEditItemPageAction.toAdd
                  ? hashCode
                  : widget.item!.id,
              name: nameController.text,
              dateAdded: DateTime.now().toString(),
              price: double.tryParse(priceController.text) ?? 0,
              descriptions: descController.text,
            );

            Navigator.pop(context);

            if (widget.action == AddEditItemPageAction.toAdd) {
              BlocProvider.of<ItemCubit>(context).addItem(item);
            } else {
              BlocProvider.of<ItemCubit>(context).editItem(item);
            }
          }
        },
        label: const Text('Save'),
      ),
    );
  }
}
