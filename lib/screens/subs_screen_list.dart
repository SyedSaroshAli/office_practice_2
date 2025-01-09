import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/subscription_model.dart';
import 'package:flutter_application_1/screens/details_screen.dart';
import 'package:flutter_application_1/services/timer_service.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/screens/subscription_form_screen.dart';


class SubscriptionListScreen extends StatefulWidget {
  @override
  _SubscriptionListScreenState createState() => _SubscriptionListScreenState();
}

class _SubscriptionListScreenState extends State<SubscriptionListScreen> {
 
  final timerService = TimerService();
  final controller = Get.put(TimerService());

 

  @override
  void initState() {
    super.initState();
    timerService.listenToInternetChanges(context: context);
    timerService.startRealTimeTimer(context: context);
     ever(timerService.subscriptions, (_) {
      setState(() {}); // Updates the UI whenever subscriptions change
    });
    
  }

  @override
  void dispose() {
    timerService.timer?.cancel();
    timerService.streamSubscription?.cancel();
    super.dispose();
  }



 
  
  // void _listenToInternetChanges() {
  //   streamSubscription = InternetConnection().onStatusChange.listen((event) {
  //     if (event == InternetStatus.connected) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('You are Connected to Internet')));

  //       setState(() => isConnected = true);
  //     } else {
  //       showDialog(
  //           context: context,
  //           builder: (context) {
  //             return AlertDialog(
  //               title: const Text('Internet Error'),
  //               content: const Text('Internet Not connected'),
  //               actions: [
  //                 GestureDetector(
  //                     onTap: () {
  //                       Navigator.pop(context);
  //                     },
  //                     child: const Text('Ok'))
  //               ],
  //             );
  //           });
  //       setState(() => isConnected = false);
  //     }
  //   });
  // }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title:const  Text(
          'Subscriptions List',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.info,
              color: Colors.grey.shade400,
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      content: const Text(
                          'Your Local database is synced to API every 15 minutes. Do you want to sync now ?'),
                      actions: [
                        GestureDetector(
                          onTap: () {
                            controller.checkInternetThenGet(context: context);
                            Navigator.pop(context);
                          },
                          child: Text('Yes'),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text('No'),
                        ),
                      ],
                    );
                  });
            },
          ),
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.grey.shade400,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SubscriptionFormScreen()),
              );
            },
          ),
        ],
      ),
      body: Obx((){
        if(controller.subscriptions.isEmpty){
          return const  Center(child: Text('No subscriptions found.',style: TextStyle(color: Colors.white),));
        }
        return  ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              itemCount: controller.subscriptions.length,
              itemBuilder: (context, index) {
                final subscription = controller.subscriptions[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, (MaterialPageRoute(builder: (context)=> SubscriptionDetailsPage(
                      id:  subscription.id.toString(), 
                      userId: subscription.userId.toString(), 
                      accountNumber: subscription.accountNumber.toString(), 
                      bankName: subscription.bankName.toString(), 
                      branchCode: subscription.branchCode.toString(), 
                      accounHolderName: subscription.accountHolderName.toString(), 
                      currencyId: subscription.currencyId.toString(), 
                      cardNumber: subscription.cardNumber.toString(), 
                      cardCreationDate: subscription.cardCreationDate.toString(),
                       cardExpiryDate: subscription.cardExpiryDate.toString(), 
                       phoneNumber: subscription.phoneNumber.toString(), 
                       emailAddress: subscription.emailAddress.toString(), 
                       balance: subscription.balance.toString(), 
                       cvv: subscription.cvv.toString(), 
                       accountTypeId: subscription.accountTypeId.toString(), 
                       accountStatusId: subscription.accountStatusId.toString(), 
                       createdOn: subscription.createdOn.toString(), 
                       branchName: subscription.branchName.toString()))));
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(15),
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
                          subscription.accountHolderName ?? 'Unknown',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade500),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        const Text(
                          'Account Number',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                           subscription.accountNumber?? '----------',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade500),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        const Text(
                          'Bank Name ',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          subscription.bankName ?? 'Unknown',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade500),
                        ),
                        const SizedBox(
                          height: 3,
                        )
                      ],
                    ),
                  ),
                );
              },
            );
      })
     
    );
  }
  }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/models/subscription_model.dart';
