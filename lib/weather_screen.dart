import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './forecast_card.dart';
import './additional_information.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen>{

  Future<Map<String, dynamic>> getWeather() async{
    String city = "Sangli";
    try{
      
      final res = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/forecast?q=$city&units=metric&APPID=b58cab7229caedb99b7a83e3e46df51e"));

      final data = jsonDecode(res.body);

      return data;

    }
    catch(e){
      throw e.toString();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                
              });
            },
            icon: Icon(Icons.refresh, size: 29),
            // padding: EdgeInsets.only(right: 15),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getWeather(),
        builder: (context, snapshot) { //snapshot is nothing but the data comming from the getWeather()
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator.adaptive());
          }
    
          if(snapshot.hasError){
            return Text(snapshot.error.toString());
          }
    
          //aquiring data from the result of api calling
          final data = snapshot.data!; // '!' because it is 100% sure that data cant be null.
          final currentTemp = data['list'][0]['main']['temp'];
          final currentSky = data['list'][0]['weather'][0]['main'];
          final currentHumidity = data['list'][0]['main']['humidity'];
          final currentWindSpeed = data['list'][0]['wind']['speed'];
          final currentPressure = data['list'][0]['main']['pressure'];
    
          return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.white30,
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      Text(
                        '$currentTemp℃',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(currentSky == 'Clouds' || currentSky == 'Rain' ? Icons.cloud : Icons.sunny, size: 70),
                      Text(
                        currentSky,
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(
                  'Additional Information',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AdditionalCard(icon: Icons.water_drop, label: "Humidity", value: '$currentHumidity%',),
                  AdditionalCard(icon: Icons.wind_power, label: "Wind Speed", value: "$currentWindSpeed m/s"),
                  AdditionalCard(icon: Icons.speed, label: "Pressure", value: "$currentPressure hPa"),
                ],
              ),
              SizedBox(height: 20,),
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(
                  "Weather Forecast",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){ //initially index = 0. this itemBuilder works as a for loop
                    final forecastTime = DateTime.parse(data['list'][index + 1]['dt_txt'].toString());
                    final forecastIcon = (data['list'][index + 1]['weather'][0]['main'] == 'Clouds' || data['list'][index + 1]['weather'][0]['main'] == 'Rain' ? Icons.cloud : Icons.sunny);          final forecastTemp = "${data['list'][index + 1]['main']['temp']}℃";
                    return ForecastCard(
                      time: DateFormat.j().format(forecastTime), 
                      icon: forecastIcon, 
                      temp: forecastTemp,
                    );
                  }),
              )
            ],
          ),
        );
        },
      ),
    );
  }
}
