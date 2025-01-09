import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/textField.dart';
import 'package:flutter_application_1/models/subscription_model.dart';
import 'package:flutter_application_1/services/api_services.dart';
import 'package:flutter_application_1/services/database_helper.dart';
import 'package:flutter_application_1/services/timer_service.dart';
import 'package:get/get.dart';

class SubscriptionFormScreen extends StatefulWidget {
  @override
  _SubscriptionFormScreenState createState() => _SubscriptionFormScreenState();
}

class _SubscriptionFormScreenState extends State<SubscriptionFormScreen> {
  TextEditingController userIdController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController branchNameController = TextEditingController();
  TextEditingController accountHolderNamerController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _apiService = ApiService();
  final _dbHelper = DatabaseHelper();
  TimerService controller = Get.put(TimerService());
  Data? data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Add Subscription',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => ListView(
                  children: [
                    TextFieldComponent(
                        controller: userIdController,
                        label: 'User ID',
                        hintText: 'Enter user id here'),
                    SizedBox(height: 5),
                    TextFieldComponent(
                        controller: accountNumberController,
                        label: 'Account Number',
                        hintText: 'Enter account number here'),
                    SizedBox(height: 5),
                    TextFieldComponent(
                        controller: bankNameController,
                        label: 'Bank Name',
                        hintText: 'Enter Bank Name here'),
                    SizedBox(height: 5),
                    TextFieldComponent(
                        controller: branchNameController,
                        label: 'Branch Name',
                        hintText: 'Enter Branch Name here'),
                    SizedBox(height: 5),
                    TextFieldComponent(
                        controller: accountHolderNamerController,
                        label: 'Account Holder',
                        hintText: 'Enter Account Holder Name here'),
                    SizedBox(height: 5),
                    TextFieldComponent(
                        controller: phoneNumberController,
                        label: 'Phone Number',
                        hintText: 'Enter Your phone number here'),
                    TextFieldComponent(
                        controller: emailAddressController,
                        label: 'Email Address',
                        hintText: 'Enter email Address here'),
                    SizedBox(height: 20),
                
                    // Wrap the ElevatedButton in Obx to listen for changes to isConnected
                    
                       ElevatedButton(
                        onPressed: () {
                          if (controller.isConnected.value==false) {
                            _submitForm();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Details Submitted to Api'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please connect to the internet to submit details',
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text('Submit'),
          )
           ] )
        ),
      ));
    
  }


  void _submitForm() async {
    try {
      // Save to API
     
      final apiSuccess = await _apiService.createSubscription(Data(
            userId: userIdController.text.toString().trim(),
            accountNumber: accountNumberController.text.toString().trim(),
            bankName: bankNameController.text.toString().trim(),
            branchCode: branchNameController.text.toString().trim(),
            accountHolderName: accountHolderNamerController.text.toString().trim(),
            phoneNumber: phoneNumberController.text.toString().trim(),
            emailAddress: emailAddressController.text.toString().trim(),
            branchName: branchNameController.text.toString().trim(),
            balance: '',
            accountStatusId: '',
            accountTypeId: '',
            id: '',
            cvv: '',
            favourite: '',
            cardCreationDate: '',
            cardExpiryDate: '',
            cardNumber: ''));
      if (apiSuccess) {
        print ('Data: $data');
        // Save to SQLite only if API succeeds
        await _dbHelper.insertSubscription(Data(
          userId: userIdController.text,
          accountNumber: accountNumberController.text,
          bankName: bankNameController.text,
          branchCode: branchNameController.text,
          accountHolderName: accountHolderNamerController.text,
          phoneNumber: phoneNumberController.text,
          emailAddress: emailAddressController.text,
          branchName: branchNameController.text,
        ));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Subscription added successfully!')),
        );
        Navigator.pop(context); // Go back to the previous screen
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save subscription to API')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}

