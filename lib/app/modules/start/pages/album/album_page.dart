import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:musicapp/app/core/components/tag_item_component.dart';
import 'package:musicapp/app/modules/start/start_controller.dart';

class AlbumPage extends StatefulWidget {
  @override
  _AlbumPageState createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
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
										childAspectRatio: 16 / 13,
										crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
										children: List.generate(controller.albums.length, (index) {
											return TagItemComponent(
												pathImage: controller.albums[index].pathImage,
												title: controller.albums[index].name,
												playId: controller.albums[index].playId,
												musics: controller.albums[index].musics
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
