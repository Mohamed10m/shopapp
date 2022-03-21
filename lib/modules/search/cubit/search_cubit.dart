import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/search_states.dart';
import 'package:shop_app/shared/endpoint/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(LoadingSearchStates());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void Search(String text) {
    emit(LoadingSearchStates());
    DioHelper.postData(path: SEARCH, data: {'text': text}, token: token)
        .then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SuccessSearchStates());
    }).catchError((error) {
      emit(ErrorSearchStates());
    });
  }
}
