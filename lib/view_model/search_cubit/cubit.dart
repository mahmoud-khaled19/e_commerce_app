import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model/search_model.dart';
import 'package:shop_app/view_model/search_cubit/states.dart';
import '../../../app_constance/api_constance.dart';
import '../../../app_constance/constants_methods.dart';
import '../shared/network/remote/dio.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(InitialSearchState());

  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? model;
  final TextEditingController searchController = TextEditingController();
  List<SearchModel> searchList = [];

  void getSearch() {
    emit(LoadingSearchState());
    DioHelper.postData(
      url: ApiConstance.search,
      data: {'text': searchController.text.trim()},
      token: GlobalMethods.token,
    ).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SuccessSearchState());
    }).catchError((error) {
      emit(ErrorSearchState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