// import 'package:flutter_application_1/screens/details_screen.dart';
// import 'package:flutter_application_1/screens/subscription_form_screen.dart';
// import 'package:flutter_application_1/services/timer_service.dart';
// import 'package:get/get.dart';

// class SubscriptionListScreen extends StatefulWidget {
//   @override
//   _SubscriptionListScreenState createState() => _SubscriptionListScreenState();
// }

// class _SubscriptionListScreenState extends State<SubscriptionListScreen> {
//   final TimerService timerService = Get.put(TimerService());

//   @override
//   void initState() {
//     super.initState();
//     timerService.listenToInternetChanges();
//     timerService.startRealTimeTimer(context: context);
//     ever(timerService.subscriptions, (_) {
//       setState(() {}); // Updates the UI whenever subscriptions change
//     });
//   }

//   @override
//   void dispose() {
//     timerService.stopTimer();
//     timerService.streamSubscription!.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade900,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         title: const Text(
//           'Subscriptions List',
//           style: TextStyle(color: Colors.white),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.info, color: Colors.grey.shade400),
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (_) {
//                   return AlertDialog(
//                     content: const Text(
//                         'Your Local database is synced to API every 15 minutes. Do you want to sync now?'),
//                     actions: [
//                       GestureDetector(
//                         onTap: () {
//                           timerService.checkInternetThenGet(context: context);
//                           Navigator.pop(context);
//                         },
//                         child: const Text('Yes'),
//                       ),
//                       GestureDetector(
//                         onTap: () => Navigator.pop(context),
//                         child: const Text('No'),
//                       ),
//                     ],
//                   );
//                 },
//               );
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.add, color: Colors.grey.shade400),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => SubscriptionFormScreen()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Obx(() {
//         if (timerService.subscriptions.isEmpty) {
//           return const Center(child: Text('No subscriptions found.'));
//         }
//         return ListView.builder(
//           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//           itemCount: timerService.subscriptions.length,
//           itemBuilder: (context, index) {
//             final subscription = timerService.subscriptions[index];
//             return GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => SubscriptionDetailsPage(
//                       id: subscription.id.toString(),
//                       userId: subscription.userId.toString(),
//                       accountNumber: subscription.accountNumber.toString(),
//                       bankName: subscription.bankName.toString(),
//                       branchCode: subscription.branchCode.toString(),
//                       accounHolderName: subscription.accountHolderName.toString(),
//                       currencyId: subscription.currencyId.toString(),
//                       cardNumber: subscription.cardNumber.toString(),
//                       cardCreationDate: subscription.cardCreationDate.toString(),
//                       cardExpiryDate: subscription.cardExpiryDate.toString(),
//                       phoneNumber: subscription.phoneNumber.toString(),
//                       emailAddress: subscription.emailAddress.toString(),
//                       balance: subscription.balance.toString(),
//                       cvv: subscription.cvv.toString(),
//                       accountTypeId: subscription.accountTypeId.toString(),
//                       accountStatusId: subscription.accountStatusId.toString(),
//                       createdOn: subscription.createdOn.toString(),
//                       branchName: subscription.branchName.toString(),
//                     ),
//                   ),
//                 );
//               },
//               child: SubscriptionCard(subscription: subscription),
//             );
//           },
//         );
//       }),
//     );
//   }
// }

// class SubscriptionCard extends StatelessWidget {
//   final Data subscription;

//   const SubscriptionCard({required this.subscription});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       padding: const EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//               color: Colors.grey.shade800, blurRadius: 15, offset: const Offset(4, 4)),
//           const BoxShadow(
//               color: Colors.black, blurRadius: 15, offset: const Offset(-4, -4))
//         ],
//         borderRadius: BorderRadius.circular(15),
//         color: Colors.grey.shade900,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text('Account Holder Name', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
//           Text(subscription.accountHolderName ?? 'Unknown', style: TextStyle(color: Colors.grey.shade500)),
//           const SizedBox(height: 3),
//           const Text('Account Number', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
//           Text(subscription.accountNumber ?? '----------', style: TextStyle(color: Colors.grey.shade500)),
//           const SizedBox(height: 3),
//           const Text('Bank Name', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
//           Text(subscription.bankName ?? 'Unknown', style: TextStyle(color: Colors.grey.shade500)),
//         ],
//       ),
//     );
//   }
// }