import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class DateTimeLove {
  late int year;
  late int month;
  late int week;
  late int day;
}

class InfoPrimary {
  late int ageMe;
  late int ageGirlfriend;
  late String defaultBg;
  late String notificationContent;
  late String pathLinkImageMe;
  late String pathLinkImageGirlfriend;
  late DateTimeLove timeLove;
  late String fromDate;
  late String currentDate;
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    String textNotification = "Thông báo mới";
    int ageMe = 21;
    int ageGirlFriend = 17;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: const Color(0x44000000),
          elevation: 0,
          actions: [
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.upload_file),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz),
                ),
              ],
            ),
          ],
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            ClipRect(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(
                  sigmaX: 5.0,
                  sigmaY: 5.0,
                ),
              ),
            ),
            Container(
              height: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/3x/defaultBg.jpg'),
                      fit: BoxFit.cover)),
              child: Center(
                  child: Padding(
                padding: EdgeInsets.only(top: heightScreen * 0.08),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            // ignore: avoid_unnecessary_containers
                            Container(
                              child: Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            children: [
                                              CustomPaint(
                                                size: const Size(70, 80),
                                                painter: HeartPainter("1"),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text('Năm',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      foreground: Paint()
                                                        ..style =
                                                            PaintingStyle.stroke
                                                        ..strokeWidth = 1.5
                                                        ..color =
                                                            Color(0xFFf9b6bd)))
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              CustomPaint(
                                                size: const Size(70, 80),
                                                painter: HeartPainter("1"),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text('Tháng',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      foreground: Paint()
                                                        ..style =
                                                            PaintingStyle.stroke
                                                        ..strokeWidth = 1.5
                                                        ..color =
                                                            Color(0xFFf9b6bd)))
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              CustomPaint(
                                                size: const Size(70, 80),
                                                painter: HeartPainter("1"),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text('Tuần',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      foreground: Paint()
                                                        ..style =
                                                            PaintingStyle.stroke
                                                        ..strokeWidth = 1.5
                                                        ..color =
                                                            Color(0xFFf9b6bd)))
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              CustomPaint(
                                                size: const Size(70, 80),
                                                painter: HeartPainter("1"),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text('Ngày',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      foreground: Paint()
                                                        ..style =
                                                            PaintingStyle.stroke
                                                        ..strokeWidth = 1.5
                                                        ..color = const Color(
                                                            0xFFf9b6bd)))
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  16.0, 16.0, 16.0, 0),
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: Text(
                                  "# 2021/01/01",
                                  style: TextStyle(
                                      fontSize: 14,
                                      foreground: Paint()
                                        ..style = PaintingStyle.fill
                                        ..strokeWidth = 1.5
                                        ..color = const Color(0xFFf9b6bd)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  16.0, 16.0, 16.0, 0),
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: Text("# 2021/01/01",
                                    style: TextStyle(
                                        backgroundColor: Colors.white,
                                        fontSize: 14,
                                        foreground: Paint()
                                          ..style = PaintingStyle.fill
                                          ..strokeWidth = 1.5
                                          ..color = const Color(0xFFf9b6bd))),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 300,
                              height: 150,
                              child: Container(
                                width: 400,
                                height: 150,
                                color: const Color.fromARGB(128, 176, 175, 175),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "Thông báo mỗi ngày: \n $textNotification",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: heightScreen * 0.07),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                    AssetImage('assets/images/3x/me.jpg'),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: const [
                                  Icon(
                                    Icons.male,
                                    size: 20.0,
                                    color: Color.fromARGB(255, 238, 88, 188),
                                  ),
                                  Text('Anh Phi',
                                      style: TextStyle(color: Colors.white)),
                                ],
                              ),
                              Row(
                                children: [
                                  const SizedBox(height: 8),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: widthScreen * 0.025),
                                    child: Text(
                                      'Song tử - $ageMe',
                                      style: TextStyle(
                                        background: Paint()
                                          ..color = const Color.fromARGB(
                                              138, 249, 166, 196),
                                        fontSize: 14,
                                        foreground: Paint()
                                          ..style = PaintingStyle.fill
                                          ..strokeWidth = 1.5
                                          ..color = Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            children: [
                              CustomPaint(
                                size: const Size(40, 40),
                                painter: HeartPainter("", false),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                    AssetImage('assets/images/3x/Beiu.jpg'),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: const [
                                  Icon(
                                    Icons.female,
                                    size: 20.0,
                                    color: Color.fromARGB(255, 238, 88, 188),
                                  ),
                                  Text('Bảo Hân',
                                      style: TextStyle(color: Colors.white)),
                                ],
                              ),
                              Row(
                                children: [
                                  const SizedBox(height: 8),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: widthScreen * 0.025),
                                    child: Text(
                                      'Bọ cạp - $ageGirlFriend',
                                      style: TextStyle(
                                        background: Paint()
                                          ..color = const Color.fromARGB(
                                              138, 249, 166, 196),
                                        fontSize: 14,
                                        foreground: Paint()
                                          ..style = PaintingStyle.fill
                                          ..strokeWidth = 1.5
                                          ..color = Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
            ),
          ],
        ));
  }
}

class HeartPainter extends CustomPainter {
  final String contentText;
  bool isFill;
  HeartPainter(this.contentText, [this.isFill = true]);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint
      ..color = isFill ? const Color(0xFFf9a6c4) : Colors.red
      ..style = isFill ? PaintingStyle.stroke : PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6;

    Paint paint1 = Paint();
    paint1
      ..color = const Color(0xFFf9a6c4)
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    double width = size.width;
    double height = size.height;

    Path path = Path();
    path.moveTo(0.5 * width, height * 0.35);
    path.cubicTo(0.2 * width, height * 0.1, -0.25 * width, height * 0.6,
        0.5 * width, height);
    path.moveTo(0.5 * width, height * 0.35);
    path.cubicTo(0.8 * width, height * 0.1, 1.25 * width, height * 0.6,
        0.5 * width, height);
    final Path shadowPath = Path()..addPath(path, Offset(5, 5));

    canvas.drawShadow(shadowPath, Colors.black, 3, true);
    canvas.drawPath(path, paint);
    canvas.drawPath(path, paint1);
    canvas.drawPath(path, paint);

    // Calculate the center point of the heart
    Offset center = Offset(width / 2, height / 2);

    // Draw text inside the heart
    TextSpan span = TextSpan(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      text: contentText,
    );
    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    // Set the maximum number of lines to 1
    tp.maxLines = 1;

    // Layout the text to calculate its size
    tp.layout();

    // Position the text at the center of the heart
    Offset textOffset = center.translate(-tp.width / 2, -tp.height / 3);

    // Paint the text on the canvas
    tp.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
