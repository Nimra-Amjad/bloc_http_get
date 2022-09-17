// ignore_for_file: prefer_const_constructors

import 'dart:html';

import 'package:bloc_http_get/blocs/internet_bloc/internet_bloc.dart';
import 'package:bloc_http_get/blocs/internet_bloc/internet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BlocConsumer<InternetBloc, InternetState>(
            listener: (context, state) {
              if (state is InternetGainState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Internet Connected!"),
                  backgroundColor: Colors.green,
                ));
              } else if (state is InternetLostState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Internet not Connected!"),
                  backgroundColor: Colors.red,
                ));
              }
            },
            builder: (context, state) {
              if (state is InternetGainState) {
                return Text("Connected!");
              } else if (state is InternetLostState) {
                return Text("Not Connected");
              } else {
                return Text("loading....");
              }
            },
          ),
        ),
        // child: Center(child: BlocBuilder<InternetBloc, InternetState>(
        //   builder: (context, state) {
        //     if (state is InternetGainState) {
        //       return Text("Connected!");
        //     } else if (state is InternetLostState) {
        //       return Text("Not Connected");
        //     } else {
        //       return Text("Loading...");
        //     }
        //   },
        // )),
      ),
    );
  }
}
