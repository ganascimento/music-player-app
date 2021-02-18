import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			navigatorKey: Modular.navigatorKey,
			title: 'Music App',
			theme: ThemeData(
				primarySwatch: Colors.blue,
				canvasColor: Color.fromRGBO(25, 25, 25, 1),
				textTheme: TextTheme(
					bodyText2: TextStyle(
						color: Colors.white
					)
				)
			),
			initialRoute: '/',
			onGenerateRoute: Modular.generateRoute,
		);
	}
}