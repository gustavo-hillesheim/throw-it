import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {

	final String text;
	final Text child;
	final double elevation;
	final double width;
	final double height;
	final Color color;
	final Color hoverColor;
	final Function onPressed;

	ActionButton({this.text, this.child, this.elevation, this.hoverColor,
		this.width, this.height, this.color, this.onPressed, Key key}) : super(key: key);

	@override
	Widget build(BuildContext context) {

		return Center(
			child: Container(
				width: this.width ?? MediaQuery.of(context).size.width * 0.6,
				height: this.height ?? 48,
				padding: EdgeInsets.symmetric(
					horizontal: 16
				),
				child: RaisedButton(
					child: this.child ?? Text(this.text),
					onPressed: this.onPressed,
					elevation: this.elevation ?? 4,
					color: this.color ?? Colors.lightGreenAccent[400],
					hoverColor: this.hoverColor ?? Colors.lightGreenAccent[700],
					shape: RoundedRectangleBorder(
						borderRadius: BorderRadius.all(Radius.circular(32))
					),
				)
			)
		);
	}
}