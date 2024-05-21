import 'package:flutter/material.dart';
import 'package:shopping_cart/model/cart.dart';
import 'package:shopping_cart/model/product_items.dart';
import 'package:shopping_cart/pages/bottom_navigation_page.dart';
import 'package:shopping_cart/pages/cart_page.dart';
import 'package:shopping_cart/pages/detail_page.dart';
import 'package:shopping_cart/pages/favorite_page.dart';
import 'package:shopping_cart/pages/search_page.dart';
import 'package:online_sale_client/models/models.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int indexCategory = 0;
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationPage(
        selectedIndex: selectedIndex,
        onItemTapped: (index) => setState(() {
          selectedIndex = index;
        }),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          header(),
          search(),
          const SizedBox(height: 15),
          //categories(),
          Expanded(
            child: gridItems(),
          ),
        ],
      ),
    );
  }

  Widget header() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Material(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  child: const Icon(Icons.menu, color: Colors.black),
                ),
              ),
            ),
            const Spacer(),
            const Icon(Icons.location_on, color: Colors.green, size: 18),
            const Text('Tuticorin, TamilNadu'),
            const Spacer(),
            CircleAvatar(
                child: Image.asset(
              'lib/images/profile.jpg',
              fit: BoxFit.cover,
              width: 40,
              height: 40,
            )),
          ],
        ),
      ),
    );
  }

  Widget search() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SearchPage()),
        ).then((_) {
          setState(() {});
        });
      },
      child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.fromLTRB(8, 2, 6, 2),
        decoration: BoxDecoration(
          color: Colors.green[50],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.green),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Search Items',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget categories() {
    List list = ['Fruits', 'vegetables', 'Grocery', 'Drinks', 'Cakes'];
    return SizedBox(
      height: 40,
      child: ListView.builder(
          itemCount: list.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                indexCategory = index;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(
                  index == 0 ? 16 : 16,
                  0,
                  index == list.length - 1 ? 16 : 16,
                  0,
                ),
                alignment: Alignment.center,
                child: Text(
                  list[index],
                  style: TextStyle(
                    fontSize: 22,
                    color: indexCategory == index ? Colors.green : Colors.grey,
                    fontWeight: indexCategory == index ? FontWeight.bold : null,
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget gridItems() {
    return SingleChildScrollView(
      child: GridView.builder(
        itemCount: dummyProduct.nodes().length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          mainAxisExtent: 261,
        ),
        itemBuilder: (context, index) {
          Inventory product = dummyProduct.nodes()[index];
          int currentQuantity = 0;
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailPage(product: product);
              }));
            },
            child: Container(
              height: 261,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Center(
                        child: ClipRect(
                          child: Image.network(
                            product.imgUrl!,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            product.name,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 16),
                      //   child: Row(
                      //     children: [
                      //       const Spacer(),
                      //       const Icon(Icons.star, color: Colors.amber, size: 18),
                      //       const SizedBox(width: 4),
                      //       Text(
                      //         product.rating.toString(),
                      //         style: TextStyle(color: Colors.grey[600]),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(16),
                      //   child: Text(
                      //     '₹.${product.price}',
                      //     style: const TextStyle(
                      //       color: Colors.black,
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 20,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  // Positioned(
                  //   top: 6,
                  //   right: 6,
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       setState(() {
                  //         product.isFavorite = !product.isFavorite;
                  //       });
                  //     },
                  //     child: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border,
                  //         color: product.isFavorite ? Colors.red : Colors.grey),
                  //   ),
                  // ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Material(
                      color: Colors.green,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            // addToCart(product);
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                                size: 30,
                              ),
                              if (currentQuantity > 0)
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                      color: Colors.red[200],
                                      shape: BoxShape.circle,
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 14,
                                      minHeight: 14,
                                    ),
                                    child: Text(
                                      '$currentQuantity',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
