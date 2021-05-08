// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
//
// void main() {
//   runApp(ResultPage());
// }
//
// class ResultPage extends StatelessWidget {
//   List<int> data = [40, 60];
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('images/bg.jpg'),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SingleChildScrollView(
//                 child: Container(
//                   child: SfCircularChart(
//                     title: ChartTitle(text: 'Review Analysis'),
//                     series: [
//                       CircularSeries<int, String>(
//                         dataSource: data,
//                         //xValueMapper: (_SalesData sales, _) => sales.year,
//                         //yValueMapper: (_SalesData sales, _) => sales.sales,
//                         name: 'Sales',
//                         // Enable data label
//                         dataLabelSettings: DataLabelSettings(isVisible: true),
//                       )
//                       //xValueMapper: (_SalesData sales, _) => sales.year,)
//                     ],
//                   ),
//                   color: Color(0xff2d2c2c),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
//
// void main() {
//   return runApp(_ChartApp());
// }

// class _ChartApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       //theme: ThemeData(primarySwatch: Colors.blue),
//       home: MyHomePage(),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  //_MyHomePage({Key? key}) : super(key: key);
  final int x, y;
  final double pp, np;

  MyHomePage(
      {required this.x, required this.y, required this.pp, required this.np});
  @override
  _MyHomePageState createState() =>
      _MyHomePageState(x: x, y: y, pp: pp, np: np);
}

class _MyHomePageState extends State<MyHomePage> {
  final int x, y;
  final double pp, np;
  _MyHomePageState(
      {required this.x, required this.y, required this.pp, required this.np});

  List<_SalesData> data = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data.add(
      _SalesData('Positive', pp),
    );
    data.add(
      _SalesData('Negative', np),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Review Insights',
            style: TextStyle(
              color: Color(0xffff9000),
            ),
          ),
          backgroundColor: Color(0xff2d2c2c),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 1.5,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff2d2c2c),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 0),
                      child: SfCartesianChart(
                          // borderColor: Color(0xff2d2c2c),
                          //plotAreaBorderColor: Color(0xffff9000),
                          primaryXAxis: CategoryAxis(),
                          // Chart title
                          title: ChartTitle(
                            text: 'Restaurant Review Analysis',
                            backgroundColor: Color(0xffff9000),
                            //borderColor: Color(0xffff9000),
                          ),
                          // Enable legend
                          legend: Legend(
                            isVisible: true,
                            //backgroundColor: Color(0xffff9000),
                            iconBorderColor: Color(0xffff9000),
                            //borderWidth: 2,
                            textStyle: TextStyle(
                              color: Color(0xffff9000),
                            ),
                          ),
                          // Enable tooltip
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <ChartSeries<_SalesData, String>>[
                            BarSeries(
                              color: Color(0xffff9000),
                              // trackColor: Color(0xffff9000),
                              //trackBorderColor: Color(0xffff9000),
                              //trackColor: Color(0xffff9000),
                              dataSource: data,
                              xValueMapper: (_SalesData sales, _) => sales.year,
                              yValueMapper: (_SalesData sales, _) =>
                                  sales.sales,
                              name: 'Count',
                              // Enable data label
                              dataLabelSettings: DataLabelSettings(
                                isVisible: true,
                                color: Color(0xffff9000),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Color(0xff2d2c2c),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    //color: Color(0xFFFCC001),
                    color: Color(0xffff9000),
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Try another source',
                  style: TextStyle(color: Color(0xffff9000), fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
