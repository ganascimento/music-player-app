import 'package:flutter/material.dart';

class ButtonComponent extends StatefulWidget {
	final Widget child;
	final Function handle;

	ButtonComponent({@required this.child, @required this.handle});

	@override
	_ButtonComponentState createState() => _ButtonComponentState();
}

class _ButtonComponentState extends State<ButtonComponent> {
	@override
	Widget build(BuildContext context) {
		return Material(
			color: Colors.transparent,
			child: InkWell(
				borderRadius: BorderRadius.circular(100),
				onTap: widget.handle,
				child: widget.child,
			),
		);
	}
}