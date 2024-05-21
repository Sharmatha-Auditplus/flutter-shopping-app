import 'package:flutter/material.dart';
import 'package:shopping_cart/model/cart.dart';
import 'package:shopping_cart/model/product_items.dart';
import 'package:shopping_cart/pages/bottom_navigation_page.dart';
import 'package:shopping_cart/pages/cart_page.dart';
import 'package:online_sale_client/models/models.dart';
import 'package:shopping_cart/pages/home_page.dart';
import 'package:shopping_cart/pages/search_page.dart';
import 'package:shopping_cart/widgets/available_size.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.product});
  final Inventory product;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Batch selectedBatch;
  int selectedIndex = 0;
  int selectedSizeIndex = 0;
  int quantity = 1;

  @override
  void initState() {
    selectedBatch = widget.product.inventoryBatches.nodes().first;
    super.initState();
  }

  int getCartQuantity(int batchId) {
    for (var item in items) {
      if (item.batch.id == batchId) {
        return item.quantity;
      }
    }
    return 0;
  }

  void showImageDialog(String imgurl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0xFF2A8068)),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  imgurl,
                  fit: BoxFit.cover,
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(
              //     widget.product.name,
              //     style: const TextStyle(
              //       fontWeight: FontWeight.w500,
              //       fontSize: 18,
              //     ),
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }

  // Widget fullScreenImage(String imgUrl) => FullScreenWidget(
  //       disposeLevel: DisposeLevel.Medium,
  //       child: Center(
  //         child: Hero(
  //           tag: imgUrl,
  //           child: ClipRRect(
  //             borderRadius: BorderRadius.circular(16),
  //             child: Image.network(
  //               imgUrl,
  //               fit: BoxFit.cover,
  //             ),
  //           ),
  //         ),
  //       ),
  //     );

  @override
  Widget build(BuildContext context) {
    //int currentQuantity = getCartQuantity(widget.product.id);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        leading: const BackButton(color: Colors.black),
        title: search(),
        actions: [
          const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 6)),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              ).then((_) => setState(() {}));
            },
            icon: const Icon(Icons.shopping_cart_checkout_sharp, color: Colors.black),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationPage(
        selectedIndex: selectedIndex,
        onItemTapped: (index) => setState(() {
          selectedIndex = index;
        }),
      ),
      body: Column(
        children: [
          Expanded(
            child: details(),
          ),
        ],
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
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            const Row(
              children: [
                Text(
                  'Size',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  width: 26,
                ),
                AvailableSize(size: "1 pk"),
                AvailableSize(size: "2 pk"),
                AvailableSize(size: "3 pk"),
                AvailableSize(size: "4 pk"),
                AvailableSize(size: "5 pk"),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            const Row(
              children: [
                Text(
                  'Color',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: 18),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.blue,
                ),
                SizedBox(width: 8.0),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.red,
                ),
                SizedBox(width: 8.0),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.yellow,
                ),
                SizedBox(width: 8.0),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.green,
                ),
              ],
            ),
            //batchCategories(),
            const SizedBox(height: 12),
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
                  selectedSizeIndex = index;
                });
              },
              child: Container(
                width: 50,
                height: 30,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: selectedSizeIndex == index ? Colors.green : Colors.grey,
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      // onTap: () {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (_) => SafeArea(
                      //         child: Scaffold(
                      //           appBar: AppBar(
                      //             backgroundColor: Colors.white,
                      //           ),
                      //           body: Hero(
                      //             tag: widget.product.imgUrl!,
                      //             child: Image.network(
                      //               widget.product.imgUrl!,
                      //               fit: BoxFit.cover,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   );
                      // },
                      onTap: () => showImageDialog(widget.product.imgUrl!),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          widget.product.imgUrl!,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
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
                                  fontSize: 14,
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
                              removeFromCart(batch.id);
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
                          getCartQuantity(batch.id).toString(),
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                        ),
                        const SizedBox(width: 2),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              addToCart(widget.product, batch);
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
