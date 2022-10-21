part of 'store_data_cubit.dart';

@immutable
abstract class StoreDataState {}

class StoreDataInitial extends StoreDataState {}
class StoreDataLoadingState extends StoreDataState {}
class StoreDataSuccessState extends StoreDataState {}
class StoreDataErrorState extends StoreDataState {}
class StoreDataGetUserDataState extends StoreDataState {}
class StoreDataReceiveStudentsState extends StoreDataState {}
