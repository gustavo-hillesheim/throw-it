import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {

	final String text;
	final Text child;
	final double elevation;
	final double width;
	final double height;
	final Color color;
	final Color textColor;
	final Function onPressed;

	const ActionButton({this.text, this.child, this.elevation, this.width,
		this.height, this.color, this.textColor, this.onPressed, Key key}) : super(key: key);

	@override
	Widget build(BuildContext context) {

		return Center(
			child: Container(
				width: this.width ?? MediaQuery.of(context).size.width * 0.8,
				height: this.height ?? 48,
				padding: EdgeInsets.symmetric(
					horizontal: 16
				),
				child: RaisedButton(
					child: this.child ?? _defaultText(context),
					onPressed: this.onPressed,
					elevation: this.elevation ?? 4,
					color: this.color ?? Theme.of(context).primaryColor,
					shape: RoundedRectangleBorder(
						borderRadius: BorderRadius.all(Radius.circular(32))
					),
				)
			)
		);
	}

	Widget _defaultText(BuildContext context) {

		return Text(
			this.text,
			style: TextStyle(
				color: this.textColor ?? Theme.of(context).accentColor
			)
		);
	}
}