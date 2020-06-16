import 'package:flutter/material.dart';
import 'package:marketplace/buy/product_details.dart';
import 'package:marketplace/common_widgets/category_list_tile.dart';
import 'package:marketplace/common_widgets/empty_content.dart';
import 'package:marketplace/common_widgets/product_list_tile.dart';
import 'package:marketplace/models/category.dart';
import 'package:marketplace/models/product.dart';
import 'package:marketplace/services/database.dart';
import 'package:provider/provider.dart';
import 'package:carousel_pro/carousel_pro.dart';

class Buy extends StatelessWidget {
  Widget image_carousel = new Container(
    height: 230,
    child: Carousel(
      boxFit: BoxFit.cover,
      images: [
        AssetImage('assets/display1.jpg'),
        AssetImage('assets/display2.jpeg'),
        AssetImage('assets/display3.jpg'),
        AssetImage('assets/display4.webp'),
        AssetImage('assets/display5.jpg'),
      ],
      animationCurve: Curves.fastOutSlowIn,
      autoplay: true,
      animationDuration: Duration(milliseconds: 1000),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        title: Text('College MarketPlace'),
      ),
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context);
    return Column(
      children: <Widget>[
        image_carousel,
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            'Categories',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: StreamBuilder<List<Category>>(
            stream: database.allCategoriesStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final allCategories = snapshot.data;
                if (allCategories.isNotEmpty) {
                  final children = allCategories
                      .map((category) => CategoryTile(
                            category: category,
                          ))
                      .toList();
                  return ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: children,
                  );
                }
                return EmptyContent();
              }
              if (snapshot.hasError) {
                return EmptyContent(
                  title: 'Something went wrong',
                  message: 'Can\'t load items right now',
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            'Products',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: StreamBuilder<List<SingleProduct>>(
            stream: database.allProductsStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final allProducts = snapshot.data;
                if (allProducts.isNotEmpty) {
                  final children = allProducts
                      .map((product) => ProductTile(
                            product: product,
                            onTap: () => Product_Details.show(
                              context,
                              product: product,
                            ),
                            height: 150,
                            width: 300,
                          ))
                      .toList();
                  return ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: children,
                  );
                }
                return EmptyContent(
                  title: 'Nothing Here',
                  message: 'No products to show',
                );
              }
              if (snapshot.hasError) {
                return EmptyContent(
                  title: 'Something went wrong',
                  message: 'Can\'t load items right now',
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }
}
