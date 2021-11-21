import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import './coin_data.dart';

class PriceScreen extends StatefulWidget {
  
  @override
  
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  
  String selectedCurrency="USD";



  DropdownButton<String> getDropDownbutton(){
     List<DropdownMenuItem<String>> dropDownItems=[];
    for (String currency in currenciesList){
    var newItem= DropdownMenuItem(child: Text(currency),
     value: currency,);
     dropDownItems.add(newItem);
    }
return DropdownButton<String>(value: selectedCurrency,
            items: dropDownItems, onChanged: (value){
              setState(() {
               selectedCurrency=value;
               getData();
              });

            },);
  }
CupertinoPicker cupertinoIos(){

 List<Text> pickerText=[];
    for(String currency in currenciesList){
      pickerText.add(Text(currency));
    }
   
 return CupertinoPicker(itemExtent: 32, onSelectedItemChanged: (selectedIndex){
                print(selectedIndex);
                setState(() {
                   selectedCurrency=currenciesList[selectedIndex];
                   getData(); 
                });
              
            }, children: pickerText,);
}

  Widget getPicker(){
    if(Platform.isIOS){
      return cupertinoIos();
    }else if(Platform.isAndroid){
      return getDropDownbutton();
    }
  }

  Map<String,String> inside={};
   bool isWaiting=false;
  void getData()async{
    isWaiting=true;
    try{
      var btcData= await CoinData().getNetwork(selectedCurrency);
       isWaiting=false;
      setState(() {
        inside=btcData;
       
      });
    }catch(e){
      print(e);
    }
  }
 
 @override
  void initState() {
    
    super.initState();
getData();
  }
  @override

  Widget build(BuildContext context) {

   
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Exchange(Ticker)'),
      ),
      body: Container(decoration: BoxDecoration(image:
       DecorationImage(image: AssetImage("images/.png"),fit: BoxFit.cover) ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[Column( 
             
        crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CryptoCard(inside: isWaiting?"?": inside["BTC"],
                selectedCurrency:selectedCurrency,
             selectedCrypto: "BTC",
              ),
               CryptoCard( inside: isWaiting?"?": inside["LTC"] ,
                 selectedCurrency:selectedCurrency,
             selectedCrypto: "LTC",
            ),
          CryptoCard(inside: isWaiting?"?": inside["ETH"] ,
            selectedCurrency:selectedCurrency,
             selectedCrypto: "ETH",
             ),
           
            ],
          ),
         
            Container(
              color: Colors.grey,
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              
              child: getPicker()
            ),
          ],
        ),
      ),
    );
  }
}


class CryptoCard extends StatelessWidget {
   CryptoCard({ this.inside,
    this.selectedCurrency,
     this.selectedCrypto,
  
  });
final String inside;
final String  selectedCurrency;
  final String selectedCrypto;
  
  
 
  @override
  Widget build(BuildContext context) {
    return  Padding(
              padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
              child: Card(
                
                elevation: 5.0,
                shape: RoundedRectangleBorder(borderRadius:
                 BorderRadius.circular(10),),
                
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                  child: Text(
                    '1 $selectedCrypto =  $inside $selectedCurrency',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
  }
}
