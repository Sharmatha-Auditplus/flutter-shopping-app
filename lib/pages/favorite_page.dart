import 'package:flutter/material.dart';
import 'package:shopping_cart/model/cart.dart';
import 'package:shopping_cart/model/product_items.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Favorite Item',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: buildFavoriteCard(),
      // body: GridView.builder(
      //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 2,
      //     crossAxisSpacing: 10.0,
      //     mainAxisSpacing: 10.0,
      //   ),
      //   itemCount: favoriteProducts.length,
      //   itemBuilder: (context, index) {
      //     return Card(
      //       child: ListTile(
      //         title: Text(favoriteProducts[index].name),
      //         subtitle: Text('₹${favoriteProducts[index].price.toString()}'),
      //         leading: Image.asset(
      //           favoriteProducts[index].image,
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }

  buildFavoriteCard() {
    List<Product> favoriteProducts = dummyProduct.where((product) => product.isFavorite).toList();
    return SingleChildScrollView(
      child: GridView.builder(
        itemCount: favoriteProducts.length,
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
          //Product product = dummyProduct[index];
          int currentQuantity = getCartQuantity(favoriteProducts[index].id);
          return GestureDetector(
            onTap: () {},
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
                            favoriteProducts[index].image,
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
                            favoriteProducts[index].name,
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
                      //         favoriteProducts[index].rating.toString(),
                      //         style: TextStyle(color: Colors.grey[600]),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          '₹.${favoriteProducts[index].price}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          favoriteProducts[index].isFavorite = !favoriteProducts[index].isFavorite;
                        });
                      },
                      child: Icon(favoriteProducts[index].isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: favoriteProducts[index].isFavorite ? Colors.red : Colors.grey),
                    ),
                  ),
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
                            addToCart(favoriteProducts[index]);
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
