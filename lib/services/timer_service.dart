import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/models/subscription_model.dart';
import 'package:flutter_application_1/widgets/alert_dialog.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/services/api_services.dart';
import 'package:flutter_application_1/services/database_helper.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class TimerService extends GetxController {
  final ApiService _apiService = ApiService();
  final DatabaseHelper _dbHelper = DatabaseHelper();
  Timer? timer;
  RxBool isConnected = false.obs;
  RxList <Data>subscriptions =<Data>[].obs;
  StreamSubscription? streamSubscription;

 void startRealTimeTimer({required context}) async {

    // Perform the API call immediately when the app starts if connected to the internet
    final prefs = await SharedPreferences.getInstance();
    final lastApiCall = prefs.getInt('lastApiCall') ?? 0;
    final currentTime = DateTime.now().millisecondsSinceEpoch;

    if (lastApiCall == 0 && isConnected.value) {
      _fetchDataFromApiAndUpdateDatabase();
      await prefs.setInt('lastApiCall', currentTime);
    } else if (lastApiCall == 0 && isConnected.value == false) {
      _fetchDataFromDatabase();
    }
    
    timer = Timer.periodic(const Duration(minutes: 1), (_) async {
      final prefs = await SharedPreferences.getInstance();
      final updatedLastApiCall = prefs.getInt('lastApiCall') ?? 0;
      final updatedCurrentTime = DateTime.now().millisecondsSinceEpoch;

      if (updatedCurrentTime - updatedLastApiCall >= 15 * 60 * 1000 &&
          isConnected.value == true) {
        _fetchDataFromApiAndUpdateDatabase();
        fetchDataFromUpdatedTableAndUploadToApi();
        _dbHelper.deleteAllUpdatedSubscriptions();
       // fetchDataFromDeletedTableAndDeleteFromAPI();
        //_dbHelper.deleteAllDeletedSubscriptions();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('15 min passed: Api get call executed')));
        await prefs.setInt('lastApiCall', currentTime);
      } else if (currentTime - lastApiCall < 15 * 60 * 1000) {
        _fetchDataFromDatabase();
      }
    });
  }


  void listenToInternetChanges({required  BuildContext context}) {

       streamSubscription = InternetConnection().onStatusChange.listen((event) {
      if (event == InternetStatus.connected) {
           _fetchDataFromApiAndUpdateDatabase();
           AlertDialogWidget(title: "Internet", content: "You are Back Online", buttonText: "Ok",context1: context,);
          print('Internet is connected');
          isConnected.value=true;
      } else {
           AlertDialogWidget(title: "Internet", content: "You are Back Online", buttonText: "Ok",context1: context,);
         print('Internet is not connected');
         isConnected.value = false;
      }
    
  });
  }
  

  void stopTimer() {
    timer?.cancel();
  }


    _fetchDataFromApiAndUpdateDatabase() async {
  
      final apiData = await _apiService.fetchSubscriptions();
      if (apiData.data != null) {
        for (var item in apiData.data!) {
          await _dbHelper.deleteSubscription(item.id!);
          await _dbHelper.insertSubscription(item);
          subscriptions.value =  apiData.data!;
        }
        subscriptions.value =  apiData.data!;
       // return apiData.data!;
      }
   
  }

  _fetchDataFromDatabase() async {
    final localData = await _dbHelper.getAllSubscriptions();
    subscriptions.value= localData;
    //return localData;
  }

  fetchDataFromUpdatedTableAndUploadToApi()async{
    final List<Data> updatedData =await _dbHelper.getAllUpdatedSubscriptions();
    for (var item in updatedData){
      await _apiService.updateSubscription(item.id.toString(), item);
    }

  }

  fetchDataFromDeletedTableAndDeleteFromAPI()async{
    final List<Data> deletedData =await _dbHelper.getAllDeletedSubscriptions();
    for(var item in deletedData){
      await _apiService.deleteSubscription(item.id.toString());
    }
  }

  checkInternetThenGet({required context}){
    if(isConnected.value){
       _fetchDataFromApiAndUpdateDatabase();
        fetchDataFromUpdatedTableAndUploadToApi();
        _dbHelper.deleteAllUpdatedSubscriptions();
        fetchDataFromDeletedTableAndDeleteFromAPI();
        _dbHelper.deleteAllDeletedSubscriptions();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Data Synced to Api')));
    }
    else {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please Turn on Internet Connection to Sync')));
    }
  }


}
