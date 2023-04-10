// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shrine/login.dart';

import 'model/product.dart';
import 'model/products_repository.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'favoriteHotelPage.dart';

final List<bool> _selectedView = <bool>[false, true];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              accountName: Text(
                'Pages',
                style: TextStyle(fontSize: 20),
              ),
              accountEmail: null,
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
                color: Colors.blue,
              ),
              title: const Text('Home'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.search,
                color: Colors.blue,
              ),
              title: const Text('Search'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.location_city,
                color: Colors.blue,
              ),
              title: const Text('Favorite Hotel'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.person,
                color: Colors.blue,
              ),
              title: const Text('My Page'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.blue,
              ),
              title: const Text('Log out'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Main'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              semanticLabel: 'search',
            ),
            onPressed: () {
              print('Search button');
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.language,
              semanticLabel: 'language',
            ),
            onPressed: () {
              print('language button');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ToggleButtons(
                  onPressed: (int index) {
                    setState(() {
                      // The button that is tapped is set to true, and the others to false.
                      for (int buttonIndex = 0;
                          buttonIndex < _selectedView.length;
                          buttonIndex++) {
                        if (buttonIndex == index) {
                          _selectedView[buttonIndex] = true;
                        } else {
                          _selectedView[buttonIndex] = false;
                        }
                      }
                    });
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  selectedBorderColor: Colors.blue[700],
                  selectedColor: Colors.white,
                  fillColor: Colors.blue[200],
                  color: Colors.blue[400],
                  isSelected: _selectedView,
                  children: icons,
                ),
              ],
            ),
          ),
          if (_selectedView[1])
            Expanded(
              //vertical error 날때 이 위젯쓰면 해결
              child: OrientationBuilder(
                builder: ((context, orientation) {
                  return GridView.count(
                      crossAxisCount:
                          orientation == Orientation.portrait ? 2 : 3,
                      padding: const EdgeInsets.all(16.0),
                      childAspectRatio: 8.0 / 9.0,
                      // TODO: Build a grid of cards (102)
                      // TODO: Build a grid of cards (102)
                      children: _buildGridCards(context));
                }),
              ),
            ),
          if (_selectedView[0])
            Expanded(
                child: ListView(
              children: _buildListTiles(context),
            ))
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}

// Replace this entire method
List<Card> _buildGridCards(BuildContext context) {
  List<Product> products = ProductsRepository.loadProducts(Category.all);

  if (products.isEmpty) {
    return const <Card>[];
  }

  final ThemeData theme = Theme.of(context);
  final NumberFormat formatter = NumberFormat.simpleCurrency(
      locale: Localizations.localeOf(context).toString());

  return products.map((product) {
    return Card(
      clipBehavior: Clip.antiAlias,

      // TODO: Adjust card heights (103)
      child: Column(
        // TODO: Center items on the card (103)
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 18 / 11,
            child: Image.asset(
              product.assetName,
              package: product.assetPackage,
              // TODO: Adjust the box size (102)
              fit: BoxFit.fitWidth,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 5.0),
              child: Column(
                // TODO: Align labels to the bottom and center (103)
                crossAxisAlignment: CrossAxisAlignment.start,
                // TODO: Change innermost Column (103)
                children: <Widget>[
                  // TODO: Handle overflowing labels (103)
                  Row(
                    children: [
                      for (int i = 0; i < product.star; i++)
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 15,
                        )
                    ],
                  ),
                  Text(
                    product.name,
                    style: theme.textTheme.headline6,
                    maxLines: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on),
                        Text(
                          product.subtitle,
                          style: theme.textTheme.subtitle2,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return DetailScreen(product);
                              }));
                            },
                            child: Hero(
                                tag: product.id,
                                child: const Text(
                                  'more',
                                  style: TextStyle(color: Colors.blue),
                                ))),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }).toList();
}

List<Card> _buildListTiles(BuildContext context) {
  List<Product> products = ProductsRepository.loadProducts(Category.all);

  if (products.isEmpty) {
    return const <Card>[];
  }

  final ThemeData theme = Theme.of(context);
  final NumberFormat formatter = NumberFormat.simpleCurrency(
      locale: Localizations.localeOf(context).toString());

  return products.map((product) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListTile(
          leading: AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child: Image.asset(product.assetName,
                  package: product.assetPackage, fit: BoxFit.cover),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  for (int i = 0; i < product.star; i++)
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 15,
                    )
                ],
              ),
              Text(
                product.name,
                style: theme.textTheme.headline6,
                maxLines: 1,
              ),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                const Icon(Icons.location_on),
                Text(
                  product.subtitle,
                  style: theme.textTheme.subtitle2,
                ),
                const Expanded(child: SizedBox()),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DetailScreen(product);
                      }));
                    },
                    child: Hero(
                        tag: product.id,
                        child: const Text(
                          'more',
                          style: TextStyle(color: Colors.blue),
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }).toList();
}

const List<Widget> icons = <Widget>[
  Icon(Icons.list),
  Icon(Icons.grid_view),
];

class DetailScreen extends StatefulWidget {
  DetailScreen(this.product, {Key? key}) : super(key: key);

  Product product;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isFeatured = false;
  @override
  void initState() {
    super.initState();
    _isFeatured = widget.product.isFeatured;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Main'),
      ),
      body: InkWell(
        onDoubleTap: () async {
          setState(() {
            _isFeatured = !_isFeatured;
            widget.product.isFeatured = _isFeatured;
          }); // 즉각 반응하게 하기 위해서는 setState 구문을 써야한다.
        },
        child: Hero(
          tag: widget.product.id,
          child: Column(
            children: [
              Stack(children: [
                Image.asset(
                  widget.product.assetName,
                  package: widget.product.assetPackage,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
                ),
                Positioned(
                  top: 15,
                  right: 15,
                  child: Icon(
                    widget.product.isFeatured
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.red,
                  ),
                )
              ]),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          for (int i = 0; i < widget.product.star; i++)
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 30,
                            )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText(
                                widget.product.name,
                                textStyle: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                                speed: const Duration(milliseconds: 100),
                              ),
                            ],
                            totalRepeatCount: 1,
                            pause: const Duration(milliseconds: 500),
                            displayFullTextOnTap: true,
                            stopPauseOnTap: true,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.blue,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.product.subtitle,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.phone, color: Colors.blue),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.product.phoneNumber,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
