import 'package:bloc_api_call_curd_app/application/curd_api_bloc/bloc/curd_api_bloc.dart';
import 'package:bloc_api_call_curd_app/presentation/add_user.dart';
import 'package:bloc_api_call_curd_app/presentation/update_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    context.read<CurdApiBloc>().add(ReadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: BlocBuilder<CurdApiBloc, CurdApiState>(
        builder: (context, state) {
          if (state is CurdApiInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CurdErrorState) {
            String error = state.error;
            return Center(
              child: Text(error),
            );
          } else if (state is ReadUserState) {
            var data = state.userModel;
            return ListView.builder(
              itemCount: data.data.length,
              itemBuilder: (context, index) {
                print(data.data.runtimeType);
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                  ),
                  title: Text(data.data[index].title),
                  subtitle: Text(data.data[index].id),
                  trailing: PopupMenuButton(
                    onSelected: (value) {
                      if (value == 'delete') {
                        context.read<CurdApiBloc>().add(DeleteUserEvent(
                            id: data.data[index].id, context: context));
                      } else if (value == 'edit') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  UpdateUsers(data: data.data[index]),
                            ));
                      }
                    },
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          child: Text('delete'),
                          value: 'delete',
                        ),
                        PopupMenuItem(
                          child: Text('Edit'),
                          value: 'edit',
                        ),
                      ];
                    },
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddUser(),
              ));
        },
        label: Text("add Navigate"),
      ),
    );
  }
}
