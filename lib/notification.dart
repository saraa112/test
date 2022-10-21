
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'core/enums/toast_states.dart';
import 'core/toast/toast_config.dart';
import 'notification_messages.dart';



Future<void> messageHandler(RemoteMessage message) async {
  Data notificationMessage = Data.fromJson(message.data);
  print('notification from background : ${notificationMessage.title}');
  ToastConfig.showToast(msg:"${notificationMessage.title}", toastStates:ToastStates.Success);
  print("ya raaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab");
}

void firebaseMessagingListener() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    Data notificationMessage = Data.fromJson(message.data);
    print('notification from foreground : ${notificationMessage.title}');
    print('notification from background : ${notificationMessage.title}');
    ToastConfig.showToast(msg:"${notificationMessage.title}", toastStates:ToastStates.Success);

  });
}

Future<void> sendNotification() async {
  const postUrl = 'https://fcm.googleapis.com/fcm/send';
  Dio dio = Dio();

  var token = await getDeviceToken();
  print('device token : $token');


  final data = {

    "data": {
      "message": "Accept Ride Request",
      "title": "This is Ride Request",
    },
    "to": token
  };

  dio.options.headers['Content-Type'] = 'application/json';
  dio.options.headers["Authorization"] = 'key=AAAA-d63dRI:APA91bHZwAyE01ed9X0k9Q-K0zF4Ce4TwJX6FVPhfZZvG5QMlwvcQAlJIrTiq1PQaOV8CNTePH6nMYe2AWvC5wF7ZAiKz6BxiJa57d4vwD0VyPwx-p7w8WF4B67rnf1OW2uyGY5anrxj';

  try {
    final response = await dio.post(postUrl, data: data);

    if (response.statusCode == 200) {
      print('Request Sent To Driver');
    } else {
      print('notification sending failed');
    }
  } catch (e) {
    print('exception $e');
  }
}

Future<String?> getDeviceToken()  async{
  return await FirebaseMessaging.instance.getToken();
}
