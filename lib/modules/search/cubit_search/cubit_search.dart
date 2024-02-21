import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/search_model.dart';
import 'package:shop_app/modules/search/cubit_search/states_search.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../shared/components/constants.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit():super(SearchInitialState());

  static SearchCubit get(context)=>BlocProvider.of(context);

  late SearchModel model;

  void search(String text){
    emit(SearchLoading());
    DioHelper.postData(path: SEARCH, data: {'text':text},token: token).then((value) {
    model=SearchModel.fromJson(value.data);


      emit(SearchSuccess());
    }).catchError((onError){
      print(onError.toString());
      emit(SearchError());
    });
  }

}