import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart'; // flutter_colorpicker をインポート
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Picker Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ColorPickerPage(),
    );
  }
}

class ColorPickerPage extends StatefulWidget {
  @override
  _ColorPickerPageState createState() => _ColorPickerPageState();
}

class _ColorPickerPageState extends State<ColorPickerPage> {
  List<Color> _currentColor = [Color.fromRGBO(191, 30, 51, 1)];
  List<Color> shades = [];
  Color? selectedShade;
  Color? selectedColor; // 選択された色を保持する変数を追加
  List<Color> _selectColor = [Colors.black]; // 不要な色を削除
  List<Color> allowedColors = [
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.black,
  ];

  List<Widget> _buildShades(Color color, int index) {
    List<Widget> shadeWidgets = [];
    HSLColor hslColor = HSLColor.fromColor(color);
    for (double i = 1.0; i >= 0.0; i -= 0.25) {
      shadeWidgets.add(
        GestureDetector(
          onTap: () {
            setState(() {
              _currentColor[index] = hslColor.withLightness(i).toColor();
            });
          },
          child: Container(
            width: 50,
            height: 50,
            color: hslColor.withLightness(i).toColor(),
          ),
        ),
      );
    }
    return shadeWidgets;
  }

  Map<Color, String> colorNames = {
    Color.fromRGBO(255, 255, 255, 1): '白',
    Color.fromRGBO(245, 245, 245, 1): '白',
    Color.fromRGBO(191, 191, 191, 1): 'ライトグレー',
    Colors.grey: 'グレー', // グレー
    Color.fromRGBO(137, 137, 137, 1): 'ダークグレー',
    Color.fromRGBO(128, 128, 128, 1): 'グレー',
    Color.fromRGBO(64, 64, 64, 1): 'ダークグレー',
    Color.fromRGBO(255, 215, 0, 1): 'ゴールド',
    Color.fromRGBO(0, 0, 0, 1): '黒',
    Color.fromRGBO(253, 238, 239, 1): '桜色',
    Color.fromRGBO(249, 193, 207, 1): 'ピンク',
    Color.fromRGBO(238, 145, 157, 1): 'ローズピンク',
    Color.fromRGBO(191, 30, 51, 1): '赤',
    Color.fromRGBO(220, 35, 59, 1): '赤',
    Color.fromRGBO(110, 17, 29, 1): 'ボルドー',
    Color.fromRGBO(147, 46, 68, 1): 'ワインレッド',
    Color.fromRGBO(171, 225, 250, 1): 'ライトブルー',
    Color.fromRGBO(128, 196, 255, 1): '水色',
    Color.fromRGBO(0, 137, 255, 1): '青',
    Color.fromRGBO(0, 103, 192, 1): '青',
    Color.fromRGBO(0, 68, 128, 1): '紺',
    Color.fromRGBO(7, 71, 112, 1): 'デニム', // デニム色（濃い）
    Color.fromRGBO(31, 47, 84, 1): 'ネイビー',
    Color.fromRGBO(255, 223, 128, 1): '淡黄',
    Color.fromRGBO(255, 190, 0, 1): '黄',
    Color.fromRGBO(128, 95, 0, 1): '黄土色',
    Color.fromRGBO(231, 208, 169, 1): 'ベージュ', // ベージュ
    Color.fromRGBO(244, 224, 196, 1): 'ベージュ',
    Color.fromRGBO(175, 104, 32, 1): 'ウッド色',
    Color.fromRGBO(165, 218, 180, 1): '薄緑',
    Color.fromRGBO(77, 181, 106, 1): '緑',
    Color.fromRGBO(75, 180, 104, 1): '緑',
    Color.fromRGBO(37, 90, 52, 1): '深緑',
    Color.fromRGBO(116, 144, 93, 1): 'カーキー', // カーキー
    Color.fromRGBO(87, 97, 40, 1): 'オリーブグリーン',
    Color.fromRGBO(183, 168, 204, 1): 'ラベンダー',
    Color.fromRGBO(202, 164, 218, 1): '薄紫',
    Color.fromRGBO(162, 96, 191, 1): '紫',
    Color.fromRGBO(149, 73, 182, 1): '紫',
    Color.fromRGBO(74, 37, 91, 1): '深紫',
    Color.fromRGBO(183, 168, 204, 1): 'ラベンダー',
    Color.fromRGBO(255, 237, 179, 1): 'クリーム色',
    Color.fromRGBO(37, 67, 182, 1): ' デニムブルー',
    Color.fromRGBO(143, 100, 70, 1): 'ブラウン',
    Color.fromRGBO(114, 100, 10, 1): 'オリーブ',
    Color.fromRGBO(113, 89, 166, 1): 'バイオレット',
    Color.fromRGBO(175, 223, 228, 1): 'アクアブルー',
    Color.fromRGBO(144, 206, 156, 1): 'ミントグリーン',
    Color.fromRGBO(255, 255, 224, 1): 'ライトイエロー',
    Color.fromRGBO(96, 15, 24, 1): 'ボルドー',
    Color.fromRGBO(0, 175, 204, 1): 'ターコイズブルー',
    Color.fromRGBO(204, 127, 59, 1): 'キャメル',
    Color.fromRGBO(232, 57, 41, 1): '紅緋',
    Color.fromRGBO(211, 211, 211, 1): 'ライトグレー',
    Color.fromRGBO(255, 167, 148, 1): 'サーモンピンク',
    Color.fromRGBO(209, 186, 218, 1): 'ライラック',
    Color.fromRGBO(255, 255, 240, 1): 'オフホワイト',
    Color.fromRGBO(107, 142, 35, 1): 'カーキグリーン',
    Color.fromRGBO(164, 166, 168, 1): 'チャイコールグレー',
    Color.fromRGBO(196, 153, 97, 1): 'キャメル',
    Color.fromRGBO(181, 101, 29, 1): 'ライトブラウン',
    Color.fromRGBO(101, 67, 33, 1): 'ダークブラウン',
    Colors.green: 'グリーン',
    Color.fromRGBO(0, 0, 128, 1): 'ナビーブルー',
    Color.fromRGBO(119, 0, 48, 1): 'バーガンディ',
    Color.fromRGBO(210, 180, 140, 1): 'タン',
    Color.fromRGBO(135, 206, 235, 1): 'スカイブルー',
    Color.fromRGBO(171, 154, 134, 1): 'グレージュ',
    Color.fromRGBO(144, 238, 144, 1): 'ライトグリーン',
    Color.fromRGBO(65, 105, 225, 1): 'ロイヤルブルー',
    Color.fromRGBO(192, 192, 192, 1): 'シルバー',

    // 他の色に対する名称も追加できます
  };

