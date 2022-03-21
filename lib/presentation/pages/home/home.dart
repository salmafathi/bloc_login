import 'package:bloc_login/data/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/blocs/auth/bloc/auth_shared_bloc.dart';
import '../../../logic/blocs/auth/bloc/auth_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthSharedBloc, AuthState>(
      listener: (context, state){
        if(state is AuthInitial)
          {
            Navigator.of(context).pushNamedAndRemoveUntil("/",(route) => false);
          }
      },
      builder :(context, state){
        return Scaffold(
          endDrawerEnableOpenDragGesture: false,
          backgroundColor: const Color(0xFFfcfcfc),
          appBar:  AppBar(
            title: const Text("Auric", style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'UniNeue'),),
            backgroundColor: const Color(0xFF53C1E9),
            elevation: 0,
          ),
          body:Column(
            children:  [
               const Center(child:  Text("Auric Home"),),
              TextButton(onPressed: (){
                BlocProvider.of<AuthSharedBloc>(context)
                    .add(const AuthLogoutRequested(TOKEN));
              }, child: const Text('Sign Out'))
            ],
          ) ,
        ) ;
      },
    );
  }
}

