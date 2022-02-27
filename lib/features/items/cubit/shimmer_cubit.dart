import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ShimmerCubit extends Cubit<bool> {
  ShimmerCubit() : super(false);

  void updateState() async {
    await Future.delayed(const Duration(seconds: 3));

    emit(true);
  }
}
