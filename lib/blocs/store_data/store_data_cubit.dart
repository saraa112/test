import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/class/message.dart';
part 'store_data_state.dart';

class StoreDataCubit extends Cubit<StoreDataState> {
  StoreDataCubit() : super(StoreDataInitial());

  Stream? streamStudents;
  String? userEmail;
   var user;

  static StoreDataCubit get(context)=>BlocProvider.of(context);

     sendData(String name , String phone , DateTime now,var caliber,
            var cement , var effort,String datetext,String timetext,String volum,String selectedtype)
    {
      userEmail=FirebaseAuth.instance.currentUser!.email;
      emit(StoreDataLoadingState());
       Message message=Message(name: name, phone: phone , time :now,sender: userEmail!,
                              selectedcaliber:caliber,selectedcement:cement ,selectedeffort:effort ,
                                datetext: datetext , timetext: timetext,volum: volum,
                              selectedtype: selectedtype);
       FirebaseFirestore.instance.
       collection('students').add(message.toMap()).
       then((value) {
        emit(StoreDataSuccessState());
       });
    }

        receiveStudent()
        {
         streamStudents= FirebaseFirestore.instance.collection('students').
          orderBy('time').snapshots();
         emit(StoreDataReceiveStudentsState());
        }

    getUserData()
   {
      user=FirebaseAuth.instance.currentUser;
      emit(StoreDataGetUserDataState());
   }
}
