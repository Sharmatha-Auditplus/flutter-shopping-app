class Product {
  Product({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    this.isFavorite = false,
  });
  String id;
  String image;
  String name;
  double price;
  bool isFavorite;
}

final dummyProduct = [
  Product(
      id: '1',
      image:
          'https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=70,metadata=none,w=900/app/assets/products/sliding_images/jpeg/6f9d838a-7a49-4311-93f5-becad952b99f.jpg?ts=1709716796',
      name: 'India Gate Rice 1kg',
      price: 217),
  Product(
      id: '2',
      image: 'https://www.freedomcart.com/image/cache/data/Products/Daily%20needs/lays-green-chips-700x700.jpg',
      name: 'Lays',
      price: 10),
  Product(
    id: '3',
    image: 'https://m.media-amazon.com/images/I/71Nux-F+pfL.jpg',
    name: 'Chilly Powder 50gm',
    price: 30,
  ),
  Product(
      id: '4',
      image:
          'https://www.jiomart.com/images/product/original/491696131/junior-horlicks-vanilla-500-g-product-images-o491696131-p590801195-0-202306091436.jpg?im=Resize=(1000,1000)',
      name: 'Horlicks',
      price: 516.6),
  Product(
      id: '5',
      image: 'https://www.kindpng.com/picc/m/40-409385_transparent-background-water-bottle-png-png-download.png',
      name: 'Water Bottle',
      price: 10.7),
  Product(
      id: '6', image: 'https://sc04.alicdn.com/kf/HTB1XMaDbx2rK1RkSnhJq6ykdpXaX.jpg', name: 'Tomato 1kg', price: 45),
  Product(
      id: '7',
      image:
          'https://tootoo.in/media/catalog/product/cache/e77e25b80557b9123426bcb4a98fce67/c/a/cadbury_oreo_vanilla_sandwich_biscuit_43.75g_1.jpg',
      name: 'Oreo Vanilla Biscuit',
      price: 20),
  Product(
      id: '8',
      image:
          'https://tiimg.tistatic.com/fp/1/007/529/delicious-elaichi-sweet-taste-square-shaped-bakery-biscuit-packaging-type-packet-036.jpg',
      name: 'Bakery Biscuit',
      price: 50),
  Product(
      id: '9',
      image:
          'https://www.quickpantry.in/cdn/shop/products/cadbury-dairy-milk-silk-chocolate-bar-60-g-quick-pantry_500x500.jpg?v=1710538483',
      name: 'Diary Milk',
      price: 80),
  Product(
      id: '10',
      image:
          'https://cdn.shopify.com/s/files/1/0523/9934/1736/products/40029538-2_5-kissan-fresh-tomato-ketchup.jpg?v=1634196076',
      name: 'Tomato Ketchup',
      price: 125.2),
  Product(
      id: '11',
      image: 'https://www.justgotochef.com/uploads/1567245299-SHRESHTA-%20Channa%20DAL-Front.jpg',
      name: 'Peas Dhal 1kg',
      price: 245),
  Product(
      id: '12',
      image: 'https://5.imimg.com/data5/RT/VR/MY-54892633/onion-packing-net-500x500.jpg',
      name: 'Onion 1kg',
      price: 99),
  Product(
      id: '13',
      image: 'https://sabkooch.com/wp-content/uploads/2020/10/moong-dal-500x500-1.jpg',
      name: 'Moong Dal 1kg',
      price: 150),
  Product(
      id: '14',
      image:
          'https://cdn01.pharmeasy.in/dam/products_otc/L60170/lizol-citrus-disinfectant-floor-cleaner-liquid-bottle-of-500-ml-2-1670493036.jpg',
      name: 'Lizol',
      price: 40.0),
  Product(
      id: '15',
      image: 'https://ds-cdn.dubaistore.com/static/images/site-4063/img_303204254263748815_6291007905311_1_L.jpg',
      name: 'Bourbon Biscuit',
      price: 25,
      isFavorite: true),
  Product(
      id: '16',
      image:
          'https://www.jiomart.com/images/product/original/rvpcpawply/pink-delight-unpolished-lal-masoor-daal-masoor-split-lal-daal-1kg-pack-product-images-orvpcpawply-p594202243-0-202311181841.jpg?im=Resize=(420,420)',
      name: 'Masoor Dal',
      price: 70),
  Product(
      id: '17',
      image: 'https://5.imimg.com/data5/SELLER/Default/2023/5/312052138/SP/PR/NN/13501844/008-500x500.jpg',
      name: 'Alovera Shampoo',
      price: 379.5),
  Product(
      id: '18',
      image:
          'https://media.licdn.com/dms/image/C5612AQFJ-7ScHerOvw/article-cover_image-shrink_720_1280/0/1617076585403?e=2147483647&v=beta&t=9eIB04zpt0gT1Widr-TRKwKemcJkQ7F9DQSot7U_kh8',
      name: 'Species',
      price: 65),
];
