import 'package:bloc_api_call_curd_app/application/curd_api_bloc/bloc/curd_api_bloc.dart';
import 'package:bloc_api_call_curd_app/presentation/model/user_model.dart';
import 'package:bloc_api_call_curd_app/utils/snack/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateUsers extends StatefulWidget {
  final Data data;
  const UpdateUsers({required this.data, super.key});

  @override
  State<UpdateUsers> createState() => _UpdateUsersState();
}

class _UpdateUsersState extends State<UpdateUsers> {
  final TextEditingController _titileController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late Data user;

  @override
  void initState() {
    _descriptionController.text = widget.data.descripition;
    _titileController.text = widget.data.title;
    super.initState();
  }

  @override
  void dispose() {
    _titileController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add User"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _titileController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                hintText: "User name"),
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            controller: _descriptionController,
            onChanged: (value) {
              print(value);
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                hintText: "Description"),
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {
              if (_titileController.text.isEmpty) {
                snackBar(context, "Please input your email");
              } else if (_descriptionController.text.isEmpty) {
                snackBar(context, "please input you description");
              } else {
                context.read<CurdApiBloc>().add(
                      UpdateUser(
                        id: widget.data.id,
                        title: _titileController.text,
                        description: _descriptionController.text,
                        isCompleted: false,
                        context: context,
                      ),
                    );
              }
            },
            child: BlocBuilder<CurdApiBloc, CurdApiState>(
              builder: (context, state) {
                if (state is PostUserLoading) {
                  print("working");
                  bool isLoading = state.isLoading;
                  return isLoading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text("Add user");
                } else {
                  print("not working");
                  return Text("Add User");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
