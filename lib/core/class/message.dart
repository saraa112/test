import 'package:flutter/material.dart';

class Message
{
  late  String name;
  late  String  phone;
  late  DateTime time;
  late String sender;
  late var selectedcaliber;
  late var selectedcement;
  late var selectedeffort;
  late var selectedtype;
  late String datetext;
  late String timetext;
  late String volum;


  Message({required this.name,required this.phone,required this.time ,required this.sender,
           this.selectedcaliber,this.selectedcement,this.selectedeffort,
            required this.datetext,required this.timetext,required this.volum,this.selectedtype});

   Map<String,dynamic> toMap()
   {
       return{
         'name':name,
         'phone':phone,
         'time':time,
         'sender':sender,
         'caliber':selectedcaliber,
         'cement':selectedcement,
         'effort':selectedeffort,
         'dateset':datetext,
         'timest':timetext,
         'volum':volum,
         'type':selectedtype
       };
   }
}