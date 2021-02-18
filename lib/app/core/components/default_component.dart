import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:musicapp/app/modules/start/pages/player/player_page.dart';
import 'package:musicapp/app/modules/start/start_controller.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DefaultPage extends StatefulWidget {
	final Widget body;

	DefaultPage({@required this.body});

	@override
	_DefaultPageState createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
	@override
	Widget build(BuildContext context) {
		final controller = Modular.get<StartController>();
		final size = MediaQuery.of(context).size;

		return Material(
		  child: SafeArea(
		    child: Observer(
		    	builder: (_) {
		    		return SlidingUpPanel(
		    			minHeight: controller.currentMusic != null ? 69 : 0,
		    			maxHeight: size.height,
		    			panel: PlayerPage(),							
		    			body: Container(
								margin: controller.currentMusic != null ? EdgeInsets.only(bottom: 69) : null,
								child: widget.body
							)
		    		);
		    	}
		    )
		  )
		);
	}
}