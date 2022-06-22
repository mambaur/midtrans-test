import 'package:flutter/material.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MidtransSDK? _midtrans;

  void initSDK() async {
    _midtrans = await MidtransSDK.init(
      config: MidtransConfig(
        clientKey: "SB-Mid-client-Ve6moPvBhfZSwpWy",
        merchantBaseUrl: "",
        colorTheme: ColorTheme(
          colorPrimary: Theme.of(context).accentColor,
          colorPrimaryDark: Theme.of(context).accentColor,
          colorSecondary: Theme.of(context).accentColor,
        ),
      ),
    );
    _midtrans?.setUIKitCustomSetting(
      skipCustomerDetailsPages: true,
    );
    _midtrans!.setTransactionFinishedCallback((result) {
      print(result.toJson());
    });
  }

  @override
  void dispose() {
    _midtrans?.removeTransactionFinishedCallback();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Pay Now"),
          onPressed: () async {
            _midtrans?.startPaymentUiFlow(
                // token: DotEnv.env['SNAP_TOKEN'],
                );
          },
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
