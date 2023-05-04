import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../dataSimple/dateSimple.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  late InfoPrimary infoGet = InfoPrimary(
      ageMe: 1,
      ageGirlfriend: 1,
      notificationContent: "",
      timeLove: DateTimeLove(
        year: 1,
        month: 1,
        week: 1,
        day: 1,
      ),
      fromDate: "",
      currentDate: ""); // initialize with default values
  @override
  void initState() {
    super.initState();
    getInfo();
  }

  Future<void> getInfo() async {
    try {
      final info = await getRequest();
      setState(() {
        infoGet = info;
      });
    } catch (e) {}
  }

  Future<InfoPrimary> getRequest() async {
    final response = await http.get(
        Uri.parse('https://10.0.2.2:5000/api/v1/InfoLove'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      return InfoPrimary.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load api');
    }
  }

  File? _avatar1;
  File? _avatar2;
  final picker = ImagePicker();

  Future getImage(int avatarNumber) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        if (avatarNumber == 1) {
          _avatar1 = File(pickedFile.path);
        } else if (avatarNumber == 2) {
          _avatar2 = File(pickedFile.path);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<int> numbers = [25, 50, 75, 100];
    final PageController _pageController = PageController(initialPage: 0);
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    String textNotification = infoGet.notificationContent.toString();
    int ageMe = infoGet.ageMe;
    int ageGirlFriend = infoGet.ageGirlfriend;
    late String avt1;
    late String avt2;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: const Color(0x44000000),
          elevation: 0,
          actions: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/manager_file');
                  },
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
        body: PageView(controller: _pageController, children: [
          GestureDetector(
            onTap: () {
              _pageController.animateToPage(1,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
            },
            child: Stack(
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
                                                    painter: HeartPainter(
                                                        infoGet.timeLove.year
                                                            .toString()),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text('Năm',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          foreground: Paint()
                                                            ..style =
                                                                PaintingStyle
                                                                    .stroke
                                                            ..strokeWidth = 1.5
                                                            ..color = Color(
                                                                0xFFf9b6bd)))
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  CustomPaint(
                                                    size: const Size(70, 80),
                                                    painter: HeartPainter(
                                                        infoGet.timeLove.month
                                                            .toString()),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text('Tháng',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          foreground: Paint()
                                                            ..style =
                                                                PaintingStyle
                                                                    .stroke
                                                            ..strokeWidth = 1.5
                                                            ..color = Color(
                                                                0xFFf9b6bd)))
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  CustomPaint(
                                                    size: const Size(70, 80),
                                                    painter: HeartPainter(
                                                        infoGet.timeLove.week
                                                            .toString()),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text('Tuần',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          foreground: Paint()
                                                            ..style =
                                                                PaintingStyle
                                                                    .stroke
                                                            ..strokeWidth = 1.5
                                                            ..color = Color(
                                                                0xFFf9b6bd)))
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  CustomPaint(
                                                    size: const Size(70, 80),
                                                    painter: HeartPainter(
                                                        infoGet.timeLove.day
                                                            .toString()),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text('Ngày',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          foreground: Paint()
                                                            ..style =
                                                                PaintingStyle
                                                                    .stroke
                                                            ..strokeWidth = 1.5
                                                            ..color =
                                                                const Color(
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
                                      "# ${infoGet.fromDate.toString()}",
                                      style: TextStyle(
                                          fontSize: 12,
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
                                    child: Text(
                                        "# ${infoGet.currentDate.toString()}",
                                        style: TextStyle(
                                            backgroundColor: Colors.white,
                                            fontSize: 12,
                                            foreground: Paint()
                                              ..style = PaintingStyle.fill
                                              ..strokeWidth = 1.5
                                              ..color =
                                                  const Color(0xFFf9b6bd))),
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
                                    color: const Color.fromARGB(
                                        128, 176, 175, 175),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "Thông báo mỗi ngày: \n $textNotification",
                                        style: const TextStyle(
                                            color: Colors.white),
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
                                    backgroundImage: _avatar1 != null
                                        ? FileImage(_avatar1!)
                                        : const AssetImage(
                                                'assets/images/3x/me.jpg')
                                            as ImageProvider<Object>,
                                  ),
                                  GestureDetector(
                                    onTap: () => getImage(1),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        Icons.edit,
                                        size: 10,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.male,
                                        size: 20.0,
                                        color:
                                            Color.fromARGB(255, 238, 88, 188),
                                      ),
                                      Text('Anh Phi',
                                          style:
                                              TextStyle(color: Colors.white)),
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
                                  HeartAnimation(
                                    text: "",
                                    durationInMilliseconds: 800,
                                    sizeBegin: 0,
                                    sizeEnd: 50,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage: _avatar2 != null
                                        ? FileImage(_avatar2!)
                                        : const AssetImage(
                                                'assets/images/3x/Beiu.jpg')
                                            as ImageProvider<Object>,
                                  ),
                                  GestureDetector(
                                    onTap: () => getImage(2),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        Icons.edit,
                                        size: 10,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.female,
                                        size: 20.0,
                                        color:
                                            Color.fromARGB(255, 238, 88, 188),
                                      ),
                                      Text('Bảo Hân',
                                          style:
                                              TextStyle(color: Colors.white)),
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
            ),
          ),
          Center(
            child: CircleScreen(number: infoGet.timeLove.day),
          ),
        ]));
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
    final Path shadowPath = Path()..addPath(path, const Offset(5, 5));

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

class HeartAnimation extends StatefulWidget {
  final String text;
  final int durationInMilliseconds;
  final double sizeBegin;
  final double sizeEnd;
  final double opacityBegin;
  final double opacityEnd;

  const HeartAnimation({
    required this.text,
    this.durationInMilliseconds = 100,
    this.sizeBegin = 1,
    this.sizeEnd = 10,
    this.opacityBegin = 1,
    this.opacityEnd = 0,
  });

  @override
  // ignore: library_private_types_in_public_api
  _HeartAnimationState createState() => _HeartAnimationState();
}

class _HeartAnimationState extends State<HeartAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // Create the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.durationInMilliseconds),
    );

    // Create the size animation
    _sizeAnimation = Tween<double>(
      begin: widget.sizeBegin,
      end: widget.sizeEnd,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Create the opacity animation
    _opacityAnimation = Tween<double>(
      begin: 1,
      end: 0.5,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Add a listener to the animation controller to repaint the widget
    _controller.addListener(() {
      setState(() {});
    });

    // Start the animation
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    // Dispose the animation controller
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Opacity(
        opacity: _opacityAnimation.value,
        child: CustomPaint(
          painter: HeartPainter(widget.text, false),
        ),
      ),
    );
  }
}

class CircleScreen extends StatefulWidget {
  final int number;

  const CircleScreen({Key? key, required this.number}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CircleScreenState createState() => _CircleScreenState();
}

class _CircleScreenState extends State<CircleScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    _animation = Tween<double>(begin: 0, end: (widget.number / 8000) * 2 * 3.14)
        .animate(_controller)
      ..addListener(() {
        print('Animation value: ${_animation.value}');
        setState(() {});
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/3x/defaultBg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Stack(
            children: [
              RepaintBoundary(
                child: CustomPaint(
                  painter: CirclePainter(
                    angle: _animation.value,
                    strokeWidth: 7,
                    strokeColor: const Color(0xFFf9a6c4),
                    fillColor: Color.fromARGB(156, 255, 254, 254),
                  ),
                  size: const Size(300, 300),
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Bé dới anh iuu nhaooo được',
                        style: TextStyle(
                          fontFamily: 'sans-serif',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        widget.number.toString(),
                        style: const TextStyle(
                          fontFamily: 'Sen',
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Text(
                        'Ngày goyyy ó',
                        style: TextStyle(
                          fontFamily: 'sans-serif',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final double strokeWidth;
  final Color strokeColor;
  final Color fillColor;
  final double angle;

  CirclePainter({
    required this.strokeWidth,
    required this.strokeColor,
    required this.fillColor,
    required this.angle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Calculate the radius of the circle
    double radius = size.width / 2;

    // Draw the circle with the specified stroke width and color
    Paint circlePaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(Offset(radius, radius), radius, circlePaint);

    // Draw the border with the specified stroke width and color
    Paint borderPaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawArc(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius),
        -3.14 / 2,
        angle,
        false,
        borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
