import 'dart:io';

class InternetConnectionCheck {
  static final InternetConnectionCheck _singleton = InternetConnectionCheck._internal();

  factory InternetConnectionCheck() {
  return _singleton;
  }

  InternetConnectionCheck._internal();

  Stream<String> checkInternet() async* {
    while(true){
      try {
        await Future.delayed(Duration(seconds: 10));
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          yield 'Connected';
        }
      } on SocketException catch (_) {
        yield 'Not Connected';
      }
    }

  }


}