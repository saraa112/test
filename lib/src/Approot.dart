
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/log_in/login_cubit.dart';
import '../blocs/store_data/store_data_cubit.dart';
import '../view/screen/onboarding.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context)=>StoreDataCubit()..receiveStudent()),
          BlocProvider(create: (context)=>LoginCubit()),
        ],

        child: MaterialApp(
          home: OnBoarding(),
          debugShowCheckedModeBanner: false,
        ));

  }
}