  void _showPicker(BuildContext context, int index) {
    Color selectedColor = _currentColor[index];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Pick a color'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    BlockPicker(
                      pickerColor: selectedColor,
                      onColorChanged: (color) {
                        setState(() {
                          selectedColor = color;
                          _currentColor[index] = color;
                        });
                      },
                      availableColors: [
                        Color.fromRGBO(191, 30, 51, 1),
                        Color.fromRGBO(255, 190, 0, 1),
                        Color.fromRGBO(77, 181, 106, 1),
                        Color.fromRGBO(0, 103, 192, 1),
                        Color.fromRGBO(162, 96, 191, 1),
                        Colors.white,
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Select Shade:',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _buildShades(selectedColor, index),
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 背景色を白に設定
      appBar: AppBar(
        title: Center(
          child: Text(
            '今日はどんな色の服を着る？',
            textAlign: TextAlign.center,
            style: GoogleFonts.zenMaruGothic(
              color: Color.fromARGB(255, 10, 0, 0),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (int i = 0; i < _currentColor.length; i++)
              ElevatedButton(
                child: Text('Button $i'),
                style: ElevatedButton.styleFrom(
                    primary: _currentColor[i],
                    onPrimary: _currentColor[i],
                    shadowColor: Colors.transparent,
                    shape: CircleBorder(),
                    fixedSize: Size(180, 180),
                    side: BorderSide(
                      color: Colors.black,
                    )),
                onPressed: () {
                  _showPicker(context, i);
                },
              ),

            //余白
            SizedBox(height: 80),

            //OKボタン
            OutlinedButton(
              child: const Text(
                'OK',
                textAlign: TextAlign.center,
                style: TextStyle(
                  letterSpacing: 4.0, // 文字の間隔を設定する
                ),
              ),
              style: OutlinedButton.styleFrom(
                primary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fixedSize: Size.fromHeight(60),
                padding: EdgeInsets.symmetric(horizontal: 50),
                side: const BorderSide(),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Select1(
                              selectedColor: _currentColor[0],
                              colorNames:
                                  colorNames, // Provide the colorNames argument here
                            )));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Select1 extends StatelessWidget {
  final Color selectedColor;
  final Map<Color, String> colorNames;

  const Select1({
    Key? key,
    required this.selectedColor,
    required this.colorNames,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white, // 背景色を白に設定
        appBar: AppBar(
          title: Center(
            child: Text(
              'ファッションスタイルは？',
              style: GoogleFonts.zenMaruGothic(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ), // タイトルのテキストカラーを黒に設定
            ),
          ),
          backgroundColor: Colors.white, // AppBar の背景色を白に設定
        ),
        body: Center(
          child: Container(
            width: 390,
            height: 844,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: Colors.white),
            child: Stack(
              children: [
                Positioned(
                  left: 110,
                  top: 170,
                  child: OutlinedButton(
                    child: const Text(
                      'Ladies',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        letterSpacing: 4.0, // 文字の間隔を設定する
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      primary: Colors.black,
                      backgroundColor:
                          Color.fromARGB(255, 238, 209, 143), // 背景色を水色に設定

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fixedSize: Size(200, 60), // 幅と高さを指定
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      side: const BorderSide(),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FirstA(
                                    selectedColor: selectedColor,
                                    colorNames: colorNames,
                                  )));
                    },
                  ),
                ),
                Positioned(
                  left: 110,
                  top: 350,
                  child: OutlinedButton(
                    child: const Text(
                      'men’s',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        letterSpacing: 4.0, // 文字の間隔を設定する
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      primary: Colors.black,
                      backgroundColor:
                          Color.fromARGB(255, 163, 205, 225), // 背景色を水色に設定
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fixedSize: Size(200, 60), // 幅と高さを指定
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      side: const BorderSide(),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FirstB(
                                    selectedColor: selectedColor,
                                    colorNames: colorNames,
                                  )));
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class FirstA extends StatelessWidget {
  final Color selectedColor;
  final Map<Color, String> colorNames;

  const FirstA({
    Key? key,
    required this.selectedColor,
    required this.colorNames,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String colorName = colorNames[selectedColor] ?? 'Unknown';

    return Scaffold(
      backgroundColor: Colors.white, // 背景色を白に設定
      appBar: AppBar(
        title: Center(
          child: Text(
            'コーディネート色',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black), // タイトルのテキストカラーを黒に設定
          ),
        ),
        backgroundColor: Colors.white, // AppBar の背景色を白に設定
      ),
      body: Stack(children: [
        Positioned(
          left: (MediaQuery.of(context).size.width - 146) / 2,
          top: 165,
          child: SizedBox(
            width: 150,
            height: 45,
            child: Text(
              colorName, // 色の名称を表示
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 0,
                letterSpacing: 2.20,
              ),
            ),
          ),
        ),
        Positioned(
          left: (MediaQuery.of(context).size.width - 136) / 2,
          top: 20,
          child: Container(
            width: 136,
            height: 136,
            decoration: ShapeDecoration(
              color: selectedColor,
              shape: CircleBorder(
                side: BorderSide(
                  color: Colors.black, // 枠線の色を設定
                  width: 1.0, // 枠線の幅を設定
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          top: 220,
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(), // 常にスクロール可能にする
            children: [
              Center(
                child: Container(
                  width: 390,
                  height: 600,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Stack(children: [
                    Positioned(
                      left: (390 - 280) / 2,
                      top: 50,
                      child: OutlinedButton(
                        child: SizedBox(
                          width: 242,
                          height: 58,
                          child: Text(
                            'カジュアル',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.zenMaruGothic(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                              height: 1.7,
                              letterSpacing: 4.4,
                            ),
                          ),
                        ),
                        // カジュアルに対応する画面遷移
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SecondA(
                                      selectedColor: selectedColor,
                                      colorNames: colorNames,
                                    )),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      left: (390 - 280) / 2,
                      top: 150,
                      child: OutlinedButton(
                        child: SizedBox(
                          width: 242,
                          height: 58,
                          child: Text(
                            'フェミニン',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.zenMaruGothic(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                              height: 1.7,
                              letterSpacing: 4.4,
                            ),
                          ),
                        ),
                        // フェミニンに対応する画面遷移
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SecondB(
                                      selectedColor: selectedColor,
                                      colorNames: colorNames,
                                    )),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      left: (390 - 280) / 2,
                      top: 250,
                      child: OutlinedButton(
                        child: SizedBox(
                          width: 242,
                          height: 58,
                          child: Text(
                            'ボーイッシュ',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.zenMaruGothic(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                              height: 1.7,
                              letterSpacing: 4.4,
                            ),
                          ),
                        ),
                        // きれいめに対応する画面遷移
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SecondC(
                                      selectedColor: selectedColor,
                                      colorNames: colorNames,
                                    )),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      left: (390 - 280) / 2,
                      top: 350,
                      child: OutlinedButton(
                        child: SizedBox(
                          width: 242,
                          height: 58,
                          child: Text(
                            'ガーリー',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.zenMaruGothic(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                              height: 1.7,
                              letterSpacing: 4.4,
                            ),
                          ),
                        ),
                        // ガーリーに対応する画面遷移
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SecondD(
                                      selectedColor: selectedColor,
                                      colorNames: colorNames,
                                    )),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      left: (390 - 280) / 2,
                      top: 450,
                      child: OutlinedButton(
                        child: SizedBox(
                          width: 242,
                          height: 58,
                          child: Text(
                            'ナチュラル',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.zenMaruGothic(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                              height: 1.7,
                              letterSpacing: 4.4,
                            ),
                          ),
                        ),
                        // ナチュラルに対応する画面遷移
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SecondE(
                                      selectedColor: selectedColor,
                                      colorNames: colorNames,
                                    )),
                          );
                        },
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class FirstB extends StatelessWidget {
  final Color selectedColor;
  final Map<Color, String> colorNames;

  const FirstB({
    Key? key,
    required this.selectedColor,
    required this.colorNames,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String colorName = colorNames[selectedColor] ?? 'Unknown';

    return Scaffold(
      backgroundColor: Colors.white, // 背景色を白に設定
      appBar: AppBar(
        title: Center(
          child: Text(
            'コーディネート色',
            textAlign: TextAlign.center,
            style: GoogleFonts.zenMaruGothic(
                color: Colors.black,
                fontWeight: FontWeight.w500), // タイトルのテキストカラーを黒に設定
          ),
        ),
        backgroundColor: Colors.white, // AppBar の背景色を白に設定
      ),
      body: Stack(children: [
        Positioned(
          left: (MediaQuery.of(context).size.width - 146) / 2,
          top: 165,
          child: SizedBox(
            width: 150,
            height: 45,
            child: Text(
              colorName, // 色の名称を表示
              textAlign: TextAlign.center,
              style: GoogleFonts.zenMaruGothic(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                height: 0,
                letterSpacing: 2.20,
              ),
            ),
          ),
        ),
        Positioned(
          left: (MediaQuery.of(context).size.width - 136) / 2,
          top: 20,
          child: Container(
            width: 136,
            height: 136,
            decoration: ShapeDecoration(
              color: selectedColor,
              shape: CircleBorder(
                side: BorderSide(
                  color: Colors.black, // 枠線の色を設定
                  width: 1.0, // 枠線の幅を設定
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          top: 220,
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(), // 常にスクロール可能にする
            children: [
              Center(
                child: Container(
                  width: 390,
                  height: 600,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Stack(children: [
                    Positioned(
                      left: (390 - 280) / 2,
                      top: 50,
                      child: OutlinedButton(
                        child: SizedBox(
                          width: 242,
                          height: 58,
                          child: Text(
                            'カジュアル',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.zenMaruGothic(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                              height: 1.7,
                              letterSpacing: 4.4,
                            ),
                          ),
                        ),
                        // カジュアルに対応する画面遷移
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Second2A(
                                      selectedColor: selectedColor,
                                      colorNames: colorNames,
                                    )),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      left: (390 - 280) / 2,
                      top: 150,
                      child: OutlinedButton(
                        child: SizedBox(
                          width: 242,
                          height: 58,
                          child: Text(
                            'ゆるカジ',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.zenMaruGothic(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                              height: 1.7,
                              letterSpacing: 4.4,
                            ),
                          ),
                        ),
                        // ゆるカジに対応する画面遷移
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Second2B(
                                      selectedColor: selectedColor,
                                      colorNames: colorNames,
                                    )),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      left: (390 - 280) / 2,
                      top: 250,
                      child: OutlinedButton(
                        child: SizedBox(
                          width: 242,
                          height: 58,
                          child: Text(
                            'スポーツ',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.zenMaruGothic(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                              height: 1.7,
                              letterSpacing: 4.4,
                            ),
                          ),
                        ),
                        // スポーツに対応する画面遷移
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Second2C(
                                      selectedColor: selectedColor,
                                      colorNames: colorNames,
                                    )),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      left: (390 - 280) / 2,
                      top: 350,
                      child: OutlinedButton(
                        child: SizedBox(
                          width: 242,
                          height: 58,
                          child: Text(
                            'モード',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.zenMaruGothic(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                              height: 1.7,
                              letterSpacing: 4.4,
                            ),
                          ),
                        ),
                        // モードに対応する画面遷移
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Second2D(
                                      selectedColor: selectedColor,
                                      colorNames: colorNames,
                                    )),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      left: (390 - 280) / 2,
                      top: 450,
                      child: OutlinedButton(
                        child: SizedBox(
                          width: 242,
                          height: 58,
                          child: Text(
                            'ナチュラル',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.zenMaruGothic(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                              height: 1.7,
                              letterSpacing: 4.4,
                            ),
                          ),
                        ),
                        // ナチュラルに対応する画面遷移
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Second2E(
                                      selectedColor: selectedColor,
                                      colorNames: colorNames,
                                    )),
                          );
                        },
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

//カジュアル（女）の画面遷移
class SecondA extends StatelessWidget {
  final Color selectedColor;
  final Map<Color, String> colorNames;

  const SecondA({
    Key? key,
    required this.selectedColor,
    required this.colorNames,
  }) : super(key: key);

  List<Color> generateDifferentColors(Color baseColor) {
    List<Color> differentColors = [];

    // 選択した色ごとに異なる色を生成
    if (baseColor == Color.fromRGBO(255, 255, 255, 1)) {
      differentColors.add(Color.fromRGBO(37, 67, 182, 1)); // デニムブルー
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Color.fromRGBO(143, 100, 70, 1)); // ブラウン
      differentColors.add(Color.fromRGBO(114, 100, 10, 1)); // オリーブ
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
    } else if (baseColor == Color.fromRGBO(238, 145, 157, 1)) {
      differentColors.add(Color.fromRGBO(37, 67, 182, 1)); // デニムブルー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); //白
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
    } else if (baseColor == Color.fromRGBO(191, 30, 51, 1)) {
      differentColors.add(Color.fromRGBO(37, 67, 182, 1)); // デニムブルー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); //白
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
    } else if (baseColor == Color.fromRGBO(220, 35, 59, 1)) {
      differentColors.add(Color.fromRGBO(37, 67, 182, 1)); // デニムブルー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); //白
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
    } else if (baseColor == Color.fromRGBO(110, 17, 29, 1)) {
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
      differentColors.add(Color.fromRGBO(164, 166, 168, 1)); // チャイコールグレー
      differentColors.add(Color.fromRGBO(87, 97, 40, 1)); // オリーブグリーン
      differentColors.add(Color.fromRGBO(171, 225, 250, 1)); // ライトブルー
    } else if (baseColor == Color.fromRGBO(0, 0, 0, 1)) {
      differentColors.add(Color.fromRGBO(7, 71, 112, 1)); // デニム色（濃い）
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Colors.black); // 黒
      differentColors.add(Colors.white); // 白
      differentColors.add(Color.fromRGBO(231, 208, 169, 1)); // ベージュ
      differentColors.add(Color.fromRGBO(116, 144, 93, 1)); // カーキー
    } else if (baseColor == Color.fromRGBO(191, 191, 191, 1) ||
        baseColor == Color.fromRGBO(128, 128, 128, 1) ||
        baseColor == Color.fromRGBO(64, 64, 64, 1)) {
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); //白
      differentColors.add(Color.fromRGBO(87, 97, 40, 1)); // オリーブグリーン
    } else if (baseColor == Color.fromRGBO(128, 95, 0, 1)) {
      differentColors.add(Color.fromRGBO(255, 237, 179, 1)); // クリーム色
      differentColors.add(Color.fromRGBO(0, 0, 128, 1)); // ナビーブルー
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Color.fromRGBO(87, 97, 40, 1)); // オリーブグリーン
    } else if (baseColor == Color.fromRGBO(128, 196, 255, 1)) {
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
      differentColors.add(Colors.green); // 緑
      differentColors.add(Color.fromRGBO(255, 255, 224, 1)); // ライトイエロー
    } else if (baseColor == Color.fromRGBO(0, 137, 255, 1)) {
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
      differentColors.add(Colors.green); // 緑
      differentColors.add(Color.fromRGBO(255, 255, 224, 1)); // ライトイエロー
    } else if (baseColor == Color.fromRGBO(0, 68, 128, 1)) {
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(171, 225, 250, 1)); // ライトブルー
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
      differentColors.add(Color.fromRGBO(231, 208, 169, 1)); //be-jyu
    } else if (baseColor == Color.fromRGBO(165, 218, 180, 1)) {
      differentColors.add(Color.fromRGBO(37, 67, 182, 1)); // デニムブルー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(231, 208, 169, 1)); //be-jyu
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
    } else if (baseColor == Color.fromRGBO(75, 180, 104, 1)) {
      differentColors.add(Color.fromRGBO(143, 100, 70, 1)); // ブラウン
      differentColors.add(Color.fromRGBO(244, 224, 196, 1)); // ベージュ
      differentColors.add(Colors.grey); // グレー
    } else if (baseColor == Color.fromRGBO(37, 90, 52, 1)) {
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
      differentColors.add(Color.fromRGBO(143, 100, 70, 1)); // ブラウン
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
    } else if (baseColor == Color.fromRGBO(255, 223, 128, 1)) {
      differentColors.add(Color.fromRGBO(135, 206, 235, 1)); // スカイブルー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
      differentColors.add(Color.fromRGBO(244, 224, 196, 1)); // ベージュ
    } else if (baseColor == Color.fromRGBO(255, 190, 0, 1)) {
      differentColors.add(Color.fromRGBO(37, 67, 182, 1)); // デニムブルー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
      differentColors.add(Colors.grey); // グレー
    } else if (baseColor == Color.fromRGBO(128, 95, 0, 1)) {
      differentColors.add(Color.fromRGBO(101, 67, 33, 1)); // ダークブラウン
      differentColors.add(Color.fromRGBO(107, 142, 35, 1)); // オリーブグリーン
      differentColors.add(Colors.grey); // グレー
    }

    // リストをシャッフルする
    differentColors.shuffle();

    return differentColors;
  }

  @override
  Widget build(BuildContext context) {
    String colorName = colorNames[selectedColor] ?? 'Unknown';

    return Scaffold(
      backgroundColor: Colors.white, // 背景色を白に設定
      appBar: AppBar(
        title: Center(
          child: Text(
            'カジュアル',
            textAlign: TextAlign.center,
            style: GoogleFonts.zenMaruGothic(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ), // タイトルのテキストカラーを設定
          ),
        ),
        backgroundColor: Colors.white, // AppBar の背景色を白に設定
      ),
      body: Stack(
        children: [
          // 選択した色を反映する円
          Positioned(
            left: (MediaQuery.of(context).size.width - 136) / 2,
            top: 50,
            child: Container(
              width: 136,
              height: 136,
              decoration: ShapeDecoration(
                color: selectedColor,
                shape: CircleBorder(
                  side: BorderSide(
                    color: Colors.black, // 枠線の色を設定
                    width: 1.0, // 枠線の幅を設定
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              left: (MediaQuery.of(context).size.width - 146) / 2,
              top: 200,
              child: SizedBox(
                width: 150,
                height: 45,
                child: Text(
                  colorName,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.zenMaruGothic(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 0,
                    letterSpacing: 2.20,
                  ),
                ),
              )),
          // ×
          Positioned(
            left: (MediaQuery.of(context).size.width - 54) / 2,
            top: 215,
            child: SizedBox(
              width: 51,
              height: 78,
              child: Text(
                '×',
                textAlign: TextAlign.center,
                style: GoogleFonts.zenMaruGothic(
                  color: Colors.black,
                  fontSize: 55,
                  fontWeight: FontWeight.w500,
                  height: 0,
                  letterSpacing: 7.04,
                ),
              ),
            ),
          ),
          // スクロール可能な円
          Positioned.fill(
            top: 314,
            child: ListView(
              children: [
                // 選択した色ごとに異なる色を生成し、生成した色をランダムな順番で表示
                ...generateDifferentColors(selectedColor).map((color) {
                  return _buildCircle(colorNames[color] ?? 'Unknown', color);
                }).toList(),
                SizedBox(
                  height: 200, // 余白の高さ
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircle(String colorName, Color color) {
    return Column(
      children: [
        Container(
          width: 136,
          height: 141,
          decoration: ShapeDecoration(
            color: color,
            shape: CircleBorder(
              side: BorderSide(
                color: Colors.black, // 枠線の色を設定
                width: 1.0, // 枠線の幅を設定
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          width: 230,
          height: 45,
          child: Text(
            colorName,
            textAlign: TextAlign.center,
            style: GoogleFonts.zenMaruGothic(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              height: 0,
              letterSpacing: 2.20,
            ),
          ),
        ),
        SizedBox(
          height: 20, // 余白の高さ
        ),
      ],
    );
  }
}

//フェミニンの画面遷移
class SecondB extends StatelessWidget {
  final Color selectedColor;
  final Map<Color, String> colorNames;

  const SecondB({
    Key? key,
    required this.selectedColor,
    required this.colorNames,
  }) : super(key: key);

  List<Color> generateDifferentColors(Color baseColor) {
    List<Color> differentColors = [];

    // 選択した色ごとに異なる色を生成
    if (baseColor == Color.fromRGBO(255, 255, 255, 1)) {
      differentColors.add(Color.fromRGBO(249, 193, 207, 1)); // ピンク
      differentColors.add(Color.fromRGBO(113, 89, 166, 1)); // バイオレット
      differentColors.add(Color.fromRGBO(175, 223, 228, 1)); // アクアブルー
      differentColors.add(Color.fromRGBO(144, 206, 156, 1)); // ミントグリーン
      differentColors.add(Color.fromRGBO(255, 255, 224, 1)); // ライトイエロー
    } else if (baseColor == Color.fromRGBO(238, 145, 157, 1)) {
      differentColors.add(Color.fromRGBO(249, 193, 207, 1)); // ピンク
      differentColors.add(Color.fromRGBO(183, 168, 204, 1)); // ラベンダー
      differentColors.add(Color.fromRGBO(255, 237, 179, 1)); // クリーム色
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); //白
    } else if (baseColor == Color.fromRGBO(191, 30, 51, 1) ||
        baseColor == Color.fromRGBO(220, 35, 59, 1)) {
      differentColors.add(Color.fromRGBO(255, 167, 148, 1)); // サーモンピンク
      differentColors.add(Color.fromRGBO(209, 186, 218, 1)); //ライラック
      differentColors.add(Color.fromRGBO(255, 237, 179, 1)); // クリーム色
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); //白
    } else if (baseColor == Color.fromRGBO(110, 17, 29, 1)) {
      differentColors.add(Color.fromRGBO(255, 167, 148, 1)); // サーモンピンク
      differentColors.add(Color.fromRGBO(255, 237, 179, 1)); // クリーム色
      differentColors.add(Color.fromRGBO(183, 168, 204, 1)); // ラベンダー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); //白
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
    } else if (baseColor == Color.fromRGBO(0, 0, 0, 1)) {
      differentColors.add(Color.fromRGBO(253, 238, 239, 1)); // 桜色
      differentColors.add(Color.fromRGBO(175, 104, 32, 1)); // ウッド色
      differentColors.add(Color.fromRGBO(147, 46, 68, 1)); // ワインレッド
      differentColors.add(Color.fromRGBO(183, 168, 204, 1)); // ラベンダー
      differentColors.add(Colors.white); // 白
    } else if (baseColor == Color.fromRGBO(191, 191, 191, 1) ||
        baseColor == Color.fromRGBO(128, 128, 128, 1) ||
        baseColor == Color.fromRGBO(64, 64, 64, 1)) {
      differentColors.add(Color.fromRGBO(255, 102, 204, 1)); // ローズピンク
      differentColors.add(Color.fromRGBO(183, 168, 204, 1)); // ラベンダー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); //白
      differentColors.add(Color.fromRGBO(255, 237, 179, 1)); // クリーム色
    } else if (baseColor == Color.fromRGBO(128, 95, 0, 1)) {
      differentColors.add(Color.fromRGBO(238, 145, 157, 1)); // ローズピンク
      differentColors.add(Color.fromRGBO(183, 168, 204, 1)); // ラベンダー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); //白
      differentColors.add(Color.fromRGBO(171, 225, 250, 1)); // ライトブルー
    } else if (baseColor == Color.fromRGBO(128, 196, 255, 1)) {
      differentColors.add(Color.fromRGBO(255, 102, 204, 1)); // pinnku
      differentColors.add(Color.fromRGBO(183, 168, 204, 1)); // ライトグレー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // siro
      differentColors.add(Color.fromRGBO(255, 255, 224, 1)); // ライトイエロー
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); //黒
    } else if (baseColor == Color.fromRGBO(0, 137, 255, 1)) {
      differentColors.add(Color.fromRGBO(255, 102, 204, 1)); // pinnku
      differentColors.add(Color.fromRGBO(183, 168, 204, 1)); // ライトグレー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // siro
      differentColors.add(Color.fromRGBO(255, 255, 224, 1)); // ライトイエロー
    } else if (baseColor == Color.fromRGBO(0, 68, 128, 1)) {
      differentColors.add(Color.fromRGBO(255, 102, 204, 1)); // 白
      differentColors.add(Color.fromRGBO(183, 168, 204, 1)); // ライトグレー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 緑
      differentColors.add(Color.fromRGBO(255, 255, 224, 1)); // ライトイエロー
    } else if (baseColor == Color.fromRGBO(165, 218, 180, 1)) {
      differentColors.add(Color.fromRGBO(255, 182, 193, 1)); // ローズピンク
      differentColors.add(Color.fromRGBO(183, 168, 204, 1)); // ラベンダー
      differentColors.add(Color.fromRGBO(255, 237, 179, 1)); // クリーム色
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // ホワイト
    } else if (baseColor == Color.fromRGBO(75, 180, 104, 1)) {
      differentColors.add(Color.fromRGBO(249, 193, 207, 1)); // ピンク
      differentColors.add(Color.fromRGBO(183, 168, 204, 1)); // ラベンダー
      differentColors.add(Color.fromRGBO(255, 237, 179, 1)); // クリーム色
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
    } else if (baseColor == Color.fromRGBO(37, 90, 52, 1)) {
      differentColors.add(Color.fromRGBO(255, 204, 204, 1)); // 桃色
      differentColors.add(Color.fromRGBO(255, 237, 179, 1)); // クリーム色
      differentColors.add(Color.fromRGBO(183, 168, 204, 1)); // ラベンダー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
    } else if (baseColor == Color.fromRGBO(255, 223, 128, 1)) {
      differentColors.add(Color.fromRGBO(249, 193, 207, 1)); // ピンク
      differentColors.add(Color.fromRGBO(183, 168, 204, 1)); // ラベンダー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(144, 206, 156, 1)); // ミントグリーン
    } else if (baseColor == Color.fromRGBO(255, 190, 0, 1)) {
      differentColors.add(Color.fromRGBO(255, 204, 204, 1)); // 桃色
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(144, 206, 156, 1)); // ミントグリーン
      differentColors.add(Color.fromRGBO(183, 168, 204, 1)); // ラベンダー
    } else if (baseColor == Color.fromRGBO(128, 95, 0, 1)) {
      differentColors.add(Color.fromRGBO(249, 193, 207, 1)); // ピンク
      differentColors.add(Color.fromRGBO(183, 168, 204, 1)); // ラベンダー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(173, 216, 230, 1)); // ライトブルー
    }

    // リストをシャッフルする
    differentColors.shuffle();

    return differentColors;
  }

  @override
  Widget build(BuildContext context) {
    String colorName = colorNames[selectedColor] ?? 'Unknown';

    return Scaffold(
      backgroundColor: Colors.white, // 背景色を白に設定
      appBar: AppBar(
        title: Center(
            child: Text(
          'フェミニン',
          textAlign: TextAlign.center,
          style: GoogleFonts.zenMaruGothic(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ), // タイトルのテキストカラーを設定
        )),
        backgroundColor: Colors.white, // AppBar の背景色を白に設定
      ),
      body: Stack(
        children: [
          // 選択した色を反映する円
          Positioned(
            left: (MediaQuery.of(context).size.width - 136) / 2,
            top: 50,
            child: Container(
              width: 136,
              height: 136,
              decoration: ShapeDecoration(
                color: selectedColor,
                shape: CircleBorder(
                  side: BorderSide(
                    color: Colors.black, // 枠線の色を設定
                    width: 1.0, // 枠線の幅を設定
                  ),
                ),
              ),
            ),
          ),
//色の名前表示
          Positioned(
              left: (MediaQuery.of(context).size.width - 146) / 2,
              top: 200,
              child: SizedBox(
                width: 150,
                height: 45,
                child: Text(
                  colorName,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.zenMaruGothic(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 0,
                    letterSpacing: 2.20,
                  ),
                ),
              )),
          // 「×」
          Positioned(
            left: (MediaQuery.of(context).size.width - 54) / 2,
            top: 215,
            child: SizedBox(
              width: 51,
              height: 78,
              child: Text(
                '×',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 64,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                  letterSpacing: 7.04,
                ),
              ),
            ),
          ),
          // スクロール可能な円
          Positioned.fill(
            top: 314,
            child: ListView(
              children: [
                // 選択した色ごとに異なる色を生成し、生成した色をランダムな順番で表示
                ...generateDifferentColors(selectedColor).map((color) {
                  return _buildCircle(colorNames[color] ?? 'Unknown', color);
                }).toList(),
                SizedBox(
                  height: 200, // 余白の高さ
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircle(String colorName, Color color) {
    return Column(
      children: [
        Container(
          width: 136,
          height: 141,
          decoration: ShapeDecoration(
            color: color,
            shape: CircleBorder(
              side: BorderSide(
                color: Colors.black, // 枠線の色を設定
                width: 1.0, // 枠線の幅を設定
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          width: 230,
          height: 45,
          child: Text(
            colorName,
            textAlign: TextAlign.center,
            style: GoogleFonts.zenMaruGothic(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              height: 0,
              letterSpacing: 2.20,
            ),
          ),
        ),
        SizedBox(
          height: 20, // 余白の高さ
        ),
      ],
    );
  }
}

//ボーイッシュの画面遷移
class SecondC extends StatelessWidget {
  final Color selectedColor;
  final Map<Color, String> colorNames;

  const SecondC({
    Key? key,
    required this.selectedColor,
    required this.colorNames,
  }) : super(key: key);

  List<Color> generateDifferentColors(Color baseColor) {
    List<Color> differentColors = [];

    // 選択した色ごとに異なる色を生成
    if (baseColor == Color.fromRGBO(255, 255, 255, 1)) {
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒,
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
      differentColors.add(Color.fromRGBO(87, 97, 40, 1)); // オリーブグリーン
      differentColors.add(Color.fromRGBO(96, 15, 24, 1)); // ボルドー
    } else if (baseColor == Color.fromRGBO(238, 145, 157, 1)) {
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); //黒
      differentColors.add(Color.fromRGBO(137, 137, 137, 1)); // ダークグレー
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
      differentColors.add(Colors.grey); // グレー
    } else if (baseColor == Color.fromRGBO(191, 30, 51, 1) ||
        baseColor == Color.fromRGBO(220, 35, 59, 1)) {
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
      differentColors.add(Color.fromRGBO(137, 137, 137, 1)); // ダークグレー
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
      differentColors.add(Colors.grey); // グレー
    } else if (baseColor == Color.fromRGBO(110, 17, 29, 1)) {
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
      differentColors.add(Color.fromRGBO(107, 142, 35, 1)); // カーキグリーン
    } else if (baseColor == Color.fromRGBO(0, 0, 0, 1)) {
      differentColors.add(Colors.black); // 黒
      differentColors.add(Color.fromRGBO(137, 137, 137, 1)); // ダークグレー
      differentColors.add(Colors.white); // 白
      differentColors.add(Color.fromRGBO(87, 97, 40, 1)); // オリーブグリーン
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
    } else if (baseColor == Color.fromRGBO(191, 191, 191, 1) ||
        baseColor == Color.fromRGBO(128, 128, 128, 1) ||
        baseColor == Color.fromRGBO(64, 64, 64, 1)) {
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
      differentColors.add(Color.fromRGBO(87, 97, 40, 1)); // オリーブグリーン
      differentColors.add(Color.fromRGBO(196, 153, 97, 1)); // キャメル
    } else if (baseColor == Color.fromRGBO(128, 95, 0, 1)) {
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Color.fromRGBO(116, 144, 93, 1)); // カーキー
    } else if (baseColor == Color.fromRGBO(128, 196, 255, 1)) {
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
      differentColors.add(Color.fromRGBO(116, 144, 93, 1)); // カーキ
    } else if (baseColor == Color.fromRGBO(0, 137, 255, 1)) {
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
      differentColors.add(Color.fromRGBO(116, 144, 93, 1)); // カーキ
    } else if (baseColor == Color.fromRGBO(0, 68, 128, 1)) {
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
      differentColors.add(Color.fromRGBO(137, 137, 137, 1)); // ダークグレー
      differentColors.add(Color.fromRGBO(119, 0, 48, 1)); //バーガンディ
    } else if (baseColor == Color.fromRGBO(165, 218, 180, 1)) {
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Color.fromRGBO(116, 144, 93, 1)); // カーキ
    } else if (baseColor == Color.fromRGBO(75, 180, 104, 1)) {
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
    } else if (baseColor == Color.fromRGBO(37, 90, 52, 1)) {
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // ブラック
      differentColors.add(Color.fromRGBO(210, 180, 140, 1)); // タン
    } else if (baseColor == Color.fromRGBO(255, 223, 128, 1)) {
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
      differentColors.add(Color.fromRGBO(116, 144, 93, 1)); // カーキ
    } else if (baseColor == Color.fromRGBO(255, 190, 0, 1)) {
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Color.fromRGBO(143, 100, 70, 1)); // ブラウン
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
    } else if (baseColor == Color.fromRGBO(128, 95, 0, 1)) {
      differentColors.add(Color.fromRGBO(0, 0, 128, 1)); // ネイビーブルー
      differentColors.add(Color.fromRGBO(107, 142, 35, 1)); // オリーブグリーン
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Color.fromRGBO(101, 67, 33, 1)); // ダークブラウン
    }

    // リストをシャッフルする
    differentColors.shuffle();

    return differentColors;
  }

  @override
  Widget build(BuildContext context) {
    String colorName = colorNames[selectedColor] ?? 'Unknown';

    return Scaffold(
      backgroundColor: Colors.white, // 背景色を白に設定
      appBar: AppBar(
        title: Center(
            child: Text(
          'ボーイッシュ',
          textAlign: TextAlign.center,
          style: GoogleFonts.zenMaruGothic(
              color: Colors.black,
              fontWeight: FontWeight.w500), // タイトルのテキストカラーを設定
        )),

        backgroundColor: Colors.white, // AppBar の背景色を白に設定
      ),
      body: Stack(
        children: [
          // 選択した色を反映する円
          Positioned(
            left: (MediaQuery.of(context).size.width - 136) / 2,
            top: 50,
            child: Container(
              width: 136,
              height: 136,
              decoration: ShapeDecoration(
                color: selectedColor,
                shape: CircleBorder(
                  side: BorderSide(
                    color: Colors.black, // 枠線の色を設定
                    width: 1.0, // 枠線の幅を設定
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              left: (MediaQuery.of(context).size.width - 146) / 2,
              top: 200,
              child: SizedBox(
                width: 150,
                height: 45,
                child: Text(
                  colorName,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.zenMaruGothic(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 0,
                    letterSpacing: 2.20,
                  ),
                ),
              )),

          // 「×」
          Positioned(
            left: (MediaQuery.of(context).size.width - 54) / 2,
            top: 215,
            child: SizedBox(
              width: 51,
              height: 78,
              child: Text(
                '×',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 55,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  height: 0,
                  letterSpacing: 7.04,
                ),
              ),
            ),
          ),
          // スクロール可能な円
          Positioned.fill(
            top: 314,
            child: ListView(
              children: [
                // 選択した色ごとに異なる色を生成し、生成した色をランダムな順番で表示
                ...generateDifferentColors(selectedColor).map((color) {
                  return _buildCircle(colorNames[color] ?? 'Unknown', color);
                }).toList(),
                SizedBox(
                  height: 200, // 余白の高さ
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircle(String colorName, Color color) {
    return Column(
      children: [
        Container(
          width: 136,
          height: 141,
          decoration: ShapeDecoration(
            color: color,
            shape: CircleBorder(
              side: BorderSide(
                color: Colors.black, // 枠線の色を設定
                width: 1.0, // 枠線の幅を設定
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          width: 230,
          height: 45,
          child: Text(
            colorName,
            textAlign: TextAlign.center,
            style: GoogleFonts.zenMaruGothic(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              height: 0,
              letterSpacing: 2.20,
            ),
          ),
        ),
        SizedBox(
          height: 20, // 余白の高さ
        ),
      ],
    );
  }
}

//ガーリーの画面遷移
class SecondD extends StatelessWidget {
  final Color selectedColor;
  final Map<Color, String> colorNames;

  const SecondD({
    Key? key,
    required this.selectedColor,
    required this.colorNames,
  }) : super(key: key);

  List<Color> generateDifferentColors(Color baseColor) {
    List<Color> differentColors = [];

    // 選択した色ごとに異なる色を生成
    if (baseColor == Color.fromRGBO(255, 255, 255, 1)) {
      differentColors.add(Color.fromRGBO(232, 57, 41, 1)); // 紅緋
      differentColors.add(Color.fromRGBO(249, 193, 207, 1)); // ピンク
      differentColors.add(Color.fromRGBO(183, 168, 204, 1)); // ラ紅緋ベンダー
      differentColors.add(Color.fromRGBO(144, 206, 156, 1)); // ミントグリーン
      differentColors.add(Color.fromRGBO(0, 175, 204, 1)); // ターコイズブルー
    } else if (baseColor == Color.fromRGBO(238, 145, 157, 1)) {
      differentColors.add(Color.fromRGBO(249, 193, 207, 1)); // ピンク
      differentColors.add(Color.fromRGBO(255, 255, 224, 1)); // ライトイエロー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); //白
      differentColors.add(Color.fromRGBO(183, 168, 204, 1)); // ラベンダー
    } else if (baseColor == Color.fromRGBO(191, 30, 51, 1) ||
        baseColor == Color.fromRGBO(220, 35, 59, 1)) {
      differentColors.add(Color.fromRGBO(249, 193, 207, 1)); // ピンク
      differentColors.add(Color.fromRGBO(171, 225, 250, 1)); // ライトブルー
      differentColors.add(Color.fromRGBO(183, 168, 204, 1)); // ラベンダー
      differentColors.add(Color.fromRGBO(255, 255, 224, 1)); // ライトイエロー
    } else if (baseColor == Color.fromRGBO(110, 17, 29, 1)) {
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); //白
      differentColors.add(Color.fromRGBO(255, 237, 179, 1)); // クリーム色
      differentColors.add(Color.fromRGBO(231, 208, 169, 1)); // ベージュ
    } else if (baseColor == Color.fromRGBO(0, 0, 0, 1)) {
      differentColors.add(Colors.white); // 白
      differentColors.add(Color.fromRGBO(249, 193, 207, 1)); // ピンク
      differentColors.add(Color.fromRGBO(244, 224, 196, 1)); // ベージュ
      differentColors.add(Color.fromRGBO(171, 225, 250, 1)); // ライトブルー
      differentColors.add(Color.fromRGBO(183, 168, 204, 1)); // ラベンダー
    } else if (baseColor == Color.fromRGBO(191, 191, 191, 1) ||
        baseColor == Color.fromRGBO(128, 128, 128, 1) ||
        baseColor == Color.fromRGBO(64, 64, 64, 1)) {
      differentColors.add(Color.fromRGBO(253, 238, 239, 1)); // 桜色
      differentColors.add(Color.fromRGBO(183, 168, 204, 1)); // ラベンダー
      differentColors.add(Color.fromRGBO(144, 206, 156, 1)); // ミントグリーン
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); //白
    } else if (baseColor == Color.fromRGBO(128, 95, 0, 1)) {
      differentColors.add(Color.fromRGBO(249, 193, 207, 1)); //ピンク(明るいピンク？)
      differentColors.add(Color.fromRGBO(183, 168, 204, 1)); // ラベンダー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); //白
      differentColors.add(Color.fromRGBO(144, 206, 156, 1)); // ミントグリーン
    } else if (baseColor == Color.fromRGBO(128, 196, 255, 1)) {
      differentColors.add(Color.fromRGBO(249, 193, 207, 1)); //ピンク(明るいピンク？)
      differentColors.add(Color.fromRGBO(183, 168, 204, 1)); // ラベンダー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); //白
      differentColors.add(Colors.yellow); // yellow
    } else if (baseColor == Color.fromRGBO(0, 137, 255, 1)) {
      differentColors.add(Color.fromRGBO(238, 145, 157, 1)); // ローズピンク
      differentColors.add(Color.fromRGBO(183, 168, 204, 1)); // ラベンダー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); //白
      differentColors.add(Color.fromRGBO(171, 225, 250, 1)); // ライトブルー
    } else if (baseColor == Color.fromRGBO(0, 68, 128, 1)) {
      differentColors.add(Color.fromRGBO(249, 193, 207, 1)); //ピンク(明るいピンク？)
      differentColors.add(Color.fromRGBO(183, 168, 204, 1)); // ラベンダー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); //白
      differentColors.add(Colors.yellow); // yellow
    } else if (baseColor == Color.fromRGBO(165, 218, 180, 1)) {
      differentColors.add(Color.fromRGBO(249, 193, 207, 1)); // ピンク
      differentColors.add(Color.fromRGBO(206, 180, 230, 1)); // ライトパープル
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // ホワイト
      differentColors.add(Color.fromRGBO(255, 255, 224, 1)); // ライトイエロー
    } else if (baseColor == Color.fromRGBO(75, 180, 104, 1)) {
      differentColors.add(Color.fromRGBO(255, 204, 204, 1)); // 桃色
      differentColors.add(Color.fromRGBO(209, 186, 218, 1)); // ライラック
      differentColors.add(Color.fromRGBO(255, 255, 224, 1)); // ライトイエロー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // ホワイト
    } else if (baseColor == Color.fromRGBO(37, 90, 52, 1)) {
      differentColors.add(Color.fromRGBO(255, 204, 204, 1)); // 桃色
      differentColors.add(Color.fromRGBO(183, 168, 204, 1)); // ラベンダー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(255, 215, 0, 1)); // ゴールド
    } else if (baseColor == Color.fromRGBO(255, 223, 128, 1)) {
      differentColors.add(Color.fromRGBO(249, 193, 207, 1)); // ピンク
      differentColors.add(Color.fromRGBO(183, 168, 204, 1)); // ラベンダー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(144, 206, 156, 1)); // ミントグリーン
    } else if (baseColor == Color.fromRGBO(255, 190, 0, 1)) {
      differentColors.add(Color.fromRGBO(249, 193, 207, 1)); // ピンク
      differentColors.add(Color.fromRGBO(173, 216, 230, 1)); // ライトブルー
      differentColors.add(Color.fromRGBO(183, 168, 204, 1)); // ラベンダー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
    } else if (baseColor == Color.fromRGBO(128, 95, 0, 1)) {
      differentColors.add(Color.fromRGBO(249, 193, 207, 1)); // ピンク
      differentColors.add(Color.fromRGBO(183, 168, 204, 1)); // ラベンダー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(144, 206, 156, 1)); // ミントグリーン
    }

    // リストをシャッフルする
    differentColors.shuffle();

    return differentColors;
  }

  @override
  Widget build(BuildContext context) {
    String colorName = colorNames[selectedColor] ?? 'Unknown';

    return Scaffold(
      backgroundColor: Colors.white, // 背景色を白に設定
      appBar: AppBar(
        title: Center(
            child: Text(
          'ガーリー',
          textAlign: TextAlign.center,
          style: GoogleFonts.zenMaruGothic(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ), // タイトルのテキストカラーを設定
        )),
        backgroundColor: Colors.white, // AppBar の背景色を白に設定
      ),
      body: Stack(
        children: [
          // 選択した色を反映する円
          Positioned(
            left: (MediaQuery.of(context).size.width - 136) / 2,
            top: 50,
            child: Container(
              width: 136,
              height: 136,
              decoration: ShapeDecoration(
                color: selectedColor,
                shape: CircleBorder(
                  side: BorderSide(
                    color: Colors.black, // 枠線の色を設定
                    width: 1.0, // 枠線の幅を設定
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              left: (MediaQuery.of(context).size.width - 146) / 2,
              top: 200,
              child: SizedBox(
                width: 150,
                height: 45,
                child: Text(
                  colorName,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.zenMaruGothic(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 0,
                    letterSpacing: 2.20,
                  ),
                ),
              )),
          // 「×」
          Positioned(
            left: (MediaQuery.of(context).size.width - 54) / 2,
            top: 215,
            child: SizedBox(
              width: 51,
              height: 78,
              child: Text(
                '×',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 64,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                  letterSpacing: 7.04,
                ),
              ),
            ),
          ),
          // スクロール可能な円
          Positioned.fill(
            top: 314,
            child: ListView(
              children: [
                // 選択した色ごとに異なる色を生成し、生成した色をランダムな順番で表示
                ...generateDifferentColors(selectedColor).map((color) {
                  return _buildCircle(colorNames[color] ?? 'Unknown', color);
                }).toList(),
                SizedBox(
                  height: 200, // 余白の高さ
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircle(String colorName, Color color) {
    return Column(
      children: [
        Container(
          width: 136,
          height: 141,
          decoration: ShapeDecoration(
            color: color,
            shape: CircleBorder(
              side: BorderSide(
                color: Colors.black, // 枠線の色を設定
                width: 1.0, // 枠線の幅を設定
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          width: 230,
          height: 45,
          child: Text(
            colorName,
            textAlign: TextAlign.center,
            style: GoogleFonts.zenMaruGothic(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              height: 0,
              letterSpacing: 2.20,
            ),
          ),
        ),
        SizedBox(
          height: 20, // 余白の高さ
        ),
      ],
    );
  }
}

//ナチュラル（女）の画面遷移
class SecondE extends StatelessWidget {
  final Color selectedColor;
  final Map<Color, String> colorNames;

  const SecondE({
    Key? key,
    required this.selectedColor,
    required this.colorNames,
  }) : super(key: key);

  List<Color> generateDifferentColors(Color baseColor) {
    List<Color> differentColors = [];

    // 選択した色ごとに異なる色を生成
    if (baseColor == Color.fromRGBO(255, 255, 255, 1)) {
      differentColors.add(Color.fromRGBO(244, 224, 196, 1)); // ベージュ
      differentColors.add(Color.fromRGBO(204, 127, 59, 1)); // キャラメル
      differentColors.add(Colors.grey); //'グレー', // グレー
      differentColors.add(Color.fromRGBO(171, 225, 250, 1)); // ライトブルー
      differentColors.add(Color.fromRGBO(87, 97, 40, 1)); // オリーブグリーン
    } else if (baseColor == Color.fromRGBO(238, 145, 157, 1)) {
      differentColors.add(Color.fromRGBO(231, 208, 169, 1)); // ベージュ
      differentColors.add(Color.fromRGBO(255, 237, 179, 1)); // クリーム色
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
      differentColors.add(Color.fromRGBO(171, 225, 250, 1)); // ライトブルー
    } else if (baseColor == Color.fromRGBO(191, 30, 51, 1) ||
        baseColor == Color.fromRGBO(220, 35, 59, 1)) {
      differentColors.add(Color.fromRGBO(244, 224, 196, 1)); // ベージュ
      differentColors.add(Color.fromRGBO(255, 255, 240, 1)); // オフホワイト
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
      differentColors.add(Color.fromRGBO(107, 142, 35, 1)); // カーキグリーン
    } else if (baseColor == Color.fromRGBO(110, 17, 29, 1)) {
      differentColors.add(Color.fromRGBO(231, 208, 169, 1)); // ベージュ
      differentColors.add(Color.fromRGBO(196, 153, 97, 1)); // キャメル
      differentColors.add(Color.fromRGBO(87, 97, 40, 1)); // オリーブグリーン
      differentColors.add(Color.fromRGBO(181, 101, 29, 1)); // ライトブラウン
    } else if (baseColor == Color.fromRGBO(0, 0, 0, 1)) {
      differentColors.add(Color.fromRGBO(7, 71, 112, 1)); // デニム色（濃い）
      differentColors.add(Color.fromRGBO(116, 144, 93, 1)); // カーキー
      differentColors.add(Colors.white); // 白
      differentColors.add(Color.fromRGBO(255, 237, 179, 1)); // クリーム色
      differentColors.add(Color.fromRGBO(231, 208, 169, 1)); // ベージュ
      differentColors.add(Colors.grey); // グレー
    } else if (baseColor == Color.fromRGBO(191, 191, 191, 1) ||
        baseColor == Color.fromRGBO(128, 128, 128, 1) ||
        baseColor == Color.fromRGBO(64, 64, 64, 1)) {
      differentColors.add(Color.fromRGBO(244, 224, 196, 1)); // ベージュ
      differentColors.add(Color.fromRGBO(255, 237, 179, 1)); // クリーム色
      differentColors.add(Color.fromRGBO(196, 153, 97, 1)); // キャメル
      differentColors.add(Color.fromRGBO(87, 97, 40, 1)); // オリーブグリーン
    } else if (baseColor == Color.fromRGBO(128, 95, 0, 1)) {
      differentColors.add(Color.fromRGBO(231, 208, 169, 1)); // ベージュ
      differentColors.add(Color.fromRGBO(87, 97, 40, 1)); // オリーブグリーン
      differentColors.add(Color.fromRGBO(116, 144, 93, 1)); // カーキー
      differentColors.add(Color.fromRGBO(139, 69, 19, 1)); //ピンク(明るいピンク？)
    } else if (baseColor == Color.fromRGBO(0, 137, 255, 1)) {
      differentColors.add(Color.fromRGBO(231, 208, 169, 1)); // ベージュ
      differentColors.add(Color.fromRGBO(87, 97, 40, 1)); // オリーブグリーン
      differentColors.add(Color.fromRGBO(116, 144, 93, 1)); // カーキー
      differentColors.add(Color.fromRGBO(139, 69, 19, 1)); //ピンク(明るいピンク？)
    } else if (baseColor == Color.fromRGBO(128, 196, 255, 1)) {
      differentColors.add(Color.fromRGBO(87, 97, 40, 1)); // オリーブグリーン
      differentColors.add(Color.fromRGBO(255, 255, 240, 1)); // オフホワイト
      differentColors.add(Color.fromRGBO(231, 208, 169, 1)); // ベージュ
      differentColors.add(Color.fromRGBO(116, 144, 93, 1)); // カーキー
    } else if (baseColor == Color.fromRGBO(0, 68, 128, 1)) {
      differentColors.add(Color.fromRGBO(87, 97, 40, 1)); // オリーブグリーン
      differentColors.add(Color.fromRGBO(181, 101, 29, 1)); // ライトブラウン
      differentColors.add(Color.fromRGBO(255, 237, 179, 1)); // クリーム色
      differentColors.add(Color.fromRGBO(116, 144, 93, 1)); // カーキー
    } else if (baseColor == Color.fromRGBO(165, 218, 180, 1)) {
      differentColors.add(Color.fromRGBO(255, 237, 179, 1)); // クリーム色
      differentColors.add(Color.fromRGBO(244, 224, 196, 1)); // ベージュ
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
      differentColors.add(Color.fromRGBO(181, 101, 29, 1)); // ライトブラウン
    } else if (baseColor == Color.fromRGBO(75, 180, 104, 1)) {
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
      differentColors.add(Color.fromRGBO(143, 100, 70, 1)); // ブラウン
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
    } else if (baseColor == Color.fromRGBO(37, 90, 52, 1)) {
      differentColors.add(Color.fromRGBO(244, 224, 196, 1)); // ベージュ
      differentColors.add(Color.fromRGBO(255, 255, 240, 1)); // オフホワイト
      differentColors.add(Color.fromRGBO(181, 101, 29, 1)); // ライトブラウン
      differentColors.add(Color.fromRGBO(171, 154, 134, 1)); // グレージュ
    } else if (baseColor == Color.fromRGBO(255, 223, 128, 1)) {
      differentColors.add(Color.fromRGBO(244, 224, 196, 1)); // ベージュ
      differentColors.add(Color.fromRGBO(255, 255, 240, 1)); // オフホワイト
      differentColors.add(Color.fromRGBO(181, 101, 29, 1)); // ライトブラウン
      differentColors.add(Color.fromRGBO(144, 238, 144, 1)); // ライトグリーン
    } else if (baseColor == Color.fromRGBO(255, 190, 0, 1)) {
      differentColors.add(Color.fromRGBO(244, 224, 196, 1)); // ベージュ
      differentColors.add(Color.fromRGBO(143, 100, 70, 1)); // ブラウン
      differentColors.add(Color.fromRGBO(107, 142, 35, 1)); // オリーブグリーン
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
    } else if (baseColor == Color.fromRGBO(128, 95, 0, 1)) {
      differentColors.add(Color.fromRGBO(244, 224, 196, 1)); // ベージュ
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Color.fromRGBO(107, 142, 35, 1)); // オリーブグリーン
      differentColors.add(Color.fromRGBO(173, 216, 230, 1)); // ライトブルー
    }

    // リストをシャッフルする
    differentColors.shuffle();

    return differentColors;
  }

  @override
  Widget build(BuildContext context) {
    String colorName = colorNames[selectedColor] ?? 'Unknown';

    return Scaffold(
      backgroundColor: Colors.white, // 背景色を白に設定
      appBar: AppBar(
        title: Center(
            child: Text(
          'ナチュラル',
          style: GoogleFonts.zenMaruGothic(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ), // タイトルのテキストカラーを設定
        )),
        backgroundColor: Colors.white, // AppBar の背景色を白に設定
      ),
      body: Stack(
        children: [
          // 選択した色を反映する円
          Positioned(
            left: (MediaQuery.of(context).size.width - 136) / 2,
            top: 50,
            child: Container(
              width: 136,
              height: 136,
              decoration: ShapeDecoration(
                color: selectedColor,
                shape: CircleBorder(
                  side: BorderSide(
                    color: Colors.black, // 枠線の色を設定
                    width: 1.0, // 枠線の幅を設定
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              left: (MediaQuery.of(context).size.width - 146) / 2,
              top: 200,
              child: SizedBox(
                width: 150,
                height: 45,
                child: Text(
                  colorName,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.zenMaruGothic(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 0,
                    letterSpacing: 2.20,
                  ),
                ),
              )),
          // 「×」
          Positioned(
            left: (MediaQuery.of(context).size.width - 54) / 2,
            top: 215,
            child: SizedBox(
              width: 51,
              height: 78,
              child: Text(
                '×',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 45,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                  letterSpacing: 7.04,
                ),
              ),
            ),
          ),
          // スクロール可能な円
          Positioned.fill(
            top: 314,
            child: ListView(
              children: [
                // 選択した色ごとに異なる色を生成し、生成した色をランダムな順番で表示
                ...generateDifferentColors(selectedColor).map((color) {
                  return _buildCircle(colorNames[color] ?? 'Unknown', color);
                }).toList(),
                SizedBox(
                  height: 200, // 余白の高さ
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircle(String colorName, Color color) {
    return Column(
      children: [
        Container(
          width: 136,
          height: 141,
          decoration: ShapeDecoration(
            color: color,
            shape: CircleBorder(
              side: BorderSide(
                color: Colors.black, // 枠線の色を設定
                width: 1.0, // 枠線の幅を設定
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          width: 230,
          height: 45,
          child: Text(
            colorName,
            textAlign: TextAlign.center,
            style: GoogleFonts.zenMaruGothic(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              height: 0,
              letterSpacing: 2.20,
            ),
          ),
        ),
        SizedBox(
          height: 20, // 余白の高さ
        ),
      ],
    );
  }
}

//カジュアル（男）の画面遷移
class Second2A extends StatelessWidget {
  final Color selectedColor;
  final Map<Color, String> colorNames;

  const Second2A({
    Key? key,
    required this.selectedColor,
    required this.colorNames,
  }) : super(key: key);

  List<Color> generateDifferentColors(Color baseColor) {
    List<Color> differentColors = [];

    // 選択した色ごとに異なる色を生成
    if (baseColor == Color.fromRGBO(255, 255, 255, 1)) {
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
      differentColors.add(Color.fromRGBO(107, 142, 35, 1)); // オリーブグリーン
      differentColors.add(Color.fromRGBO(173, 216, 230, 1)); // ライトブルー
    } else if (baseColor == Color.fromRGBO(238, 145, 157, 1)) {
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(0, 0, 128, 1)); // ネイビー
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Color.fromRGBO(173, 216, 230, 1)); // ライトブルー
      differentColors.add(Color.fromRGBO(240, 230, 140, 1)); // カーキ
    } else if (baseColor == Color.fromRGBO(191, 30, 51, 1)) {
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Color.fromRGBO(0, 0, 255, 1)); // ブルー
      differentColors.add(Color.fromRGBO(0, 0, 128, 1)); // ネイビー
    } else if (baseColor == Color.fromRGBO(220, 35, 59, 1)) {
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
      differentColors.add(Color.fromRGBO(169, 169, 169, 1)); // グレーシェード
      differentColors.add(Color.fromRGBO(0, 0, 128, 1)); // ネイビー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(244, 224, 196, 1)); // ベージュ
    } else if (baseColor == Color.fromRGBO(110, 17, 29, 1)) {
    } else if (baseColor == Color.fromRGBO(0, 0, 0, 1)) {
      differentColors.add(Color.fromRGBO(7, 71, 112, 1)); // デニム色（濃い）
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Colors.black); // 黒
      differentColors.add(Colors.white); // 白
      differentColors.add(Color.fromRGBO(231, 208, 169, 1)); // ベージュ
      differentColors.add(Color.fromRGBO(116, 144, 93, 1)); // カーキー
    } else if (baseColor == Color.fromRGBO(191, 191, 191, 1) ||
        baseColor == Color.fromRGBO(128, 128, 128, 1) ||
        baseColor == Color.fromRGBO(64, 64, 64, 1)) {
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); //白
      differentColors.add(Color.fromRGBO(87, 97, 40, 1)); // オリーブグリーン
    } else if (baseColor == Color.fromRGBO(128, 95, 0, 1)) {
      differentColors.add(Color.fromRGBO(255, 237, 179, 1)); // クリーム色
      differentColors.add(Color.fromRGBO(0, 0, 128, 1)); // ナビーブルー
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Color.fromRGBO(87, 97, 40, 1)); // オリーブグリーン
    } else if (baseColor == Color.fromRGBO(128, 196, 255, 1)) {
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
      differentColors.add(Colors.green); // 緑
      differentColors.add(Color.fromRGBO(255, 255, 224, 1)); // ライトイエロー
    } else if (baseColor == Color.fromRGBO(0, 137, 255, 1)) {
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
      differentColors.add(Colors.green); // 緑
      differentColors.add(Color.fromRGBO(255, 255, 224, 1)); // ライトイエロー
    } else if (baseColor == Color.fromRGBO(0, 68, 128, 1)) {
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(171, 225, 250, 1)); // ライトブルー
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
      differentColors.add(Color.fromRGBO(231, 208, 169, 1)); //be-jyu
    } else if (baseColor == Color.fromRGBO(165, 218, 180, 1)) {
      differentColors.add(Color.fromRGBO(37, 67, 182, 1)); // デニムブルー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(231, 208, 169, 1)); //be-jyu
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
    } else if (baseColor == Color.fromRGBO(75, 180, 104, 1)) {
      differentColors.add(Color.fromRGBO(143, 100, 70, 1)); // ブラウン
      differentColors.add(Color.fromRGBO(244, 224, 196, 1)); // ベージュ
      differentColors.add(Colors.grey); // グレー
    } else if (baseColor == Color.fromRGBO(37, 90, 52, 1)) {
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
      differentColors.add(Color.fromRGBO(143, 100, 70, 1)); // ブラウン
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
    } else if (baseColor == Color.fromRGBO(255, 223, 128, 1)) {
      differentColors.add(Color.fromRGBO(135, 206, 235, 1)); // スカイブルー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
      differentColors.add(Color.fromRGBO(244, 224, 196, 1)); // ベージュ
    } else if (baseColor == Color.fromRGBO(255, 190, 0, 1)) {
      differentColors.add(Color.fromRGBO(37, 67, 182, 1)); // デニムブルー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
      differentColors.add(Colors.grey); // グレー
    } else if (baseColor == Color.fromRGBO(128, 95, 0, 1)) {
      differentColors.add(Color.fromRGBO(101, 67, 33, 1)); // ダークブラウン
      differentColors.add(Color.fromRGBO(107, 142, 35, 1)); // オリーブグリーン
      differentColors.add(Colors.grey); // グレー
    }

    // リストをシャッフルする
    differentColors.shuffle();

    return differentColors;
  }

  @override
  Widget build(BuildContext context) {
    String colorName = colorNames[selectedColor] ?? 'Unknown';

    return Scaffold(
      backgroundColor: Colors.white, // 背景色を白に設定
      appBar: AppBar(
        title: Center(
          child: Text(
            'カジュアル',
            textAlign: TextAlign.center,
            style: GoogleFonts.zenMaruGothic(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ), // タイトルのテキストカラーを設定
          ),
        ),
        backgroundColor: Colors.white, // AppBar の背景色を白に設定
      ),
      body: Stack(
        children: [
          // 選択した色を反映する円
          Positioned(
            left: (MediaQuery.of(context).size.width - 136) / 2,
            top: 50,
            child: Container(
              width: 136,
              height: 136,
              decoration: ShapeDecoration(
                color: selectedColor,
                shape: CircleBorder(
                  side: BorderSide(
                    color: Colors.black, // 枠線の色を設定
                    width: 1.0, // 枠線の幅を設定
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              left: (MediaQuery.of(context).size.width - 146) / 2,
              top: 200,
              child: SizedBox(
                width: 150,
                height: 45,
                child: Text(
                  colorName,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.zenMaruGothic(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 0,
                    letterSpacing: 2.20,
                  ),
                ),
              )),
          // ×
          Positioned(
            left: (MediaQuery.of(context).size.width - 54) / 2,
            top: 215,
            child: SizedBox(
              width: 51,
              height: 78,
              child: Text(
                '×',
                textAlign: TextAlign.center,
                style: GoogleFonts.zenMaruGothic(
                  color: Colors.black,
                  fontSize: 64,
                  fontWeight: FontWeight.w500,
                  height: 0,
                  letterSpacing: 7.04,
                ),
              ),
            ),
          ),
          // スクロール可能な円
          Positioned.fill(
            top: 314,
            child: ListView(
              children: [
                // 選択した色ごとに異なる色を生成し、生成した色をランダムな順番で表示
                ...generateDifferentColors(selectedColor).map((color) {
                  return _buildCircle(colorNames[color] ?? 'Unknown', color);
                }).toList(),
                SizedBox(
                  height: 200, // 余白の高さ
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircle(String colorName, Color color) {
    return Column(
      children: [
        Container(
          width: 136,
          height: 141,
          decoration: ShapeDecoration(
            color: color,
            shape: CircleBorder(
              side: BorderSide(
                color: Colors.black, // 枠線の色を設定
                width: 1.0, // 枠線の幅を設定
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          width: 230,
          height: 45,
          child: Text(
            colorName,
            textAlign: TextAlign.center,
            style: GoogleFonts.zenMaruGothic(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              height: 0,
              letterSpacing: 2.20,
            ),
          ),
        ),
        SizedBox(
          height: 20, // 余白の高さ
        ),
      ],
    );
  }
}

//ゆるカジの画面遷移
class Second2B extends StatelessWidget {
  final Color selectedColor;
  final Map<Color, String> colorNames;

  const Second2B({
    Key? key,
    required this.selectedColor,
    required this.colorNames,
  }) : super(key: key);

  List<Color> generateDifferentColors(Color baseColor) {
    List<Color> differentColors = [];

    // 選択した色ごとに異なる色を生成
    if (baseColor == Color.fromRGBO(255, 255, 255, 1)) {
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(0, 0, 128, 1)); // ネイビー
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
      differentColors.add(Color.fromRGBO(107, 142, 35, 1)); // オリーブグリーン
      differentColors.add(Color.fromRGBO(173, 216, 230, 1)); // ライトブルー
    } else if (baseColor == Color.fromRGBO(238, 145, 157, 1)) {
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(173, 216, 230, 1)); // ライトブルー
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
      differentColors.add(Color.fromRGBO(244, 224, 196, 1)); // ベージュ
      differentColors.add(Color.fromRGBO(240, 230, 140, 1)); // カーキ
    } else if (baseColor == Color.fromRGBO(191, 30, 51, 1)) {
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(0, 0, 128, 1)); // ネイビー
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
      differentColors.add(Color.fromRGBO(240, 230, 140, 1)); // カーキ
    } else if (baseColor == Color.fromRGBO(220, 35, 59, 1)) {
      differentColors.add(Color.fromRGBO(0, 0, 128, 1)); // ネイビー
      differentColors.add(Color.fromRGBO(34, 34, 34, 1)); // チャコールグレー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(107, 142, 35, 1)); // オリーブグリーン
      differentColors.add(Color.fromRGBO(240, 230, 140, 1)); // カーキ
    } else if (baseColor == Color.fromRGBO(110, 17, 29, 1)) {
    } else if (baseColor == Color.fromRGBO(0, 0, 0, 1)) {
      differentColors.add(Color.fromRGBO(7, 71, 112, 1)); // デニム色（濃い）
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Colors.black); // 黒
      differentColors.add(Colors.white); // 白
      differentColors.add(Color.fromRGBO(231, 208, 169, 1)); // ベージュ
      differentColors.add(Color.fromRGBO(116, 144, 93, 1)); // カーキー
    } else if (baseColor == Color.fromRGBO(191, 191, 191, 1) ||
        baseColor == Color.fromRGBO(128, 128, 128, 1) ||
        baseColor == Color.fromRGBO(64, 64, 64, 1)) {
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); //白
      differentColors.add(Color.fromRGBO(87, 97, 40, 1)); // オリーブグリーン
    } else if (baseColor == Color.fromRGBO(128, 95, 0, 1)) {
      differentColors.add(Color.fromRGBO(255, 237, 179, 1)); // クリーム色
      differentColors.add(Color.fromRGBO(0, 0, 128, 1)); // ナビーブルー
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Color.fromRGBO(87, 97, 40, 1)); // オリーブグリーン
    } else if (baseColor == Color.fromRGBO(128, 196, 255, 1)) {
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
      differentColors.add(Colors.green); // 緑
      differentColors.add(Color.fromRGBO(255, 255, 224, 1)); // ライトイエロー
    } else if (baseColor == Color.fromRGBO(0, 137, 255, 1)) {
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
      differentColors.add(Colors.green); // 緑
      differentColors.add(Color.fromRGBO(255, 255, 224, 1)); // ライトイエロー
    } else if (baseColor == Color.fromRGBO(0, 68, 128, 1)) {
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(171, 225, 250, 1)); // ライトブルー
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
      differentColors.add(Color.fromRGBO(231, 208, 169, 1)); //be-jyu
    } else if (baseColor == Color.fromRGBO(165, 218, 180, 1)) {
      differentColors.add(Color.fromRGBO(37, 67, 182, 1)); // デニムブルー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(231, 208, 169, 1)); //be-jyu
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
    } else if (baseColor == Color.fromRGBO(75, 180, 104, 1)) {
      differentColors.add(Color.fromRGBO(143, 100, 70, 1)); // ブラウン
      differentColors.add(Color.fromRGBO(244, 224, 196, 1)); // ベージュ
      differentColors.add(Colors.grey); // グレー
    } else if (baseColor == Color.fromRGBO(37, 90, 52, 1)) {
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
      differentColors.add(Color.fromRGBO(143, 100, 70, 1)); // ブラウン
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
    } else if (baseColor == Color.fromRGBO(255, 223, 128, 1)) {
      differentColors.add(Color.fromRGBO(135, 206, 235, 1)); // スカイブルー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
      differentColors.add(Color.fromRGBO(244, 224, 196, 1)); // ベージュ
    } else if (baseColor == Color.fromRGBO(255, 190, 0, 1)) {
      differentColors.add(Color.fromRGBO(37, 67, 182, 1)); // デニムブルー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
      differentColors.add(Colors.grey); // グレー
    } else if (baseColor == Color.fromRGBO(128, 95, 0, 1)) {
      differentColors.add(Color.fromRGBO(101, 67, 33, 1)); // ダークブラウン
      differentColors.add(Color.fromRGBO(107, 142, 35, 1)); // オリーブグリーン
      differentColors.add(Colors.grey); // グレー
    }

    // リストをシャッフルする
    differentColors.shuffle();

    return differentColors;
  }

  @override
  Widget build(BuildContext context) {
    String colorName = colorNames[selectedColor] ?? 'Unknown';

    return Scaffold(
      backgroundColor: Colors.white, // 背景色を白に設定
      appBar: AppBar(
        title: Center(
            child: Text(
          'ゆるカジ',
          textAlign: TextAlign.center,
          style: GoogleFonts.zenMaruGothic(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ), // タイトルのテキストカラーを設定
        )),
        backgroundColor: Colors.white, // AppBar の背景色を白に設定
      ),
      body: Stack(
        children: [
          // 選択した色を反映する円
          Positioned(
            left: (MediaQuery.of(context).size.width - 136) / 2,
            top: 50,
            child: Container(
              width: 136,
              height: 136,
              decoration: ShapeDecoration(
                color: selectedColor,
                shape: CircleBorder(
                  side: BorderSide(
                    color: Colors.black, // 枠線の色を設定
                    width: 1.0, // 枠線の幅を設定
                  ),
                ),
              ),
            ),
          ),
//色の名前表示
          Positioned(
              left: (MediaQuery.of(context).size.width - 146) / 2,
              top: 200,
              child: SizedBox(
                width: 150,
                height: 45,
                child: Text(
                  colorName,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.zenMaruGothic(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 0,
                    letterSpacing: 2.20,
                  ),
                ),
              )),
          // 「×」
          Positioned(
            left: (MediaQuery.of(context).size.width - 54) / 2,
            top: 215,
            child: SizedBox(
              width: 51,
              height: 78,
              child: Text(
                '×',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 64,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                  letterSpacing: 7.04,
                ),
              ),
            ),
          ),
          // スクロール可能な円
          Positioned.fill(
            top: 314,
            child: ListView(
              children: [
                // 選択した色ごとに異なる色を生成し、生成した色をランダムな順番で表示
                ...generateDifferentColors(selectedColor).map((color) {
                  return _buildCircle(colorNames[color] ?? 'Unknown', color);
                }).toList(),
                SizedBox(
                  height: 200, // 余白の高さ
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircle(String colorName, Color color) {
    return Column(
      children: [
        Container(
          width: 136,
          height: 141,
          decoration: ShapeDecoration(
            color: color,
            shape: CircleBorder(
              side: BorderSide(
                color: Colors.black, // 枠線の色を設定
                width: 1.0, // 枠線の幅を設定
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          width: 230,
          height: 45,
          child: Text(
            colorName,
            textAlign: TextAlign.center,
            style: GoogleFonts.zenMaruGothic(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              height: 0,
              letterSpacing: 2.20,
            ),
          ),
        ),
        SizedBox(
          height: 20, // 余白の高さ
        ),
      ],
    );
  }
}

//スポーツの画面遷移
class Second2C extends StatelessWidget {
  final Color selectedColor;
  final Map<Color, String> colorNames;

  const Second2C({
    Key? key,
    required this.selectedColor,
    required this.colorNames,
  }) : super(key: key);

  List<Color> generateDifferentColors(Color baseColor) {
    List<Color> differentColors = [];

    // 選択した色ごとに異なる色を生成
    if (baseColor == Color.fromRGBO(255, 255, 255, 1)) {
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(255, 0, 0, 1)); // 赤
      differentColors.add(Color.fromRGBO(65, 105, 225, 1)); // ロイヤルブルー
      differentColors.add(Color.fromRGBO(0, 128, 0, 1)); // グリーン
    } else if (baseColor == Color.fromRGBO(238, 145, 157, 1)) {
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
      differentColors.add(Color.fromRGBO(0, 0, 128, 1)); // ネイビー
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Color.fromRGBO(0, 128, 0, 1)); // グリーン
    } else if (baseColor == Color.fromRGBO(191, 30, 51, 1)) {
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
      differentColors.add(Color.fromRGBO(0, 0, 128, 1)); // ネイビー
      differentColors.add(Color.fromRGBO(0, 128, 0, 1)); // グリーン
    } else if (baseColor == Color.fromRGBO(220, 35, 59, 1)) {
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
      differentColors.add(Color.fromRGBO(0, 0, 128, 1)); // ネイビー
    } else if (baseColor == Color.fromRGBO(110, 17, 29, 1)) {
    } else if (baseColor == Color.fromRGBO(0, 0, 0, 1)) {
      differentColors.add(Color.fromRGBO(7, 71, 112, 1)); // デニム色（濃い）
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Colors.black); // 黒
      differentColors.add(Colors.white); // 白
      differentColors.add(Color.fromRGBO(231, 208, 169, 1)); // ベージュ
      differentColors.add(Color.fromRGBO(116, 144, 93, 1)); // カーキー
    } else if (baseColor == Color.fromRGBO(191, 191, 191, 1) ||
        baseColor == Color.fromRGBO(128, 128, 128, 1) ||
        baseColor == Color.fromRGBO(64, 64, 64, 1)) {
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); //白
      differentColors.add(Color.fromRGBO(87, 97, 40, 1)); // オリーブグリーン
    } else if (baseColor == Color.fromRGBO(128, 95, 0, 1)) {
      differentColors.add(Color.fromRGBO(255, 237, 179, 1)); // クリーム色
      differentColors.add(Color.fromRGBO(0, 0, 128, 1)); // ナビーブルー
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Color.fromRGBO(87, 97, 40, 1)); // オリーブグリーン
    } else if (baseColor == Color.fromRGBO(128, 196, 255, 1)) {
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
      differentColors.add(Colors.green); // 緑
      differentColors.add(Color.fromRGBO(255, 255, 224, 1)); // ライトイエロー
    } else if (baseColor == Color.fromRGBO(0, 137, 255, 1)) {
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
      differentColors.add(Colors.green); // 緑
      differentColors.add(Color.fromRGBO(255, 255, 224, 1)); // ライトイエロー
    } else if (baseColor == Color.fromRGBO(0, 68, 128, 1)) {
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(171, 225, 250, 1)); // ライトブルー
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
      differentColors.add(Color.fromRGBO(231, 208, 169, 1)); //be-jyu
    } else if (baseColor == Color.fromRGBO(165, 218, 180, 1)) {
      differentColors.add(Color.fromRGBO(37, 67, 182, 1)); // デニムブルー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(231, 208, 169, 1)); //be-jyu
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
    } else if (baseColor == Color.fromRGBO(75, 180, 104, 1)) {
      differentColors.add(Color.fromRGBO(143, 100, 70, 1)); // ブラウン
      differentColors.add(Color.fromRGBO(244, 224, 196, 1)); // ベージュ
      differentColors.add(Colors.grey); // グレー
    } else if (baseColor == Color.fromRGBO(37, 90, 52, 1)) {
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
      differentColors.add(Color.fromRGBO(143, 100, 70, 1)); // ブラウン
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
    } else if (baseColor == Color.fromRGBO(255, 223, 128, 1)) {
      differentColors.add(Color.fromRGBO(135, 206, 235, 1)); // スカイブルー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
      differentColors.add(Color.fromRGBO(244, 224, 196, 1)); // ベージュ
    } else if (baseColor == Color.fromRGBO(255, 190, 0, 1)) {
      differentColors.add(Color.fromRGBO(37, 67, 182, 1)); // デニムブルー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
      differentColors.add(Colors.grey); // グレー
    } else if (baseColor == Color.fromRGBO(128, 95, 0, 1)) {
      differentColors.add(Color.fromRGBO(101, 67, 33, 1)); // ダークブラウン
      differentColors.add(Color.fromRGBO(107, 142, 35, 1)); // オリーブグリーン
      differentColors.add(Colors.grey); // グレー
    }

    // リストをシャッフルする
    differentColors.shuffle();

    return differentColors;
  }

  @override
  Widget build(BuildContext context) {
    String colorName = colorNames[selectedColor] ?? 'Unknown';

    return Scaffold(
      backgroundColor: Colors.white, // 背景色を白に設定
      appBar: AppBar(
        title: Center(
            child: Text(
          'スポーツ',
          textAlign: TextAlign.center,
          style: GoogleFonts.zenMaruGothic(
              color: Colors.black,
              fontWeight: FontWeight.w500), // タイトルのテキストカラーを設定
        )),

        backgroundColor: Colors.white, // AppBar の背景色を白に設定
      ),
      body: Stack(
        children: [
          // 選択した色を反映する円
          Positioned(
            left: (MediaQuery.of(context).size.width - 136) / 2,
            top: 50,
            child: Container(
              width: 136,
              height: 136,
              decoration: ShapeDecoration(
                color: selectedColor,
                shape: CircleBorder(
                  side: BorderSide(
                    color: Colors.black, // 枠線の色を設定
                    width: 1.0, // 枠線の幅を設定
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              left: (MediaQuery.of(context).size.width - 146) / 2,
              top: 200,
              child: SizedBox(
                width: 150,
                height: 45,
                child: Text(
                  colorName,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.zenMaruGothic(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 0,
                    letterSpacing: 2.20,
                  ),
                ),
              )),

          // 「×」
          Positioned(
            left: (MediaQuery.of(context).size.width - 51) / 2,
            top: 236,
            child: SizedBox(
              width: 51,
              height: 78,
              child: Text(
                '×',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 64,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                  letterSpacing: 7.04,
                ),
              ),
            ),
          ),
          // スクロール可能な円
          Positioned.fill(
            top: 314,
            child: ListView(
              children: [
                // 選択した色ごとに異なる色を生成し、生成した色をランダムな順番で表示
                ...generateDifferentColors(selectedColor).map((color) {
                  return _buildCircle(colorNames[color] ?? 'Unknown', color);
                }).toList(),
                SizedBox(
                  height: 200, // 余白の高さ
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircle(String colorName, Color color) {
    return Column(
      children: [
        Container(
          width: 136,
          height: 141,
          decoration: ShapeDecoration(
            color: color,
            shape: CircleBorder(
              side: BorderSide(
                color: Colors.black, // 枠線の色を設定
                width: 1.0, // 枠線の幅を設定
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          width: 230,
          height: 45,
          child: Text(
            colorName,
            textAlign: TextAlign.center,
            style: GoogleFonts.zenMaruGothic(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              height: 0,
              letterSpacing: 2.20,
            ),
          ),
        ),
        SizedBox(
          height: 20, // 余白の高さ
        ),
      ],
    );
  }
}

//モードの画面遷移
class Second2D extends StatelessWidget {
  final Color selectedColor;
  final Map<Color, String> colorNames;

  const Second2D({
    Key? key,
    required this.selectedColor,
    required this.colorNames,
  }) : super(key: key);

  List<Color> generateDifferentColors(Color baseColor) {
    List<Color> differentColors = [];

    // 選択した色ごとに異なる色を生成
    if (baseColor == Color.fromRGBO(255, 255, 255, 1)) {
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(192, 192, 192, 1)); // シルバー
      differentColors.add(Color.fromRGBO(0, 0, 128, 1)); // ネイビー
      differentColors.add(Color.fromRGBO(119, 0, 48, 1)); // バーガンディ
    } else if (baseColor == Color.fromRGBO(238, 145, 157, 1)) {
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
      differentColors.add(Color.fromRGBO(192, 192, 192, 1)); // シルバー
      differentColors.add(Color.fromRGBO(0, 0, 128, 1)); // ネイビー
    } else if (baseColor == Color.fromRGBO(191, 30, 51, 1)) {
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(192, 192, 192, 1)); // シルバー
    } else if (baseColor == Color.fromRGBO(220, 35, 59, 1)) {
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
      differentColors.add(Color.fromRGBO(192, 192, 192, 1)); // シルバー
      differentColors.add(Color.fromRGBO(0, 0, 128, 1)); // ネイビー
    } else if (baseColor == Color.fromRGBO(110, 17, 29, 1)) {
    } else if (baseColor == Color.fromRGBO(0, 0, 0, 1)) {
      differentColors.add(Color.fromRGBO(7, 71, 112, 1)); // デニム色（濃い）
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Colors.black); // 黒
      differentColors.add(Colors.white); // 白
      differentColors.add(Color.fromRGBO(231, 208, 169, 1)); // ベージュ
      differentColors.add(Color.fromRGBO(116, 144, 93, 1)); // カーキー
    } else if (baseColor == Color.fromRGBO(191, 191, 191, 1) ||
        baseColor == Color.fromRGBO(128, 128, 128, 1) ||
        baseColor == Color.fromRGBO(64, 64, 64, 1)) {
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); //白
      differentColors.add(Color.fromRGBO(87, 97, 40, 1)); // オリーブグリーン
    } else if (baseColor == Color.fromRGBO(128, 95, 0, 1)) {
      differentColors.add(Color.fromRGBO(255, 237, 179, 1)); // クリーム色
      differentColors.add(Color.fromRGBO(0, 0, 128, 1)); // ナビーブルー
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Color.fromRGBO(87, 97, 40, 1)); // オリーブグリーン
    } else if (baseColor == Color.fromRGBO(128, 196, 255, 1)) {
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
      differentColors.add(Colors.green); // 緑
      differentColors.add(Color.fromRGBO(255, 255, 224, 1)); // ライトイエロー
    } else if (baseColor == Color.fromRGBO(0, 137, 255, 1)) {
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
      differentColors.add(Colors.green); // 緑
      differentColors.add(Color.fromRGBO(255, 255, 224, 1)); // ライトイエロー
    } else if (baseColor == Color.fromRGBO(0, 68, 128, 1)) {
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(171, 225, 250, 1)); // ライトブルー
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
      differentColors.add(Color.fromRGBO(231, 208, 169, 1)); //be-jyu
    } else if (baseColor == Color.fromRGBO(165, 218, 180, 1)) {
      differentColors.add(Color.fromRGBO(37, 67, 182, 1)); // デニムブルー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(231, 208, 169, 1)); //be-jyu
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
    } else if (baseColor == Color.fromRGBO(75, 180, 104, 1)) {
      differentColors.add(Color.fromRGBO(143, 100, 70, 1)); // ブラウン
      differentColors.add(Color.fromRGBO(244, 224, 196, 1)); // ベージュ
      differentColors.add(Colors.grey); // グレー
    } else if (baseColor == Color.fromRGBO(37, 90, 52, 1)) {
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
      differentColors.add(Color.fromRGBO(143, 100, 70, 1)); // ブラウン
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
    } else if (baseColor == Color.fromRGBO(255, 223, 128, 1)) {
      differentColors.add(Color.fromRGBO(135, 206, 235, 1)); // スカイブルー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
      differentColors.add(Color.fromRGBO(244, 224, 196, 1)); // ベージュ
    } else if (baseColor == Color.fromRGBO(255, 190, 0, 1)) {
      differentColors.add(Color.fromRGBO(37, 67, 182, 1)); // デニムブルー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
      differentColors.add(Colors.grey); // グレー
    } else if (baseColor == Color.fromRGBO(128, 95, 0, 1)) {
      differentColors.add(Color.fromRGBO(101, 67, 33, 1)); // ダークブラウン
      differentColors.add(Color.fromRGBO(107, 142, 35, 1)); // オリーブグリーン
      differentColors.add(Colors.grey); // グレー
    }

    // リストをシャッフルする
    differentColors.shuffle();

    return differentColors;
  }

  @override
  Widget build(BuildContext context) {
    String colorName = colorNames[selectedColor] ?? 'Unknown';

    return Scaffold(
      backgroundColor: Colors.white, // 背景色を白に設定
      appBar: AppBar(
        title: Center(
            child: Text(
          'モード',
          textAlign: TextAlign.center,
          style: GoogleFonts.zenMaruGothic(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ), // タイトルのテキストカラーを設定
        )),
        backgroundColor: Colors.white, // AppBar の背景色を白に設定
      ),
      body: Stack(
        children: [
          // 選択した色を反映する円
          Positioned(
            left: (MediaQuery.of(context).size.width - 136) / 2,
            top: 50,
            child: Container(
              width: 136,
              height: 136,
              decoration: ShapeDecoration(
                color: selectedColor,
                shape: CircleBorder(
                  side: BorderSide(
                    color: Colors.black, // 枠線の色を設定
                    width: 1.0, // 枠線の幅を設定
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              left: (MediaQuery.of(context).size.width - 146) / 2,
              top: 200,
              child: SizedBox(
                width: 150,
                height: 45,
                child: Text(
                  colorName,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.zenMaruGothic(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 0,
                    letterSpacing: 2.20,
                  ),
                ),
              )),
          // 「×」
          Positioned(
            left: (MediaQuery.of(context).size.width - 54) / 2,
            top: 215,
            child: SizedBox(
              width: 51,
              height: 78,
              child: Text(
                '×',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 64,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                  letterSpacing: 7.04,
                ),
              ),
            ),
          ),
          // スクロール可能な円
          Positioned.fill(
            top: 314,
            child: ListView(
              children: [
                // 選択した色ごとに異なる色を生成し、生成した色をランダムな順番で表示
                ...generateDifferentColors(selectedColor).map((color) {
                  return _buildCircle(colorNames[color] ?? 'Unknown', color);
                }).toList(),
                SizedBox(
                  height: 200, // 余白の高さ
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircle(String colorName, Color color) {
    return Column(
      children: [
        Container(
          width: 136,
          height: 141,
          decoration: ShapeDecoration(
            color: color,
            shape: CircleBorder(
              side: BorderSide(
                color: Colors.black, // 枠線の色を設定
                width: 1.0, // 枠線の幅を設定
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          width: 230,
          height: 45,
          child: Text(
            colorName,
            textAlign: TextAlign.center,
            style: GoogleFonts.zenMaruGothic(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              height: 0,
              letterSpacing: 2.20,
            ),
          ),
        ),
        SizedBox(
          height: 20, // 余白の高さ
        ),
      ],
    );
  }
}

//ナチュラル（男）の画面遷移
class Second2E extends StatelessWidget {
  final Color selectedColor;
  final Map<Color, String> colorNames;

  const Second2E({
    Key? key,
    required this.selectedColor,
    required this.colorNames,
  }) : super(key: key);

  List<Color> generateDifferentColors(Color baseColor) {
    List<Color> differentColors = [];

    // 選択した色ごとに異なる色を生成
    if (baseColor == Color.fromRGBO(255, 255, 255, 1)) {
      differentColors.add(Color.fromRGBO(244, 224, 196, 1)); // ベージュ
      differentColors.add(Color.fromRGBO(107, 142, 35, 1)); // オリーブグリーン
      differentColors.add(Color.fromRGBO(210, 180, 140, 1)); // タン
      differentColors.add(Color.fromRGBO(255, 237, 179, 1)); // クリーム色
      differentColors.add(Color.fromRGBO(0, 0, 128, 1)); // ネイビー
    } else if (baseColor == Color.fromRGBO(238, 145, 157, 1)) {
      differentColors.add(Color.fromRGBO(244, 224, 196, 1)); // ベージュ
      differentColors.add(Color.fromRGBO(181, 101, 29, 1)); // ライトブラウン
      differentColors.add(Color.fromRGBO(240, 230, 140, 1)); // カーキ
      differentColors.add(Color.fromRGBO(171, 154, 134, 1)); // グレージュ
      differentColors.add(Color.fromRGBO(144, 238, 144, 1)); // ライトグリーン
    } else if (baseColor == Color.fromRGBO(191, 30, 51, 1)) {
      differentColors.add(Color.fromRGBO(244, 224, 196, 1)); // ベージュ
      differentColors.add(Color.fromRGBO(240, 230, 140, 1)); // カーキ
      differentColors.add(Color.fromRGBO(171, 154, 134, 1)); // グレージュ
      differentColors.add(Color.fromRGBO(107, 142, 35, 1)); // オリーブグリーン
      differentColors.add(Color.fromRGBO(181, 101, 29, 1)); // ライトブラウン
    } else if (baseColor == Color.fromRGBO(220, 35, 59, 1)) {
      differentColors.add(Color.fromRGBO(240, 230, 140, 1)); // カーキ
      differentColors.add(Color.fromRGBO(165, 42, 42, 1)); // ブラウン
      differentColors.add(Color.fromRGBO(107, 142, 35, 1)); // オリーブグリーン
      differentColors.add(Color.fromRGBO(244, 224, 196, 1)); // ベージュ
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
    } else if (baseColor == Color.fromRGBO(110, 17, 29, 1)) {
    } else if (baseColor == Color.fromRGBO(0, 0, 0, 1)) {
      differentColors.add(Color.fromRGBO(7, 71, 112, 1)); // デニム色（濃い）
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Colors.black); // 黒
      differentColors.add(Colors.white); // 白
      differentColors.add(Color.fromRGBO(231, 208, 169, 1)); // ベージュ
      differentColors.add(Color.fromRGBO(116, 144, 93, 1)); // カーキー
    } else if (baseColor == Color.fromRGBO(191, 191, 191, 1) ||
        baseColor == Color.fromRGBO(128, 128, 128, 1) ||
        baseColor == Color.fromRGBO(64, 64, 64, 1)) {
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); //白
      differentColors.add(Color.fromRGBO(87, 97, 40, 1)); // オリーブグリーン
    } else if (baseColor == Color.fromRGBO(128, 95, 0, 1)) {
      differentColors.add(Color.fromRGBO(255, 237, 179, 1)); // クリーム色
      differentColors.add(Color.fromRGBO(0, 0, 128, 1)); // ナビーブルー
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Color.fromRGBO(87, 97, 40, 1)); // オリーブグリーン
    } else if (baseColor == Color.fromRGBO(128, 196, 255, 1)) {
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
      differentColors.add(Colors.green); // 緑
      differentColors.add(Color.fromRGBO(255, 255, 224, 1)); // ライトイエロー
    } else if (baseColor == Color.fromRGBO(0, 137, 255, 1)) {
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
      differentColors.add(Colors.green); // 緑
      differentColors.add(Color.fromRGBO(255, 255, 224, 1)); // ライトイエロー
    } else if (baseColor == Color.fromRGBO(0, 68, 128, 1)) {
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(171, 225, 250, 1)); // ライトブルー
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
      differentColors.add(Color.fromRGBO(231, 208, 169, 1)); //be-jyu
    } else if (baseColor == Color.fromRGBO(165, 218, 180, 1)) {
      differentColors.add(Color.fromRGBO(37, 67, 182, 1)); // デニムブルー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(231, 208, 169, 1)); //be-jyu
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
    } else if (baseColor == Color.fromRGBO(75, 180, 104, 1)) {
      differentColors.add(Color.fromRGBO(143, 100, 70, 1)); // ブラウン
      differentColors.add(Color.fromRGBO(244, 224, 196, 1)); // ベージュ
      differentColors.add(Colors.grey); // グレー
    } else if (baseColor == Color.fromRGBO(37, 90, 52, 1)) {
      differentColors.add(Colors.grey); // グレー
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
      differentColors.add(Color.fromRGBO(143, 100, 70, 1)); // ブラウン
      differentColors.add(Color.fromRGBO(0, 0, 0, 1)); // 黒
    } else if (baseColor == Color.fromRGBO(255, 223, 128, 1)) {
      differentColors.add(Color.fromRGBO(135, 206, 235, 1)); // スカイブルー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(211, 211, 211, 1)); // ライトグレー
      differentColors.add(Color.fromRGBO(244, 224, 196, 1)); // ベージュ
    } else if (baseColor == Color.fromRGBO(255, 190, 0, 1)) {
      differentColors.add(Color.fromRGBO(37, 67, 182, 1)); // デニムブルー
      differentColors.add(Color.fromRGBO(255, 255, 255, 1)); // 白
      differentColors.add(Color.fromRGBO(31, 47, 84, 1)); // ネイビー
      differentColors.add(Colors.grey); // グレー
    } else if (baseColor == Color.fromRGBO(128, 95, 0, 1)) {
      differentColors.add(Color.fromRGBO(101, 67, 33, 1)); // ダークブラウン
      differentColors.add(Color.fromRGBO(107, 142, 35, 1)); // オリーブグリーン
      differentColors.add(Colors.grey); // グレー
    }

    // リストをシャッフルする
    differentColors.shuffle();

    return differentColors;
  }

  @override
  Widget build(BuildContext context) {
    String colorName = colorNames[selectedColor] ?? 'Unknown';

    return Scaffold(
      backgroundColor: Colors.white, // 背景色を白に設定
      appBar: AppBar(
        title: Center(
            child: Text(
          'ナチュラル',
          style: GoogleFonts.zenMaruGothic(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ), // タイトルのテキストカラーを設定
        )),
        backgroundColor: Colors.white, // AppBar の背景色を白に設定
      ),
      body: Stack(
        children: [
          // 選択した色を反映する円
          Positioned(
            left: (MediaQuery.of(context).size.width - 136) / 2,
            top: 50,
            child: Container(
              width: 136,
              height: 136,
              decoration: ShapeDecoration(
                color: selectedColor,
                shape: CircleBorder(
                  side: BorderSide(
                    color: Colors.black, // 枠線の色を設定
                    width: 1.0, // 枠線の幅を設定
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              left: (MediaQuery.of(context).size.width - 146) / 2,
              top: 200,
              child: SizedBox(
                width: 150,
                height: 45,
                child: Text(
                  colorName,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.zenMaruGothic(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 0,
                    letterSpacing: 2.20,
                  ),
                ),
              )),
          // 「×」
          Positioned(
            left: (MediaQuery.of(context).size.width - 54) / 2,
            top: 215,
            child: SizedBox(
              width: 51,
              height: 78,
              child: Text(
                '×',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 45,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                  letterSpacing: 7.04,
                ),
              ),
            ),
          ),
          // スクロール可能な円
          Positioned.fill(
            top: 314,
            child: ListView(
              children: [
                // 選択した色ごとに異なる色を生成し、生成した色をランダムな順番で表示
                ...generateDifferentColors(selectedColor).map((color) {
                  return _buildCircle(colorNames[color] ?? 'Unknown', color);
                }).toList(),
                SizedBox(
                  height: 200, // 余白の高さ
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircle(String colorName, Color color) {
    return Column(
      children: [
        Container(
          width: 136,
          height: 141,
          decoration: ShapeDecoration(
            color: color,
            shape: CircleBorder(
              side: BorderSide(
                color: Colors.black, // 枠線の色を設定
                width: 1.0, // 枠線の幅を設定
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          width: 230,
          height: 45,
          child: Text(
            colorName,
            textAlign: TextAlign.center,
            style: GoogleFonts.zenMaruGothic(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              height: 0,
              letterSpacing: 2.20,
            ),
          ),
        ),
        SizedBox(
          height: 20, // 余白の高さ
        ),
      ],
    );
  }
}
