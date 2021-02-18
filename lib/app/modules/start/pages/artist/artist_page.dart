import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:musicapp/app/core/components/tag_item_component.dart';
import 'package:musicapp/app/modules/start/start_controller.dart';

class ArtistPage extends StatefulWidget {
  @override
  _ArtistPageState createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<StartController>();
    final size = MediaQuery.of(context).size;

    return Container(
			margin: EdgeInsets.only(bottom: 18),
			child: Padding(
				padding: EdgeInsets.only(right: size.width * 0.01),
				child: OrientationBuilder(
					builder: (_, orientation) {
						return Observer(
							builder: (_) {
								return GridView.count(
										childAspectRatio: 17 / 13,
										crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
										children: List.generate(controller.artists.length, (index) {
											return TagItemComponent(
												pathImage: controller.artists[index].pathImage,
												title: controller.artists[index].name,
												playId: controller.artists[index].playId,
												musics: controller.artists[index].musics
											);
										}
									)
								);
							}
						);
					}
				)
			)
		);
  }
}
