import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _controllerSizeInt;
  late TextEditingController _controllerSizeFirstInch;
  late TextEditingController _controllerSizeSecondInch;
  late TextEditingController _controllerOverSizeFirstInch;
  late TextEditingController _controllerOverSizeSecondInch;
  late TextEditingController _controllerCountOverSize;

  final ValueNotifier<double> sizeNotifier = ValueNotifier<double>(0);
  final ValueNotifier<double> overSizeNotifier = ValueNotifier<double>(0);
  final ValueNotifier<double> wholeSizeNotifier = ValueNotifier<double>(0);

  double roundCm(double cm) {
    int cmInt = cm.toInt();
    double afterComma = cm - cmInt;

    if (afterComma < 0.125) {
      return cmInt + 0.0;
    }
    if (afterComma < 0.375) {
      return cmInt + 0.25;
    }
    if (afterComma < 0.625) {
      return cmInt + 0.5;
    }
    if (afterComma < 0.875) {
      return cmInt + 0.75;
    }
    return cmInt + 1.0;
  }

  double textToDouble(String s) {
    if (s == '') {
      return 0.0;
    }
    return double.parse(s);
  }

  double inchToCm(double inch) {
    return roundCm(2.54 * inch);
  }

  void setDefault() {
    _controllerSizeInt.text='';
    _controllerSizeFirstInch.text='';
    _controllerSizeSecondInch.text='';
    _controllerOverSizeFirstInch.text = '1';
    _controllerOverSizeSecondInch.text = '4';
    _controllerCountOverSize.text = '2';

    overSizeNotifier.value = inchToCm(
        textToDouble(_controllerOverSizeFirstInch.value.text) /
            textToDouble(_controllerOverSizeSecondInch.value.text));
  }
  @override
  void initState() {
    super.initState();
    _controllerSizeInt = TextEditingController();
    _controllerSizeFirstInch = TextEditingController();
    _controllerSizeSecondInch = TextEditingController();
    _controllerOverSizeFirstInch = TextEditingController();
    _controllerOverSizeSecondInch = TextEditingController();
    _controllerCountOverSize = TextEditingController();

    setDefault();

  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text('Пересчет и адаптация'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Align(
              alignment: Alignment.topLeft,
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: Form(
                onChanged: () {
                  //Form.of(primaryFocus!.context!).save();
                  double sizeInt = textToDouble(_controllerSizeInt.value.text);
                  double sizeFirst =
                      textToDouble(_controllerSizeFirstInch.value.text);
                  double sizeSecond =
                      textToDouble(_controllerSizeSecondInch.value.text);
                  sizeSecond > 0
                      ? sizeFirst = sizeFirst / sizeSecond
                      : sizeFirst = 0;
                  double lenghtOfDetails = sizeInt + sizeFirst;

                  double lenghtOversize = 0;
                  if (textToDouble(_controllerOverSizeSecondInch.value.text) >
                      0) {
                    lenghtOversize = textToDouble(
                            _controllerOverSizeFirstInch.value.text) /
                        textToDouble(_controllerOverSizeSecondInch.value.text);
                  }
                  //print(_controllerOverSizeFirstInch.value.text);

                  sizeNotifier.value = inchToCm(lenghtOfDetails);
                  overSizeNotifier.value = inchToCm(lenghtOversize);
                  wholeSizeNotifier.value = inchToCm(lenghtOfDetails) +
                      int.parse(_controllerCountOverSize.value.text) *
                          (inchToCm(lenghtOversize));
                  //wholeSizeNotifier=inchToCm(lenghtOfDetails)+()
                  print(inchToCm(lenghtOversize));
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Размер:',style: Theme.of(context).textTheme.titleMedium),
                          Expanded(
                            child: Align(
                                alignment: Alignment.topRight,
                                child: SizedBox(
                                  width: 70,
                                  child: TextFormField(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'\d+'))
                                      ],
                                      controller: _controllerSizeInt,
                                      keyboardType: TextInputType.number,
                                      maxLength: 7,
                                      onChanged: (String? str) {
                                        print('change $str');
                                      },
                                      style: Theme.of(context).textTheme.displayLarge),
                                )),
                          ),
                          const Text(' '),
                          Expanded(
                            child: Align(
                                alignment: Alignment.topRight,
                                child: SizedBox(
                                  width: 30,
                                  child: TextFormField(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'\d+'))
                                      ],
                                      controller: _controllerSizeFirstInch,
                                      keyboardType: TextInputType.number,
                                      maxLength: 2,

                                      onSaved: (String? str) {
                                        print('save $str');

                                      },
                                      style: Theme.of(context).textTheme.displayLarge
                                      ),
                                )),
                          ),
                          const Text('/'),
                          Expanded(
                            child: Align(
                                alignment: Alignment.topRight,
                                child: SizedBox(
                                  width: 30,
                                  child: TextFormField(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'\d+'))
                                      ],
                                      controller: _controllerSizeSecondInch,
                                      keyboardType: TextInputType.number,
                                      maxLength: 2,
                                      onSaved: (String? str) {
                                        print('save $str');
                                      },
                                      style: Theme.of(context).textTheme.displayLarge),
                                )),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text('Припуск:',style: Theme.of(context).textTheme.titleMedium),
                          Expanded(
                            child: Align(
                                alignment: Alignment.topRight,
                                child: SizedBox(
                                  width: 50,
                                  child: TextFormField(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'\d+'))
                                      ],
                                      controller: _controllerCountOverSize,
                                      keyboardType: TextInputType.number,
                                      maxLength: 2,
                                      onChanged: (String? str) {
                                        print('change111111 $str');
                                      },
                                      style: Theme.of(context).textTheme.displayLarge
                                      ),
                                )),
                          ),
                          Expanded(
                            child: Align(
                                alignment: Alignment.topRight,
                                child: SizedBox(
                                  width: 50,
                                  child: TextFormField(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'\d+'))
                                      ],
                                      controller: _controllerOverSizeFirstInch,
                                      keyboardType: TextInputType.number,
                                      maxLength: 2,
                                      onChanged: (String? str) {
                                        print('change111111 $str');
                                      },
                                      style: Theme.of(context).textTheme.displayLarge),
                                )),
                          ),
                          const Text('/'),
                          Expanded(
                            child: Align(
                                alignment: Alignment.topRight,
                                child: SizedBox(
                                  width: 30,
                                  child: TextFormField(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'\d+'))
                                      ],
                                      controller: _controllerOverSizeSecondInch,
                                      keyboardType: TextInputType.number,
                                      maxLength: 2,
                                      onSaved: (String? str) {
                                        print('save $str');
                                      },
                                      style: Theme.of(context).textTheme.displayLarge),
                                ),
                            ),
                          )
                        ],
                      ),
                      const Padding(padding: EdgeInsets.all(5.0),
                        child: Divider(height: 2.0,),
                        ),
                      Row(children: [
                        const Text('Длина детали: ',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16)),
                        ValueListenableBuilder<double>(
                            valueListenable: sizeNotifier,
                            builder: (context, value, child) {
                              return Text("$value см",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18));
                            })
                      ]),
                      Row(children: [
                        const Text('Длина припуска: ',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16)),
                        ValueListenableBuilder<double>(
                            valueListenable: overSizeNotifier,
                            builder: (context, value, child) {
                              return Text('$value см',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18));
                            })
                      ]),
                      Row(children: [
                        const Text('Общая длина: ',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16)),
                        ValueListenableBuilder<double>(
                            valueListenable: wholeSizeNotifier,
                            builder: (context, value, child) {
                              return Text('$value см',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18));
                            })
                      ]),
                      TextButton(onPressed: () {setDefault();}, child: const Text('Сбросить'))
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controllerSizeInt.dispose();
    _controllerSizeFirstInch.dispose();
    _controllerSizeSecondInch.dispose();
    _controllerOverSizeFirstInch.dispose();
    _controllerOverSizeSecondInch.dispose();
    _controllerCountOverSize.dispose();
    super.dispose();
  }
}
