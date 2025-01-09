class Subscriptions {
  List<Data>? data;
  bool? success;

  Subscriptions({this.data, this.success});

  Subscriptions.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}

class Data {
  String? id;
  String? userId;
  String? accountNumber;
  String? accountTypeId;
  String? bankName;
  String? branchName;
  String? branchCode;
  String? accountHolderName;
  String? currencyId;
  String? balance;
  String? cvv;
  String? cardNumber;
  String? cardCreationDate;
  String? cardExpiryDate;
  String? phoneNumber;
  String? emailAddress;
  String? accountStatusId;
  Null? createdOn;
  Null? lastModifiedOn;
  Null? totalUpdates;
  String? favourite;

  Data(
      {this.id,
      this.userId,
      this.accountNumber,
      this.accountTypeId,
      this.bankName,
      this.branchName,
      this.branchCode,
      this.accountHolderName,
      this.currencyId,
      this.balance,
      this.cvv,
      this.cardNumber,
      this.cardCreationDate,
      this.cardExpiryDate,
      this.phoneNumber,
      this.emailAddress,
      this.accountStatusId,
      this.createdOn,
      this.lastModifiedOn,
      this.totalUpdates,
      this.favourite});
  
   @override
  String toString() {
    return 'Data(userId: $userId, accountNumber: $accountNumber, bankName: $bankName, '
           'branchCode: $branchCode, accountHolderName: $accountHolderName, '
           'phoneNumber: $phoneNumber, emailAddress: $emailAddress, branchName: $branchName, '
           'balance: $balance, accountStatusId: $accountStatusId, accountTypeId: $accountTypeId, '
           'id: $id, cvv: $cvv, favourite: $favourite, cardCreationDate: $cardCreationDate, '
           'cardExpiryDate: $cardExpiryDate, cardNumber: $cardNumber)';
  }
  
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    accountNumber = json['account_number'];
    accountTypeId = json['account_type_id'];
    bankName = json['bank_name'];
    branchName = json['branch_name'];
    branchCode = json['branch_code'];
    accountHolderName = json['account_holder_name'];
    currencyId = json['currency_id'];
    balance = json['balance'];
    cvv = json['cvv'];
    cardNumber = json['card_number'];
    cardCreationDate = json['card_creation_date'];
    cardExpiryDate = json['card_expiry_date'];
    phoneNumber = json['phone_number'];
    emailAddress = json['email_address'];
    accountStatusId = json['account_status_id'];
    createdOn = json['created_on'];
    lastModifiedOn = json['last_modified_on'];
    totalUpdates = json['total_updates'];
    favourite = json['favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['account_number'] = accountNumber;
    data['account_type_id'] = accountTypeId;
    data['bank_name'] = bankName;
    data['branch_name'] = branchName;
    data['branch_code'] = branchCode;
    data['account_holder_name'] = accountHolderName;
    data['currency_id'] = currencyId;
    data['balance'] = balance;
    data['cvv'] = cvv;
    data['card_number'] = cardNumber;
    data['card_creation_date'] = cardCreationDate;
    data['card_expiry_date'] = cardExpiryDate;
    data['phone_number'] = phoneNumber;
    data['email_address'] = emailAddress;
    data['account_status_id'] = accountStatusId;
    data['created_on'] = createdOn;
    data['last_modified_on'] = lastModifiedOn;
    data['total_updates'] = totalUpdates;
    data['favourite'] = favourite;
    return data;
  }
}