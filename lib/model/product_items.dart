import 'package:online_sale_client/models/models.dart';
// class Inventory {
//   Product({
//     required this.id,
//     required this.image,
//     required this.name,
//     required this.price,
//     this.isFavorite = false,
//   });
//   String id;
//   String image;
//   String name;
//   double price;
//   bool isFavorite;
// }

final data = {
  "edges": [
    {
      "node": {
        "id": 1,
        "imgUrl":
            "https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=70,metadata=none,w=900/app/assets/products/sliding_images/jpeg/6f9d838a-7a49-4311-93f5-becad952b99f.jpg?ts=1709716796",
        "inventoryBatches": {
          "edges": [
            {
              "node": {"batchNo": null, "id": 1, "mrp": 200, "rate": 200, "disc": 0}
            },
            {
              "node": {"batchNo": null, "id": 3, "mrp": 200, "rate": 200, "disc": 0}
            },
            {
              "node": {"batchNo": null, "id": 4, "mrp": 300, "rate": 250, "disc": 17}
            }
          ]
        },
        "name": "India Gate Rice 1kg"
      }
    },
    {
      "node": {
        "id": 2,
        "imgUrl": "https://www.freedomcart.com/image/cache/data/Products/Daily%20needs/lays-green-chips-700x700.jpg",
        "inventoryBatches": {
          "edges": [
            {
              "node": {"batchNo": null, "id": 3, "mrp": 10, "rate": 10, "disc": 0}
            }
          ]
        },
        "name": "Lays"
      }
    },
    {
      "node": {
        "id": 3,
        "imgUrl": "https://m.media-amazon.com/images/I/71Nux-F+pfL.jpg",
        "inventoryBatches": {
          "edges": [
            {
              "node": {"batchNo": null, "id": 3, "mrp": 25, "rate": 20, "disc": 20}
            },
            {
              "node": {"batchNo": null, "id": 4, "mrp": 30, "rate": 25, "disc": 17}
            }
          ]
        },
        "name": "Chilly Powder 50gm"
      }
    },
    {
      "node": {
        "id": 4,
        "imgUrl":
            "https://www.jiomart.com/images/product/original/491696131/junior-horlicks-vanilla-500-g-product-images-o491696131-p590801195-0-202306091436.jpg?im=Resize=(1000,1000)",
        "inventoryBatches": {
          "edges": [
            {
              "node": {"batchNo": null, "id": 3, "mrp": 2500, "rate": 2450, "disc": 2}
            },
            {
              "node": {"batchNo": null, "id": 4, "mrp": 3000, "rate": 2900, "disc": 3}
            }
          ]
        },
        "name": "Horlicks"
      }
    },
    {
      "node": {
        "id": 5,
        "imgUrl": "https://www.kindpng.com/picc/m/40-409385_transparent-background-water-bottle-png-png-download.png",
        "inventoryBatches": {
          "edges": [
            {
              "node": {"batchNo": null, "id": 3, "mrp": 10, "rate": 10, "disc": 0}
            },
            {
              "node": {"batchNo": null, "id": 4, "mrp": 12, "rate": 10, "disc": 17}
            }
          ]
        },
        "name": "Water Bottle"
      }
    },
    {
      "node": {
        "id": 6,
        "imgUrl": "https://sc04.alicdn.com/kf/HTB1XMaDbx2rK1RkSnhJq6ykdpXaX.jpg",
        "inventoryBatches": {
          "edges": [
            {
              "node": {"batchNo": null, "id": 3, "mrp": 32, "rate": 30, "disc": 6}
            },
            {
              "node": {"batchNo": null, "id": 4, "mrp": 30, "rate": 30, "disc": 0}
            }
          ]
        },
        "name": "Tomato 1kg"
      }
    },
    {
      "node": {
        "id": 7,
        "imgUrl":
            "https://tootoo.in/media/catalog/product/cache/e77e25b80557b9123426bcb4a98fce67/c/a/cadbury_oreo_vanilla_sandwich_biscuit_43.75g_1.jpg",
        "inventoryBatches": {
          "edges": [
            {
              "node": {"batchNo": null, "id": 5, "mrp": 25, "rate": 25, "disc": 0}
            },
          ]
        },
        "name": "Oreo Vanilla Biscuit"
      }
    },
    {
      "node": {
        "id": 8,
        "imgUrl":
            "https://tiimg.tistatic.com/fp/1/007/529/delicious-elaichi-sweet-taste-square-shaped-bakery-biscuit-packaging-type-packet-036.jpg",
        "inventoryBatches": {
          "edges": [
            {
              "node": {"batchNo": null, "id": 3, "mrp": 66, "rate": 65, "disc": 2}
            }
          ]
        },
        "name": "Bakery Biscuit"
      }
    },
    {
      "node": {
        "id": 9,
        "imgUrl":
            "https://www.quickpantry.in/cdn/shop/products/cadbury-dairy-milk-silk-chocolate-bar-60-g-quick-pantry_500x500.jpg?v=1710538483",
        "inventoryBatches": {
          "edges": [
            {
              "node": {"batchNo": null, "id": 5, "mrp": 40, "rate": 40, "disc": 0}
            }
          ]
        },
        "name": "Diary Milk"
      }
    },
    {
      "node": {
        "id": 10,
        "imgUrl":
            "https://cdn.shopify.com/s/files/1/0523/9934/1736/products/40029538-2_5-kissan-fresh-tomato-ketchup.jpg?v=1634196076",
        "inventoryBatches": {
          "edges": [
            {
              "node": {"batchNo": null, "id": 3, "mrp": 59, "rate": 56, "disc": 5}
            },
          ]
        },
        "name": "Tomato Ketchup"
      }
    },
    {
      "node": {
        "id": 11,
        "imgUrl": "https://www.justgotochef.com/uploads/1567245299-SHRESHTA-%20Channa%20DAL-Front.jpg",
        "inventoryBatches": {
          "edges": [
            {
              "node": {"batchNo": null, "id": 2, "mrp": 122, "rate": 120, "disc": 2}
            },
            {
              "node": {"batchNo": null, "id": 1, "mrp": 140, "rate": 135, "disc": 4}
            }
          ]
        },
        "name": "Peas Dhal 1kg"
      }
    },
    {
      "node": {
        "id": 12,
        "imgUrl": "https://5.imimg.com/data5/RT/VR/MY-54892633/onion-packing-net-500x500.jpg",
        "inventoryBatches": {
          "edges": [
            {
              "node": {"batchNo": null, "id": 3, "mrp": 30, "rate": 25, "disc": 17}
            },
            {
              "node": {"batchNo": null, "id": 4, "mrp": 45, "rate": 42, "disc": 7}
            }
          ]
        },
        "name": "Onion 1kg"
      }
    },
    {
      "node": {
        "id": 13,
        "imgUrl": "https://sabkooch.com/wp-content/uploads/2020/10/moong-dal-500x500-1.jpg",
        "inventoryBatches": {
          "edges": [
            {
              "node": {"batchNo": null, "id": 2, "mrp": 134, "rate": 130, "disc": 3}
            },
            {
              "node": {"batchNo": null, "id": 4, "mrp": 132, "rate": 130, "disc": 2}
            }
          ]
        },
        "name": "Moong Dal 1kg"
      }
    },
    {
      "node": {
        "id": 14,
        "imgUrl":
            "https://cdn01.pharmeasy.in/dam/products_otc/L60170/lizol-citrus-disinfectant-floor-cleaner-liquid-bottle-of-500-ml-2-1670493036.jpg",
        "inventoryBatches": {
          "edges": [
            {
              "node": {"batchNo": null, "id": 3, "mrp": 30, "rate": 30, "disc": 0}
            },
            {
              "node": {"batchNo": null, "id": 4, "mrp": 30, "rate": 28, "disc": 7}
            }
          ]
        },
        "name": "Lizol"
      }
    },
    {
      "node": {
        "id": 15,
        "imgUrl": "https://ds-cdn.dubaistore.com/static/images/site-4063/img_303204254263748815_6291007905311_1_L.jpg",
        "inventoryBatches": {
          "edges": [
            {
              "node": {"batchNo": null, "id": 3, "mrp": 25, "rate": 24, "disc": 4}
            }
          ]
        },
        "name": "Bourbon Biscuit"
      }
    },
    {
      "node": {
        "id": 16,
        "imgUrl":
            "https://www.jiomart.com/images/product/original/rvpcpawply/pink-delight-unpolished-lal-masoor-daal-masoor-split-lal-daal-1kg-pack-product-images-orvpcpawply-p594202243-0-202311181841.jpg?im=Resize=(420,420)",
        "inventoryBatches": {
          "edges": [
            {
              "node": {"batchNo": null, "id": 2, "mrp": 56, "rate": 55, "disc": 2}
            },
            {
              "node": {"batchNo": null, "id": 4, "mrp": 60, "rate": 58, "disc": 3}
            }
          ]
        },
        "name": "Masoor Dal"
      }
    },
    {
      "node": {
        "id": 17,
        "imgUrl": "https://5.imimg.com/data5/SELLER/Default/2023/5/312052138/SP/PR/NN/13501844/008-500x500.jpg",
        "inventoryBatches": {
          "edges": [
            {
              "node": {"batchNo": null, "id": 5, "mrp": 499, "rate": 498, "disc": 0}
            }
          ]
        },
        "name": "Alovera Shampoo"
      }
    },
    {
      "node": {
        "id": 18,
        "imgUrl":
            "https://media.licdn.com/dms/image/C5612AQFJ-7ScHerOvw/article-cover_image-shrink_720_1280/0/1617076585403?e=2147483647&v=beta&t=9eIB04zpt0gT1Widr-TRKwKemcJkQ7F9DQSot7U_kh8",
        "inventoryBatches": {
          "edges": [
            {
              "node": {"batchNo": null, "id": 2, "mrp": 50, "rate": 49, "disc": 2}
            }
          ]
        },
        "name": "Species"
      }
    },
  ]
};
final dummyProduct = ListResponse<Inventory>.fromJson(data, (dynamic x) => Inventory.fromJson(Map.from(x)));
