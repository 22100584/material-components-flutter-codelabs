import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'model/product.dart';
import 'model/products_repository.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FavoriteHotel extends StatefulWidget {
  const FavoriteHotel({Key? key}) : super(key: key);

  @override
  State<FavoriteHotel> createState() => _FavoriteHotelState();
}

class _FavoriteHotelState extends State<FavoriteHotel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Favorite Hotels')),
      body: ListView(
        children: _buildListTiles(context),
      ),
    );
  }
}

List<Card> _buildListTiles(BuildContext context) {
  List<Product> products = ProductsRepository.loadProducts(Category.all);

  if (products.isEmpty) {
    return const <Card>[];
  }

  final ThemeData theme = Theme.of(context);

  return products.map((product) {
    if (product.isFeatured) {
      return Card(
        child: Dismissible(
          key: ValueKey(product.id),
          background: Container(
              decoration: BoxDecoration(
                  color: const Color(0xffFF897D),
                  borderRadius: BorderRadius.circular(10)),
              child: SizedBox()),
          onDismissed: (direction) {
            setState(() {
              product.isFeatured = !(product.isFeatured);
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.name,
                    style: theme.textTheme.headline6,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return const Card();
  }).toList();
}

void setState(Null Function() param0) {}
