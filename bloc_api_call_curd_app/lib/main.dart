import 'package:bloc_api_call_curd_app/application/curd_api_bloc/bloc/curd_api_bloc.dart';
import 'package:bloc_api_call_curd_app/presentation/home_screen.dart';
import 'package:bloc_api_call_curd_app/service/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final RestApiSerivces services = RestApiSerivces();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CurdApiBloc(services),
        ),
      ],
      child: MaterialApp(
        home: HomeView(),
      ),
    ),
  );
}
