import 'package:untitled4/data/user_data.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileUploading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  UserDataModel userData;

  ProfileLoaded({required this.userData});
}

class ProfileError extends ProfileState {
  final String error;

  ProfileError({required this.error});
}