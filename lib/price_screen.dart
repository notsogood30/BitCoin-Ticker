import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'coin_data.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;
const api = 'DBF68B10-7ED7-40E4-8136-FC9B629C964B';
class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  int rate=58578,rate1=3142,rate2=279;
  String currency = 'USD';
  void getdata(String curr)async
  {
    http.Response response = await http.get(Uri.parse('https://rest.coinapi.io/v1/exchangerate/BTC/$curr?apikey=$api'));
    String data = response.body;
    var ratedata = jsonDecode(data);
    rate = ratedata['rate'].toInt();
  }

  void getdataeth(String curr)async
  {
    http.Response response = await http.get(Uri.parse('https://rest.coinapi.io/v1/exchangerate/ETH/$curr?apikey=$api'));
    String data = response.body;
    var ratedata = jsonDecode(data);
    rate1 = ratedata['rate'].toInt();
  }

  void getdataltc(String curr)async
  {
    http.Response response = await http.get(Uri.parse('https://rest.coinapi.io/v1/exchangerate/LTC/$curr?apikey=$api'));
    String data = response.body;
    var ratedata = jsonDecode(data);
    rate2 = ratedata['rate'].toInt();
  }
  DropdownButton<String> getdropdownbutton() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (int i = 0; i < currenciesList.length; i++) {
      String currency = currenciesList[i];
      var newitem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newitem);
    }
    return DropdownButton<String>(
      value: currency,
      items: dropdownItems,
      onChanged: (value) {
        setState(
          () {
            getdata(value);
            getdataeth(value);
            getdataltc(value);
            currency = value;
          },
        );
      },
    );
  }

  CupertinoPicker getpickerdown()
  {
    List<Widget> getpicker = [];
    for (int i = 0; i < currenciesList.length; i++) {
      String currency1 = currenciesList[i];
      var text = Text(currency1);
      getpicker.add(text);
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      backgroundColor: Colors.lightBlue,
      onSelectedItemChanged: (currency) {
        print(currency);
      },
      children: getpicker,
    );
  }
Widget getpicker()
{
  if(Platform.isIOS)
    {
      return getpickerdown();
    }
  else
    {
      return getdropdownbutton();
    }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text('🤑 Coin Ticker'),
      )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $rate $currency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = $rate1 $currency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = $rate2 $currency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: getpicker()),
        ],
      ),
    );
  }
}
