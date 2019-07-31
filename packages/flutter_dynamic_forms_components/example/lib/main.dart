import 'package:dynamic_forms/dynamic_forms.dart' as forms;
import 'package:flutter_dynamic_forms_components/flutter_dynamic_forms_components.dart'
    as components;
import 'package:flutter/material.dart';
import 'package:example/dynamic_form/dynamic_form_bloc.dart';
import 'package:example/dynamic_form/dynamic_form_screen.dart';
import 'package:example/simple_form/simple_form_screen.dart';
import 'package:example/transition_form/transition_form_bloc.dart';
import 'package:example/transition_form/transition_form_builder.dart';
import 'package:example/transition_form/transition_form_screen.dart';
import 'package:flutter_bloc_extensions/flutter_bloc_extensions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key key}) : super(key: key);

  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SimpleFormScreen(),
                        ),
                      );
                    },
                    child: Text("Simple Form"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DisposableBlocProvider(
                                  blocFactory: () {
                                    return DynamicFormBloc(
                                      forms.FormManagerBuilder(
                                        forms.FormParserService(
                                          components.getDefaultParserList(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: DynamicFormScreen(),
                                ),
                          ),
                        );
                      },
                      child: Text("Dynamic Form With Bloc"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: RaisedButton(
                      onPressed: () {
                        var formManagerBuilder = forms.FormManagerBuilder(
                          forms.FormParserService(
                            components.getDefaultParserList(),
                          ),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DisposableBlocProvider(
                                  blocFactory: () {
                                    return TransitionFormBloc(
                                      formManagerBuilder,
                                      TransitionFormBuilder(formManagerBuilder),
                                    );
                                  },
                                  child: TransitionFormScreen(),
                                ),
                          ),
                        );
                      },
                      child: Text("Transition Dynamic Form"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}