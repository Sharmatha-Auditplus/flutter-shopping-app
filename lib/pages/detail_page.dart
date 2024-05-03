import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:shopping_cart/model/cart.dart';
import 'package:shopping_cart/model/product_items.dart';
import 'package:shopping_cart/pages/cart_page.dart';
import 'package:online_sale_client/models/models.dart';
import 'package:shopping_cart/pages/search_page.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: search(),
      ),
      body: Column(
        children: [
          //image(),
          Expanded(
            child: details(),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: SizedBox(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
        width: 300,
        padding: const EdgeInsets.fromLTRB(8, 2, 6, 2),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0.5),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
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
      height: 280,
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
                //borderRadius: BorderRadius.circular(250),
              ),
              child: ClipRRect(
                //borderRadius: BorderRadius.circular(250),
                child: Image.network(
                  widget.product.imgUrl!,
                  fit: BoxFit.cover,
                  width: 250,
                  height: 250,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget details() {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.product.name,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500, fontSize: 20),
            ),
            //const SizedBox(height: 10),
            // Text(
            //   'Batches',
            //   style: Theme.of(context).textTheme.titleMedium!.copyWith(
            //         fontWeight: FontWeight.w500,
            //         fontSize: 18,
            //       ),
            // ),
            //const SizedBox(height: 10),
            //batchCategories(),
            // const SizedBox(height: 10),
            // Text(
            //   'All Batch Details',
            //   style: Theme.of(context).textTheme.titleMedium!.copyWith(
            //         fontWeight: FontWeight.w500,
            //         fontSize: 18,
            //       ),
            // ),
            const SizedBox(height: 5),
            allBatchDetails(),
          ],
        ),
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

  Widget allBatchDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.product.inventoryBatches.nodes().map((batch) {
        var showDiscount = batch.disc > 0;
        return Column(
          children: [
            SizedBox(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.network(widget.product.imgUrl!, width: 60, height: 60),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
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
                            batch.rate!.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 26,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'M.R.P: ',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                          Text(
                            '₹${batch.mrp!.toString()}',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  decoration: batch.mrp == batch.rate ? null : TextDecoration.lineThrough,
                                ),
                          ),
                          const SizedBox(width: 5),
                          if (showDiscount)
                            Text(
                              '(${batch.disc.toString()}% off)',
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: const Color.fromARGB(255, 210, 25, 11),
                                  fontSize: 16),
                            ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (quantity > 1) {
                                quantity -= 1;
                              }
                            });
                          },
                          icon: const Icon(
                            Icons.remove,
                            color: Colors.green,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '$quantity',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                        ),
                        const SizedBox(width: 2),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              quantity += 1;
                            });
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.green,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
          ],
        );
      }).toList(),
    );
  }
}
