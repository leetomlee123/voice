import 'dart:isolate';

import 'package:flutter/services.dart';

class Proxy{
  String? port;
  String? ip;
  String? name;

  Proxy(this.port, this.ip, this.name);
}

