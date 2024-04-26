import 'package:flutter/material.dart';
import 'package:shopping_cart/model/cart.dart';
import 'package:shopping_cart/model/product_items.dart';
import 'package:shopping_cart/pages/cart_page.dart';
import 'package:shopping_cart/pages/favorite_page.dart';
import 'package:shopping_cart/pages/home_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: TextField(
          controller: searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search items...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey),
          ),
          onSubmitted: (value) => setState(() {}),
        ),
        actions: [
          IconButton(
            onPressed: () {
              searchController.clear();
              setState(() {});
            },
            icon: const Icon(Icons.clear, color: Colors.black),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.green[200],
        currentIndex: selectedIndex,
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            ).then((_) => setState(() {}));
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartPage()),
            ).then((_) => setState(() {}));
          } else if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FavoritePage()),
            ).then((_) => setState(() {}));
          }
        },
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          const BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(
            icon: Stack(
              children: <Widget>[
                const Icon(Icons.shopping_cart),
                if (items.isNotEmpty)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minHeight: 14,
                        minWidth: 14,
                      ),
                      child: Text(
                        '${items.fold(0, (previousValue, current) => previousValue + current.quantity)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
              ],
            ),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notification'),
          const BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
        ],
      ),
      body: buildProductCard(),
    );
  }

  Widget buildProductCard() {
    List<Product> filteredProduct = [];
    if (searchController.text.isEmpty) {
      return const Center(
        child: Text('Type to search for groceries'),
      );
    } else {
      filteredProduct = dummyProduct.where((grocery) {
        return grocery.name.toLowerCase().contains(searchController.text.toLowerCase());
      }).toList();
    }

    return SingleChildScrollView(
      child: GridView.builder(
          itemCount: filteredProduct.length,
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
            int currentQuantity = getCartQuantity(filteredProduct[index].id);
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
                              filteredProduct[index].image,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              filteredProduct[index].name,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Text(
                                '₹.${filteredProduct[index].price}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const Spacer(),
                              // const Icon(Icons.star, color: Colors.amber, size: 18),
                              // const SizedBox(width: 4),
                              // Text(
                              //   filteredProduct[index].rating.toString(),
                              //   style: TextStyle(color: Colors.grey[600]),
                              // ),
                            ],
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
                            filteredProduct[index].isFavorite = !filteredProduct[index].isFavorite;
                          });
                        },
                        child: Icon(filteredProduct[index].isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: filteredProduct[index].isFavorite ? Colors.red : Colors.grey),
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
                              addToCart(filteredProduct[index]);
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              currentQuantity > 0 ? 'Add More ($currentQuantity)' : 'Add to Cart',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
