part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class UserDataLoadedState extends ProfileState {
  final dynamic userData;

  const UserDataLoadedState(this.userData);

  @override
  List<Object> get props => [userData];
}

class UserDataTicketsState extends ProfileState {
  final Map<String, dynamic> userTicketsData;

  const UserDataTicketsState(this.userTicketsData);

  @override
  List<Object> get props => [userTicketsData];
}

class UserDataTicketsErrorState extends ProfileState {}

class UserDataNicknameState extends ProfileState {
  final Map<String, dynamic> userNickname;

  const UserDataNicknameState(this.userNickname);

  @override
  List<Object> get props => [userNickname];
}