import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/model/android_battery_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';

class BatteryLevel {
  static const platform = MethodChannel('battery');

  Future<int?> getBatteryLevel() async {
    try {
      final int batteryLevel = await platform.invokeMethod('getBatteryLevel');
      return batteryLevel;
    } on PlatformException catch (e) {
      print("Failed to get battery level: '${e.message}'.");
      return null;
    }
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NFT Mockup',
      theme: ThemeData(
        fontFamily: 'San Francisco',
        primarySwatch: Colors.blue,
      ),
      home: PageOne(),
    );
  }
}

class PageOne extends StatefulWidget {
  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  final String nftName = 'Floppa the Cat';
  final String nftImageUrl = 'https://i.pinimg.com/564x/a6/cf/ce/a6cfce2ae1c59a611f6fa1cdcc5cb1cf.jpg';
  final String username = '@kirill';
  final String nftPrice = '3.52 ETH';
  final String volume = '785 Volume';

  static const platform = MethodChannel('sendSms');

  Future<void> sendSms(String phoneNumber, String message) async {
    var status = await Permission.sms.status;

    if (!status.isGranted) {
      status = await Permission.sms.request();

      if (status.isDenied) {
        return;
      }
    }

    try {
      final result = await platform.invokeMethod('send', {
        'phone': phoneNumber,
        'msg': message,
      });
      print(result); // Handle the success message
    } on PlatformException catch (e) {
      print("Failed to send SMS: '${e.message}'.");
    }
  }

  String batterylevel = "Загрузка...",
      batteryhealth = "Загрузка...",
      chargingstatus = "Загрузка...",
      pluggedstatus = "Загрузка...";

  @override
  void initState() {
    AndroidBatteryInfo? infoandroid = AndroidBatteryInfo();

    Future.delayed(Duration.zero, () async {
      infoandroid = await BatteryInfoPlugin().androidBatteryInfo;
      batterylevel = infoandroid!.batteryLevel.toString();
      batteryhealth = infoandroid!.health.toString();
      chargingstatus = infoandroid!.chargingStatus.toString();
      pluggedstatus = infoandroid!.pluggedStatus.toString();

      setState(() {
      });
    });

    BatteryInfoPlugin().androidBatteryInfoStream.listen((AndroidBatteryInfo? batteryInfo) {
      //add listiner to update values if there is changes
      infoandroid = batteryInfo;
      batterylevel = infoandroid!.batteryLevel.toString();
      batteryhealth = infoandroid!.health.toString();
      chargingstatus = infoandroid!.chargingStatus.toString();
      pluggedstatus = infoandroid!.pluggedStatus.toString();

      setState(() {
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'nolade.',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      'https://shorturl.at/t9YtA',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'EXPLORE THE ',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    WidgetSpan(
                      child: Icon(Icons.whatshot, color: Colors.red, size: 36),
                    ),
                    TextSpan(
                      text: ' MOST POPULAR\nNFT.',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(
                      'https://shorturl.at/t9YtA',
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(username, style: TextStyle(fontSize: 16, color: Colors.black54)),
                  SizedBox(width: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black,
                    ),
                    child: Text(
                      'New',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Stack(
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 2,
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        'https://shorturl.at/PpUYB',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 2,
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Text(
                        '25',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 2,
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.attach_money, color: Colors.white),
                          SizedBox(width: 5),
                          Text(
                            volume,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                '00:29:14',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PageTwo(
                          nftName: nftName,
                          imageUrl: nftImageUrl,
                          username: username,
                          nftPrice: nftPrice,
                          volume: volume,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'View NFT',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    sendSms("+15551234567", "SMS message");
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Send SMS',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(width: 50, height: 50,),
              Text("Battery Level: $batterylevel %"),
              Text("Battery Health: $batteryhealth"),
              Text("Charging Status: $chargingstatus"),
              // Возможные значения: ChargingStatus.charging, discharging, full, unknown
              Text("Plugged Status: $pluggedstatus"),
            ],
          ),
        ),
      ),
    );
  }
}



class PageTwo extends StatefulWidget {
  final String nftName;
  final String imageUrl;
  final String username;
  final String nftPrice;
  final String volume;

  PageTwo({
    required this.nftName,
    required this.imageUrl,
    required this.username,
    required this.nftPrice,
    required this.volume,
  });

  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  final BatteryLevel batteryLevelHelper = BatteryLevel();
  int? batteryLevel;

  @override
  void initState() {
    super.initState();
    _getBatteryLevel();
  }

  Future<void> _getBatteryLevel() async {
    int? level = await batteryLevelHelper.getBatteryLevel();
    setState(() {
      batteryLevel = level;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              widget.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: 10),
                      Text(
                        widget.username,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.favorite_border, color: Colors.white),
                        onPressed: () {},
                      ),
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://shorturl.at/t9YtA',
                        ),
                        radius: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  widget.nftName,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Battery Level: ${batteryLevel != null ? "$batteryLevel%" : "Loading..."}',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 40),
              Container(
                height: 300,
                child: PageView(
                  children: [
                    _buildPageContent('NFT #1', 'https://i.pinimg.com/564x/a6/cf/ce/a6cfce2ae1c59a611f6fa1cdcc5cb1cf.jpg'),
                    _buildPageContent('NFT #2', 'https://i.pinimg.com/564x/b6/c7/e3/b6c7e3bb1f2ad4ae8bcbfb58bb0d9bd1.jpg'),
                    _buildPageContent('NFT #3', 'https://i.pinimg.com/564x/c6/e2/17/c6e217cdd2bb482e6272e27f2b503adf.jpg'),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoCard('Floor price', widget.nftPrice, '-12%', Colors.red),
                    _buildInfoCard('Sales', widget.volume, '+5%', Colors.green),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent(String nftTitle, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text(
            nftTitle,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, String percentage, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 2,
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 26, color: Colors.black),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              percentage,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}