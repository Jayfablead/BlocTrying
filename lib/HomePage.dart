import 'package:bloctry/blocs/internetBloc/internetBloc.dart';
import 'package:bloctry/blocs/internetBloc/internetState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc Test'),
        centerTitle: true,
      ),
      body: Center(
        child: BlocConsumer<InternetBloc, InternetState>(
          listener: (context, state) {
            if (state is InternetGetState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Internet Connected'),
                    backgroundColor: Colors.lightGreen),
              );
            } else if (state is InternetLostState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Internet Disonnected'),
                    backgroundColor: Colors.red),
              );
            }
          },
          builder: (context, state) {
            if (state is InternetGetState) {
              return Text(
                'Connected',
                style: TextStyle(fontSize: 18),
              );
            } else if (state is InternetLostState) {
              return Text(
                'Not Connected',
                style: TextStyle(fontSize: 18),
              );
            }
            return Text(
              'Loading...',
              style: TextStyle(fontSize: 18),
            );
          },
        ),
        // child: BlocBuilder<InternetBloc, InternetState>(
        //   builder: (context, state) {

        // ),
      ),
    );
  }
}
