import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_api_call_curd_app/presentation/model/user_model.dart';
import 'package:bloc_api_call_curd_app/service/service.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'curd_api_event.dart';
part 'curd_api_state.dart';

class CurdApiBloc extends Bloc<CurdApiEvent, CurdApiState> {
  final RestApiSerivces _apiSerivces;
  CurdApiBloc(this._apiSerivces) : super(CurdApiInitial()) {
    on<PostUser>(postUsercall);
    on<ReadEvent>(readUserCall);
    on<UpdateUser>(updateUserCall);
    on<DeleteUserEvent>(deleteUserCall);
  }

  void deleteUserCall(
      DeleteUserEvent event, Emitter<CurdApiState> states) async {
    emit(DeleteInitial(isLoading: true));
    await _apiSerivces.delelteById(event.id).then((value) {
      if (value == true) {
        emit(DeleteInitial(isLoading: false));
        emit(DeleteLoaded());
        add(ReadEvent());
      } else {
        emit(DeleteInitial(isLoading: true));
      }
    });
  }

  void updateUserCall(UpdateUser event, Emitter<CurdApiState> states) async {
    emit(UpdateLoading(isLoading: true));
    await _apiSerivces
        .updateUserService(
      event.id,
      event.title,
      event.description,
      event.isCompleted,
    )
        .then((value) {
      emit(UpdateLoading(isLoading: false));
      add(ReadEvent());

      Future.delayed(
          Duration(
            milliseconds: 500,
          ), () {
        Navigator.pop(event.context);
      });
    }).onError((error, stackTrace) {
      emit(CurdErrorState(error: error.toString()));
    });
  }

  void readUserCall(ReadEvent event, Emitter<CurdApiState> states) async {
    emit(CurdLoadingState());
    await _apiSerivces.readUserService().then((value) {
      print(value.data);
      print("emmiting");
      emit(ReadUserState(userModel: value));
    }).onError((error, stackTrace) {
      emit(CurdErrorState(error: error.toString()));
    });
  }

  void postUsercall(PostUser event, Emitter<CurdApiState> states) async {
    print("hi");
    emit(PostUserLoading(isLoading: true));
    await _apiSerivces
        .addUserService(
      event.title,
      event.description,
      event.isCompleted,
    )
        .then((value) {
      emit(PostUserLoading(
        isLoading: false,
      ));
      add(ReadEvent());
      Future.delayed(
          Duration(
            milliseconds: 500,
          ), () {
        Navigator.pop(event.context);
      });
    }).onError((error, stackTrace) {
      emit(
        CurdErrorState(error: "The value is not valid"),
      );
    });
  }
}
