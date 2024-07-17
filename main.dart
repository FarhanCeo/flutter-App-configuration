import 'dart:async';
import 'package:flutter/material.dart';
import 'package:azure_app_config/azure_app_config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Azure App Config Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late AzureAppConfig _appConfig;
  late String _featureValue = '';
  late bool _isFeatureEnabled = false;

  @override
  void initState() {
    super.initState();
    // Initialize Azure App Configuration
    _initializeAppConfig();
  }

  Future<void> _initializeAppConfig() async {
    try {
      // Replace with your actual Azure App Configuration connection string
      final connectionString =
          'Endpoint=https://app-config-1o1.azconfig.io;Id=aVZe;Secret=7Tl6cLB1wYnfsk2iESoTfs1kCeqFyJy36pkhX9PtzAtxD9UIEx8YJQQJ99AGACYeBjFw7xXqAAACAZACNA3e';
      _appConfig = AzureAppConfig(connectionString: connectionString);

      // Fetch feature flag value
      final exampleKey = '.appconfig.featureflag/feature_1';
      final exampleLabel = 'key1';
      final keyValue = await _appConfig.getKeyValue(key: exampleKey, label: exampleLabel);

      setState(() {
        _featureValue = keyValue.value;
        final featureFlag = keyValue.asFeatureFlag();
        _isFeatureEnabled = featureFlag?.enabled ?? false;
      });
    } catch (e) {
      print('Failed to initialize Azure App Configuration: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Azure App Config Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Feature Value: $_featureValue',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Feature Enabled: $_isFeatureEnabled',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

