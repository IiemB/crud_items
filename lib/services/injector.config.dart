// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../features/items/cubit/item_cubit.dart' as _i5;
import '../features/items/cubit/shimmer_cubit.dart' as _i7;
import '../features/items/data_sources/database_interface.dart' as _i3;
import '../features/items/data_sources/database_repository.dart' as _i4;
import 'routes.dart' as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.DataBaseInterface>(_i4.DataBaseRepository());
  gh.factory<_i5.ItemCubit>(() => _i5.ItemCubit(get<_i3.DataBaseInterface>()));
  gh.singleton<_i6.Routes>(_i6.Routes());
  gh.factory<_i7.ShimmerCubit>(() => _i7.ShimmerCubit());
  return get;
}
