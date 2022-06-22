enum Bank { bca, bni, bri, mandiri, permata }

enum TransferType {
  card,
  bankTransfer,
  eMoney,
  directDebit,
  convenienceStore,
  cardlessCredit
}

class TransactionDetail {
  String? orderId, grossAmount;
  TransactionDetail({this.orderId, this.grossAmount});
}

class EChannel {
  String? billInfo1, billInfo2;
  EChannel({this.billInfo1, this.billInfo2});
}

class TransactionRequest {
  TransactionDetail? transactionDetail;
  EChannel? eChannel;

  TransactionRequest({this.transactionDetail, this.eChannel});
}

class TransactionResponse {
  String? statusCode,
      statusMessage,
      transactionId,
      orderId,
      merchandId,
      grossAmount,
      currency,
      paymentType,
      transactionTime,
      transactionStatus,
      fraudStatus,
      billKey,
      permataVaNumber,
      billerCode;
  List<VANumbers>? vaNumbers;
  Bank? bank;

  TransactionResponse(
      {this.statusCode,
      this.statusMessage,
      this.bank,
      this.transactionId,
      this.orderId,
      this.merchandId,
      this.grossAmount,
      this.currency,
      this.paymentType,
      this.transactionTime,
      this.transactionStatus,
      this.fraudStatus,
      this.billKey,
      this.permataVaNumber,
      this.vaNumbers,
      this.billerCode});

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    return TransactionResponse(
        statusCode: json['status_code'],
        statusMessage: json['status_message'],
        transactionId: json['transaction_id'],
        orderId: json['order_id'],
        merchandId: json['merchant_id'],
        grossAmount: json['gross_amount'],
        paymentType: json['payment_type'],
        transactionTime: json['transaction_time'],
        transactionStatus: json['transaction_status'],
        fraudStatus: json['fraud_status'],
        currency: json['currency'],
        billerCode: json['biller_code'],
        billKey: json['bill_key'],
        permataVaNumber: json['permata_va_number'],
        vaNumbers: json['va_numbers'] != null
            ? List<VANumbers>.from(
                json["va_numbers"].map((e) => VANumbers.fromJson(e)))
            : null);
  }
}

class VANumbers {
  String? bank, vaNumber;

  VANumbers({this.bank, this.vaNumber});

  factory VANumbers.fromJson(Map<String, dynamic> json) {
    return VANumbers(bank: json['bank'], vaNumber: json['va_number']);
  }
}
