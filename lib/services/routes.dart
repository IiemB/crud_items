import 'package:crud_items/features/items/models/item/item_model.dart';
import 'package:crud_items/features/items/pages/add_edit_item.dart';
import 'package:crud_items/features/items/pages/item_detail_page.dart';
import 'package:crud_items/features/items/pages/item_list_page.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@singleton
class Routes {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(
      settings: routeSettings,
      builder: (context) {
        switch (routeSettings.name) {
          case ItemListPage.routeName:
            return const ItemListPage();
          case ItemDetailPage.routeName:
            final args = routeSettings.arguments as Map<String, dynamic>;

            return ItemDetailPage(item: args['item'] as ItemModel);
          case AddEditItemPage.routeName:
            final args = routeSettings.arguments as Map<String, dynamic>;

            return AddEditItemPage(
              action: args['action'] as AddEditItemPageAction,
              item: args['item'] as ItemModel?,
            );
          default:
            return const ItemListPage();
        }
      },
    );
  }
}
