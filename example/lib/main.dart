import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'package:voice/proxy.dart';
import 'package:voice/voice.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final voice = Voice();
  String? pid;
  final _random = Random();
  String? port;
  String? name;
  String host = '121.37.139.13';
  bool status = false;

  @override
  void initState() {
    super.initState();
    port = next(1000, 9999).toString();
    String uuid = const Uuid().v1();
    name = uuid.split("-")[0];
  }

  int next(int min, int max) {
//将 参数min + 取随机数（最大值范围：参数max -  参数min）的结果 赋值给变量 result;
    var result = min + _random.nextInt(max - min);
//返回变量 result 的值;
    return result;
  }

  Future<int> checkProxy(String s) async {
    HttpClient httpClient = HttpClient();
    HttpClientRequest request =
        await httpClient.getUrl(Uri.parse("https://www.baidu.com"));
    //使用iPhone的UA
    request.headers.add(
      "user-agent",
      "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1",
    );
    var proxy = "PROXY $host:$port";
    httpClient.findProxy = (uri) {
      // 如果需要过滤uri，可以手动判断
      return proxy;
    };
    HttpClientResponse response = await request.close();
    var status = response.statusCode;
    httpClient.close();
    print(status);
    return status;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('冬瓜嗅探'),
        ),
        body: Center(
          child: status
              ? FloatingActionButton.extended(
                  onPressed: () async {
                    Clipboard.setData(ClipboardData(text: "$host:${port!}"));
                  },
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  icon: const Icon(Icons.copy),
                  label: Text("端口$port"),
                )
              : FloatingActionButton.extended(
                  onPressed: () async {
                    pid = await voice.run(Proxy(
                      port,
                      host,
                      name,
                    ));


                    Timer.periodic(const Duration(seconds: 2), (timer) async {
                      int code = await checkProxy("");
                      if (code == 200) {
                        timer.cancel();
                        setState(() {
                          status = true;
                        });
                      }
                    });
                  },
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  icon: const Icon(Icons.not_started_rounded),
                  label: const Text("启动"),
                ),
        ),
        // body: Center(
        //   child: Column(
        //     children: [
        //       // const Text('输入链接'),
        //       // const TextField(),
        //
        //       // FloatingActionButton.extended(
        //       //   onPressed: () async {
        //       //     var status = await voice.downApp(pid ?? "");
        //       //     print(status);
        //       //   },
        //       //   backgroundColor: Colors.redAccent,
        //       //   foregroundColor: Colors.white,
        //       //   icon: const Icon(Icons.stop_circle_rounded),
        //       //   label: const Text("暂停"),
        //       // ),
        //       // TextButton(onPressed: () {}, child: const Text('get'))
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
