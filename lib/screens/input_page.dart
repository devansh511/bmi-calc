import 'results_page.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/reusable_card.dart';
import '../components/reusable_icons.dart';
import '../constants.dart';
import '../components/bottom_button.dart';
import '../components/round_buttons.dart';
import '../calculateBrain.dart';

enum Gender {
  male,
  female,
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  // Color maleCardColour = inActiveCardColor;
  // Color femaleCardColour = inActiveCardColor;

  Gender selectedGender;
  int height = 180;
  int weight = 60;
  int age = 19;
  CalculatorBrain calc;
  double bmi;
  Color bmiTextColor;
  String status;

  String getBMI()
  {
    setState(() {
      bmi = weight / pow(height / 100, 2);
      return bmi.toString();
    });
    return bmi.toStringAsFixed(1);
  }

  Color bmiColor()
  {
    setState(() {
      if(bmi >= 25)
        bmiTextColor = Colors.red;
      else if(bmi > 18.5)
        bmiTextColor = Colors.green;
      else
        bmiTextColor = Colors.yellow;
      return bmiTextColor;
    });
    return bmiTextColor;
  }

  String getStatus()
  {
    setState(() {
      if(bmi >= 25)
        status = "High";
      else if(bmi > 18.5)
        status = "Normal";
      else
        status = "Low";
      return status;
    });
    return status;
  }

  // @override
  // void initState() {
  //   calc.calcBMI();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
        elevation: 10.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ReusableCard(
                    onPress: () {
                      setState(() {
                        selectedGender = Gender.male;
                      });
                    },
                    colour: selectedGender == Gender.male
                        ? kActiveCardColor
                        : kInActiveCardColor,
                    cardChild: ReusableIcons(
                      icon: FontAwesomeIcons.mars,
                      label: 'MALE',
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    onPress: () {
                      setState(() {
                        selectedGender = Gender.female;
                      });
                    },
                    colour: selectedGender == Gender.female
                        ? kActiveCardColor
                        : kInActiveCardColor,
                    cardChild: ReusableIcons(
                      icon: FontAwesomeIcons.venus,
                      label: 'FEMALE',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ReusableCard(
              colour: kActiveCardColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'HEIGHT',
                    style: kLabelTextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    textBaseline: TextBaseline.alphabetic,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: <Widget>[
                      Text(
                        height.toString(),
                        style: kCardText,
                      ),
                      Text(
                        'cm',
                        style: kLabelTextStyle,
                      ),
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      inactiveTrackColor: Color(0xff8D8E98),
                      activeTrackColor: Colors.white,
                      thumbColor: Color(0xFFEB1555),
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 15.0),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 25.0),
                      overlayColor: Color(0x29EB1555),
                    ),
                    child: Slider(
                      value: height.toDouble(),
                      min: 120.0,
                      max: 220.0,
                      onChanged: (double newValue) {
                        setState(() {
                          height = newValue.round();
                          calc =
                              CalculatorBrain(height: height, weight: weight);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ReusableCard(
                    colour: kActiveCardColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'WEIGHT',
                          style: kLabelTextStyle,
                        ),
                        Text(
                          weight.toString(),
                          style: kCardText,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(() {
                                  --weight;
                                  calc =
                                  CalculatorBrain(height: height, weight: weight);
                                });
                              },
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  ++weight;
                                  calc =
                                      CalculatorBrain(height: height, weight: weight);
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    colour: kActiveCardColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'AGE',
                          style: kLabelTextStyle,
                        ),
                        Text(
                          age.toString(),
                          style: kCardText,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(() {
                                  age--;
                                });
                              },
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  age++;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Expanded(
          //   child: Container(
          //     padding: EdgeInsets.all(15.0),
          //     alignment: Alignment.bottomLeft,
          //     child: Text(
          //       'Your Result',
          //       style: kTitleTextStyle,
          //     ),
          //   ),
          // ),
          Expanded(
            // flex: 5,
            child: ReusableCard(
              colour: kActiveCardColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text(
                  //   calc.getInterpretation().toUpperCase(),
                  //   style: kResultTextStyle,
                  // ),
                  Text(
                    getBMI(),
                    style: TextStyle(
                      fontSize: 100.0,
                      fontWeight: FontWeight.bold,
                      color: bmiColor(),
                    ),
                  ),
                  Text(
                    getStatus(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: bmiColor(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // BottomButton(
          //   buttonTitle: 'CALCULATE',
          //   onTap: () {
          //     CalculatorBrain calc =
          //         CalculatorBrain(height: height, weight: weight);
          //
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => ResultsPage(
          //           bmiResult: calc.calcBMI(),
          //           resultText: calc.getInterpretation(),
          //           interpretation: calc.getInterpretation(),
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
