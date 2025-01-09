import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/textField.dart';
import 'package:flutter_application_1/models/subscription_model.dart';
import 'package:flutter_application_1/screens/subs_screen_list.dart';
import 'package:flutter_application_1/services/database_helper.dart';
import 'package:intl/intl.dart';

class BottomSheetComponent extends StatefulWidget {
  final String id,
      userId,
      accountNumber,
      accountTypeId,
      branchName,
      bankName,
      branchCode,
      accounHolderName,
      currencyId,
      balance,
      cvv,
      cardNumber,
      cardCreationDate,
      cardExpiryDate,
      phoneNumber,
      accountStatusId,
      createdOn,
      emailAddress;

    final bool isFavourite;
  const BottomSheetComponent({
    super.key,
    required this.id,
    required this.userId,
    required this.accountNumber,
    required this.bankName,
    required this.branchCode,
    required this.accounHolderName,
    required this.currencyId,
    required this.balance,
    required this.cvv,
    required this.cardNumber,
    required this.cardCreationDate,
    required this.cardExpiryDate,
    required this.phoneNumber,
    required this.emailAddress,
    required this.isFavourite,
    required this.accountTypeId,
    required this.branchName,
    required this.accountStatusId,
    required this.createdOn,
  });

  @override
  State<BottomSheetComponent> createState() => _BottomSheetComponentState();
}

class _BottomSheetComponentState extends State<BottomSheetComponent> {
  TextEditingController accountHoldnameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController cardNumber = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  final _dbHelper = DatabaseHelper();

  // Function to show date picker
  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime now = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now, // Prevent selecting past dates
      lastDate: DateTime(2100), // You can set a more specific upper limit
    );
    if (pickedDate != null) {
      setState(() {
        // Format the date and update the controller
        controller.text =
            DateFormat('dd/MM/yyyy').format(pickedDate).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.1,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: Colors.grey.shade800),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            TextFieldComponent(
                hintText: widget.accounHolderName,
                controller: accountHoldnameController,
                label: 'Account Holder Name'),
            const SizedBox(
              height: 12,
            ),
            TextFieldComponent(
              controller: accountNumberController,
              label: 'Account Number',
              hintText: widget.accountNumber,
            ),
            const SizedBox(
              height: 12,
            ),
            TextFieldComponent(
              controller: bankNameController,
              label: 'Bank Name',
              hintText: widget.bankName,
            ),
            const SizedBox(
              height: 12,
            ),
            TextFieldComponent(
              controller: cardNumber,
              label: 'Card Number',
              hintText: widget.cardNumber,
            ),
            const SizedBox(
              height: 12,
            ),
            TextFieldComponent(
              controller: phoneNumberController,
              label: 'Phone Number',
              hintText: widget.phoneNumber,
            ),
            const SizedBox(
              height: 12,
            ),
            TextFieldComponent(
              controller: emailAddressController,
              label: 'Email Address',
              hintText: widget.emailAddress,
            ),
            SizedBox(
              height: 12,
            ),
            TextField(
              onTap: () => _selectDate(context, startDateController),
              controller: startDateController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Start Date',
                hintText: 'Tap to select a date',
                filled: true,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              onTap: () => _selectDate(context, expiryDateController),
              controller: expiryDateController,
              readOnly: true,
              decoration: const InputDecoration(
                  labelText: 'Expiry Date',
                  hintText: 'Tap to select a date',
                  filled: true),
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'Is Favourite?',
                  style: TextStyle(color: Colors.white),
                ),
                Checkbox(
                    side: BorderSide(color: Colors.grey.shade300),
                    checkColor: Colors.blue,
                    value: widget.isFavourite,
                    onChanged: (value) {
                      setState(() {
                        widget.isFavourite== value??false;
                      });
                    }),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                _dbHelper.insertUpdatedSubscription(Data(
                  id: widget.id,
                  userId: widget.userId,
                  accountNumber: accountNumberController.text,
                  accountTypeId: widget.accountTypeId,
                  bankName: bankNameController.text,
                  branchName: widget.branchName,
                  branchCode: widget.branchCode,
                  accountHolderName: accountHoldnameController.text,
                  currencyId: widget.currencyId,
                  balance: widget.balance,
                  cvv: widget.cvv,
                  cardNumber: cardNumber.text,
                  cardCreationDate: startDateController.text,
                  cardExpiryDate: expiryDateController.text,
                  phoneNumber: phoneNumberController.text,
                  emailAddress: emailAddressController.text,
                  accountStatusId: widget.accountStatusId,
                  favourite: widget.isFavourite.toString(),
                ));

                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Data Uploaded To Local Database')));
                
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> SubscriptionListScreen()));
              },
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blue,
                ),
                child: const Center(
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'UPDATE',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
