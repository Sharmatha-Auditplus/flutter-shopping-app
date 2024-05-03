import 'package:flutter/material.dart';
import 'package:shopping_cart/model/cart.dart';
import 'package:shopping_cart/model/product_items.dart';
import 'package:shopping_cart/pages/cart_page.dart';
import 'package:shopping_cart/pages/detail_page.dart';
import 'package:shopping_cart/pages/favorite_page.dart';
import 'package:shopping_cart/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:online_sale_client/online_sale_client.dart';
import 'package:online_sale_client/models/models.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Inventory> filteredProduct = [];
  TextEditingController searchController = TextEditingController();
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0.5),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextField(
            controller: searchController,
            autofocus: true,
            decoration: const InputDecoration(
                hintText: 'Search items...',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.symmetric(horizontal: 8)),
            onSubmitted: (value) {
              filterProducts();
            },
          ),
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

  filterProducts() async {
    // final res = await context.read<OnlineSaleClient>().findInventory(searchText: searchController.text.toLowerCase())
    //   ..nodes();
    // filteredProduct = res.nodes();
    filteredProduct = dummyProduct.nodes().where((grocery) {
      return grocery.name.toLowerCase().contains(searchController.text.toLowerCase());
    }).toList();
    setState(() {});
  }

  Widget buildProductCard() {
    if (filteredProduct.isEmpty) {
      return const Center(
        child: Text('Type to search for groceries'),
      );
    }
    Batch lowestBatch(Inventory inventory) {
      return inventory.inventoryBatches.nodes().reduce((value, element) {
        if (element.rate! < value.rate!) {
          return element;
        } else if (element.rate! == value.rate! && element.mrp! > value.mrp!) {
          return element;
        } else {
          return value;
        }
      });
    }

    return SingleChildScrollView(
      child: GridView.builder(
        itemCount: filteredProduct.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(5),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          mainAxisExtent: 280,
        ),
        itemBuilder: (context, index) {
          var batch = lowestBatch(filteredProduct[index]);
          var showDiscount = batch.disc > 0;
          //var showMRP = batch.mrp != null && batch.mrp != batch.rate;
          //int currentQuantity = getCartQuantity(filteredProduct[index].id);
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailPage(product: filteredProduct[index]);
              })).then((_) => setState(() {}));
            },
            child: Container(
              height: 280,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 0.1)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Center(
                    child: ClipRect(
                      child: Image.network(
                        filteredProduct[index].imgUrl!,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 150,
                            height: 150,
                            color: Colors.grey,
                            child: const Center(
                              child: Text(
                                'Image not available',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          );
                        },
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
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              '₹',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '${batch.rate}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'M.R.P: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '₹${batch.mrp}',
                              style: TextStyle(
                                decoration: batch.mrp == batch.rate ? null : TextDecoration.lineThrough,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            if (showDiscount)
                              Text(
                                '(${batch.disc}% off)',
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                ),
                              ),
                          ],
                        ),
                      ],
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
