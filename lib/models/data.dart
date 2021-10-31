import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Data extends ChangeNotifier {
  Map _response = {'proximos': {}, 'ultimos': {}, 'tabela': []};

  consultData() async {
    try {
      var _url = Uri.parse(dotenv.env['HOST_API'].toString());
      var data = await http.get(_url);

      if (data.statusCode == 200) {
        var jsonResponse = jsonDecode(data.body);

        _response['proximos'] = jsonResponse['proximos'];
        _response['ultimos'] = jsonResponse['ultimos'];
        _response['tabela'] = jsonResponse['tabela'];

      } else {
        throw('error');
      }

    } catch (e) {
      throw('error ${e}');
    }

    notifyListeners();
  }

  Map get res => _response;
}