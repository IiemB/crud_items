import 'package:crud_items/features/items/cubit/item_cubit.dart';
import 'package:crud_items/features/items/data_sources/database_interface.dart';
import 'package:crud_items/services/injector.dart';
import 'package:crud_items/services/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_packages/i_packages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initInjector();

  await getIt<DataBaseInterface>().initDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ItemCubit>()),
      ],
      child: MaterialApp(
        title: 'CRUD Items',
        theme: IThemes.darkTheme,
        onGenerateRoute: getIt<Routes>().onGenerateRoute,
      ),
    );
  }
}
