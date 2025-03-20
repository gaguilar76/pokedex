import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pokedex_app/core/utils/strings_app.dart';

class UtilsServices {

    static Future<bool> hasInternet({bool sendMessage = false}) async {
      bool hasInternet = true;
      var result = await Connectivity().checkConnectivity();
      if (result[0].name == ConnectivityResult.mobile.name) {
        debugPrint("Internet connection is from Mobile data");
      } else if (result[0].name == ConnectivityResult.wifi.name) {
        debugPrint("internet connection is from wifi");
      } else if (result[0].name == ConnectivityResult.ethernet.name) {
        debugPrint("internet connection is from wired cable");
      } else if (result[0].name == ConnectivityResult.bluetooth.name) {
        debugPrint("internet connection is from bluethooth threatening");
      } else if (result[0].name == ConnectivityResult.none.name) {
        debugPrint("No internet connection");
        hasInternet = false;
      }
      if (!hasInternet && sendMessage) {
        Get.snackbar(
          'Warning',
          notConectionInternet,
          icon: const Icon(Icons.error, color: Colors.red),
          borderRadius: 20,
          margin: const EdgeInsets.all(15),
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          snackPosition: SnackPosition.TOP,
        );
      }
      return hasInternet;
    }

    static void unfocusKeyboard(BuildContext context) {
      final FocusScopeNode focus = FocusScope.of(context);
      if (!focus.hasPrimaryFocus && focus.hasFocus) {
        FocusManager.instance.primaryFocus?.unfocus();
      }
    }

}