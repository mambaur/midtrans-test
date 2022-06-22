import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:midtrans_test/midtrans/models.dart';
import 'package:http/http.dart' as http;

class Midtrans {
  final String _serverKey = dotenv.env['MIDTRANS_SERVER_KEY'].toString();
  final String _midtransURL = dotenv.env['MIDTRANS_URL_DEVELOPMENT'].toString();

  _encode(serverKey) {
    // Base64Encode("YourServerKey"+":")
    String encoded = base64.encode(utf8.encode('$serverKey:'));
    return encoded;
  }

  String? _bankToString(Bank? bank) {
    try {
      return Bank.bri.toString().split('.')[1].toString();
    } catch (e) {
      return null;
    }
  }

  /// Sending Transaction Data to API Charge
  ///
  /// Bank Transfer
  Future<TransactionResponse?> bankTransferCharge(
      {TransactionRequest? transactionRequest, Bank? bank}) async {
    Object body = {};
    if (bank == Bank.bca || bank == Bank.bri || bank == Bank.bni) {
      body = {
        'payment_type': bank == Bank.permata
            ? _bankToString(bank)
            : bank == Bank.mandiri
                ? 'echannel'
                : 'bank_transfer',
        'transaction_details': {
          'order_id': transactionRequest!.transactionDetail!.orderId,
          'gross_amount': transactionRequest.transactionDetail!.grossAmount,
        },
        'echannel': {
          'bill_info1': transactionRequest.eChannel?.billInfo1 ?? '',
          'bill_info2': transactionRequest.eChannel?.billInfo2 ?? '',
        },
        'bank_transfer': {'bank': _bankToString(bank)}
      };
    }

    final response = await http.post(Uri.parse(_midtransURL),
        headers: {
          'Authorization': 'Basic ${_encode(_serverKey)}',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode(body));
    print(response.body);
    return TransactionResponse.fromJson(json.decode(response.body));
  }
}
