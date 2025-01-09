import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/bottomsheet.dart';

class SubscriptionDetailsPage extends StatefulWidget {
  final String id,
      userId,
      accountNumber,
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
      accountTypeId,
      accountStatusId,
      createdOn,
      branchName,
      emailAddress;

  const SubscriptionDetailsPage(
      {super.key,
      required this.id,
      required this.userId,
      required this.accountNumber,
      required this.bankName,
      required this.branchCode,
      required this.accounHolderName,
      required this.currencyId,
      required this.cardNumber,
      required this.cardCreationDate,
      required this.cardExpiryDate,
      required this.phoneNumber,
      required this.emailAddress,
      required this.balance,
      required this.cvv, required this.accountTypeId, required this.accountStatusId, required this.createdOn, required this.branchName});

  @override
  State<SubscriptionDetailsPage> createState() =>
      _SubscriptionDetailsPageState();
}

class _SubscriptionDetailsPageState extends State<SubscriptionDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        leading: Icon(Icons.arrow_back,color: Colors.white,),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.1,
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  boxShadow: [
                    //darker shadow on bottom right
                    BoxShadow(
                        color: Colors.grey.shade800,
                        blurRadius: 15,
                        offset: const Offset(4, 4)),

                    //lighter shadow on top left
                    const BoxShadow(
                        color: Colors.black,
                        blurRadius: 15,
                        offset: const Offset(-4, -4))
                  ],
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.shade900),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Account Holder Name',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Unknown',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade500),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      'Account Number',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '----------',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade500),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      'Bank Name ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Unknown',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade500),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      'Card Creation Date',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Unknown',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade500),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      'Card Expiry Date',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '----------',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade500),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      'Card Number ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Unknown',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade500),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      'Balance',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Unknown',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade500),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      'Email Address',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '----------',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade500),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      'Phone Number ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Unknown',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade500),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'View Payment History For this Subscription',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                                decoration: TextDecoration.underline,
                                decorationThickness: 2,
                                decorationColor: Colors.blue),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.blue),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 10),
                            child: Text(
                              'Edit',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.blue),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 10),
                            child: Text(
                              'Update',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.grey.shade800,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(15)),
                        ),
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: BottomSheetComponent(
                              id: widget.id,
                              userId: widget.userId,
                              accountNumber: widget.accountNumber,
                              bankName: widget.bankName,
                              branchCode: widget.branchCode,
                              accounHolderName: widget.accounHolderName,
                              currencyId: widget.currencyId,
                              balance: widget.balance,
                              cvv: widget.cvv,
                              cardNumber: widget.cardNumber,
                              cardCreationDate: widget.cardCreationDate,
                              cardExpiryDate: widget.cardExpiryDate,
                              phoneNumber: widget.phoneNumber,
                              emailAddress: widget.emailAddress,
                              isFavourite: false, 
                              accountTypeId: widget.accountTypeId, 
                              accountStatusId: widget.accountStatusId, 
                              branchName: widget.branchName, 
                              createdOn: widget.createdOn,
                              
                            ),
                          ); // Your custom bottom sheet
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.blue)),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Add Payment',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
