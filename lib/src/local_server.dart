import 'dart:async';
import 'dart:io';

class Server {
  static startServer() async {
    HttpServer.bind('localhost', 8000, shared: true).then((HttpServer server) {
      print('[+]WebSocket listening at -- ws://localhost:8000/');
      server.listen((HttpRequest request) {
        WebSocketTransformer.upgrade(request).then((WebSocket ws) {
          ws.listen(
            (data) {
              Timer(Duration(milliseconds: 250), () async {
                if (ws.readyState == WebSocket.open) {
                  print(data);
                  switch (data) {
                    case '{"CMD":{"CONTROL_FSTOP":"?"}}':
                      ws.add(
                          '{"RSP":{"CONTROL_FSTOP":{"CHOICE":["f/4","f/4.5","f/5","f/5.6","f/6.3","f/7.1","f/8","f/9","f/10","f/11","f/13","f/14","f/16","f/18","f/20","f/22"],"CURRENT":"f/5.6"}}}');
                      break;
                    case '{"CMD":{"CONTROL_SHUTTERSPEED":"?"}}':
                      ws.add(
                          '{"RSP":{"CONTROL_SHUTTERSPEED":{"CHOICE":["30","25","20","15","13","10.3","8","6.3","5","4","3.2","2.5","2","1.6","1.3","1","0.8","0.6","0.5","0.4","0.3","1/4","1/5","1/6","1/8","1/10","1/13","1/15","1/20","1/25","1/30","1/40","1/50","1/60","1/80","1/100","1/125","1/160","1/200","1/250","1/320","1/400","1/500","1/640","1/800","1/1000","1/1250","1/1600","1/2000","1/2500","1/3200","1/4000"],"CURRENT":"1/15"}}}');
                      break;
                    case '{"CMD":{"CONTROL_ISO":"?"}}':
                      ws.add(
                          '{"RSP":{"CONTROL_ISO":{"CHOICE":["Auto","L","100","125","160","200","250","320","400","500","640","800","1000","1250","1600","2000","2500","3200","4000","5000","6400","8000","10000","12800","16000","20000","25600","H1","H2"],"CURRENT":"1600"}}}');
                      break;
                    case '{"CMD":{"CONTROL_WHITEBALANCE":"?"}}':
                      ws.add(
                          '{"RSP":{"CONTROL_WHITEBALANCE":{"CHOICE":["AUTO (AU)","DAYLIGHT (DL)","SHADOW (SH) ","CLOUDY (CL)","TUNGSTEN (TN)","FLUORESCENT (FS)","FLASH (FL)","",""],"CURRENT":"DAYLIGHT (DL)"}}}');
                      break;
                    case '{"CMD":{"LIVEVIEW":"START"}}':
                      ws.add(
                          '{"RSP":{"LIVEVIEW":"OK","STREAM":"http://91.133.85.170:8090/cgi-bin/faststream.jpg?stream=half&fps=15"}}');
                      break;
                    // case '{"CMD":{"CAPTURE":"IMAGE"}}':
                    //   await Future.delayed(Duration(seconds: 2), () {
                    //     ws.add({
                    //       "NTF": {
                    //         "CAPTURE": {
                    //           "DELAY": {"H": 0, "M": 0, "S": 0},
                    //           "MULTISHOTS": -3
                    //         }
                    //       }
                    //     });
                    //   });
                    //   await Future.delayed(Duration(seconds: 2), () {
                    //     ws.add({
                    //       "NTF": {
                    //         "CAPTURE": {
                    //           "DELAY": {"H": 0, "M": 0, "S": 0},
                    //           "MULTISHOTS": -2
                    //         }
                    //       }
                    //     });
                    //   });

                    //   await Future.delayed(Duration(seconds: 2), () {
                    //     ws.add({
                    //       "NTF": {
                    //         "CAPTURE": {
                    //           "DELAY": {"H": 0, "M": 0, "S": 0},
                    //           "MULTISHOTS": -1
                    //         }
                    //       }
                    //     });
                    //   });
                    //   ws.add({
                    //     "RSP": {"CAPTURE": "OK"}
                    //   });
                    //   break;
                    default:
                      print('default');
                      break;
                  }
                  // checking connection state helps to avoid unprecedented errors
                }
              });
            },
            onDone: () => print('[+]Done :)'),
            onError: (err) => print('[!]Error -- ${err.toString()}'),
            cancelOnError: true,
          );
        }, onError: (err) => print('[!]Error -- ${err.toString()}'));
      }, onError: (err) => print('[!]Error -- ${err.toString()}'));
    }, onError: (err) => print('[!]Error -- ${err.toString()}'));
  }
}
