import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());


  static LoginCubit get(context)=>BlocProvider.of(context);

   registerWithEmailAndPassword(String email,String password)
      {
        emit(LoginLoadingState());
       FirebaseAuth.instance.createUserWithEmailAndPassword
       (email: email, password: password).then((value) {
         emit(LoginSuccessState());
       });
      }

   signInWithEmailAndPassword(String email,String password)
     {
       emit(LoginLoadingState());
      FirebaseAuth.instance.signInWithEmailAndPassword
      (email: email, password: password).then((value) {
        emit(LoginSuccessState());
      }).catchError((error){
        print('error erroris  error erroris ${error.toString()}');
        emit(LoginErrorStete());
      });
     }

  Future<void> logOut()
  async{
    await FirebaseAuth.instance.signOut();
  }


}
