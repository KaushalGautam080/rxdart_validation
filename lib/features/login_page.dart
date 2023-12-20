import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rs_dart_form_validator/cubit/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final AuthCubit authCubit;
  @override
  void initState() {
    super.initState();
    authCubit = BlocProvider.of<AuthCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login using RxDart"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StreamBuilder(
                stream: authCubit.nameStream,
                builder: (context, snapshot) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "USername",
                        ),
                        onChanged: (text) {
                          authCubit.updateName(text);
                        },
                      ),
                      if (snapshot.hasError)
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 3),
                          child: Text(
                            snapshot.error.toString(),
                          ),
                        ),
                    ],
                  );
                }),
            StreamBuilder(
                stream: authCubit.phoneStream,
                builder: (context, snapshot) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: "phonenumber",
                            errorStyle: TextStyle(color: Colors.red),
                            errorText: snapshot.hasError
                                ? snapshot.error.toString()
                                : null),
                        onChanged: (value) {
                          authCubit.updatePhone(value);
                        },
                      ),
                      if (snapshot.hasError)
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 3),
                          child: Text(
                            snapshot.error.toString(),
                          ),
                        ),
                    ],
                  );
                }),
            const SizedBox(
              height: 50,
            ),
            StreamBuilder(
                stream: authCubit.buttonValid,
                builder: (context, snapshot) {
                  return InkWell(
                    onTap: () {
                      authCubit.checkUserValidation();
                      authCubit.checkPhoneValidation();
                      if (snapshot.hasData) {
                        authCubit.onNext();
                      }
                    },
                    child: Container(
                      height: 40,
                      width: 80,
                      color: Colors.amber,
                      child: const Center(
                        child: Text("Login"),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
