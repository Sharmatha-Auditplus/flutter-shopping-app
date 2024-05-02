import 'package:flutter/material.dart';

import 'package:shopping_cart/model/cart.dart';
import 'package:shopping_cart/model/product_items.dart';
import 'package:shopping_cart/pages/cart_page.dart';
import 'package:online_sale_client/models/models.dart';
import 'package:shopping_cart/pages/search_page.dart';
import '../pages/home_page.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.product});
  final Inventory product;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Batch selectedBatch;
  int selectedIndex = 0;
  int quantity = 1;

  @override
  void initState() {
    selectedBatch = widget.product.inventoryBatches.nodes().first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //int currentQuantity = getCartQuantity(widget.product.id);
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: search(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            image(),
            details(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: SizedBox(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Material(
                  color: Colors.green[300]!,
                  borderRadius: BorderRadius.circular(20),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (quantity > 1) {
                            quantity -= 1;
                            setState(() {});
                          }
                        },
                        icon: const Icon(Icons.remove, color: Colors.white),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$quantity',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      const SizedBox(width: 4),
                      IconButton(
                        onPressed: () {
                          quantity += 1;
                          setState(() {});
                        },
                        icon: const Icon(Icons.add, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CartPage()),
                    ).then((_) => setState(() {}));
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: const BorderSide(color: Colors.black),
                      ),
                    ),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Checkout', style: TextStyle(color: Colors.white)),
                      SizedBox(width: 8),
                      Icon(
                        Icons.shopping_cart_checkout_sharp,
                        color: Colors.white,
                        size: 15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
        height: 40,
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
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox image() {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              height: 50,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.green[300]!,
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
                child: Image.network(
                  widget.product.imgUrl!,
                  fit: BoxFit.cover,
                  width: 290,
                  height: 290,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container details() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 418,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Batches',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
          ),
          const SizedBox(height: 10),
          batchCategories(),
          const SizedBox(height: 10),

          //margin: const EdgeInsets.all(.0),
          //color: Colors.green[300]!,
          // shadowColor: Colors.green,
          // surfaceTintColor: Colors.black,
          // elevation: 8.0,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(16.0),
          // ),
          const Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '-${selectedBatch.disc.toString()}%',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.normal, color: Color.fromARGB(255, 159, 21, 11), fontSize: 24),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    '₹',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    selectedBatch.rate!.toString(),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: 40,
                        ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'M.R.P: ',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                  Text(
                    '₹${selectedBatch.mrp!.toString()}',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          decoration: selectedBatch.mrp == selectedBatch.rate ? null : TextDecoration.lineThrough,
                        ),
                  ),
                ],
              )
            ],
          ),
          const Divider(),
          // Text(
          //   'About Product',
          //   style: Theme.of(context).textTheme.titleMedium!.copyWith(
          //         fontWeight: FontWeight.w500,
          //       ),
          // ),
        ],
      ),
    );
  }

  Widget batchCategories() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        itemCount: widget.product.inventoryBatches.nodes().length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedBatch = widget.product.inventoryBatches.nodes()[index];
                  selectedIndex = index;
                });
              },
              child: Container(
                width: 50,
                height: 30,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: selectedIndex == index ? Colors.green : Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: selectedIndex == index ? Colors.green : Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
