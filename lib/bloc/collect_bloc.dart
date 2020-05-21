import 'package:flutter_start/bloc/bloc_base.dart';

class CollectBloc implements BlocBase {
  @override
  void dispose() {}

  @override
  Future getData({String labelId, int page}) {
    throw UnimplementedError();
  }

  @override
  Future onLoadMore({String labelId}) {
    throw UnimplementedError();
  }

  @override
  Future onRefresh({String labelId}) {
    throw UnimplementedError();
  }
}
