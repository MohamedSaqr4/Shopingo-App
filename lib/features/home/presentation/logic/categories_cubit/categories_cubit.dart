import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce/features/home/data/repos/categories_repo.dart';
import 'package:meta/meta.dart';
import 'package:ecommerce/features/home/data/models/category_model.dart';
part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoriesRepositry repository;
  CategoriesCubit(this.repository) : super(CategoriesInitial());

  Future<void> getAllCategories() async {
    emit(CategoriesLoading());

    final Either<String, List<CategoryModel>> result =
        await repository.fetchAllCategory();

    result.fold(
      (failureMessage) => emit(CategoriesFailure(failureMessage)),
      (categories) => emit(CategoriesSuccess(categories)),
    );
  }
}
