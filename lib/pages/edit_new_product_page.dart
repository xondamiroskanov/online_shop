import 'package:flutter/material.dart';
import 'package:online_shop/models/product_model.dart';
import 'package:online_shop/providers/products.dart';
import 'package:provider/provider.dart';

class EditNewAddProduct extends StatefulWidget {
  EditNewAddProduct({Key? key}) : super(key: key);
  static const routeName = "/ediNewAddProduct";

  @override
  State<EditNewAddProduct> createState() => _EditNewAddProductState();
}

class _EditNewAddProductState extends State<EditNewAddProduct> {
  final _formKey = GlobalKey<FormState>();
  final _formKeyImage = GlobalKey<FormState>();
  final activPriceField = FocusNode();
  final activeDescriptionField = FocusNode();
  var _product =
      ProductModel(name: "", price: "", description: "", image: "", id: "");

  var isImageUrl = true;
  var init = true;
  var isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (init) {
      final product = ModalRoute.of(context)!.settings.arguments;
      final products = Provider.of<Products>(context);
      print(product);
      if (product != null) {
        final id = products.productsList
            .firstWhere((element) => element.id == product);
        _product = id;
      }
    }
    init = false;
  }

  @override
  void dispose() {
    super.dispose();
    activPriceField.dispose();
    activeDescriptionField.dispose();
  }

  void _saveFormImage(context) {
    if (_formKeyImage.currentState!.validate()) {
      setState(() {});
      _formKeyImage.currentState!.save();
      Navigator.of(context).pop();
    }
  }

  Future<void> _saveForm() async {
    _formKey.currentState!.validate();
    setState(() {
      isImageUrl = _product.image.isNotEmpty;
    });
    if (_formKey.currentState!.validate() && isImageUrl) {
      _formKey.currentState!.save();
      setState(() {
        isLoading = true;
      });
      if (_product.id.isEmpty) {
        try {
          await Provider.of<Products>(context, listen: false)
              .addProduct(_product);
        } catch (error) {
          await showDialog<Null>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Xatolik"),
                  content:
                      const Text("Mahsulot qo'shishda xatolik sodir bo'ldi"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("OK"),
                    ),
                  ],
                );
              });
        } finally {
          setState(() {
            isLoading = false;
          });
          Navigator.of(context).pop();
        }
      } else {
        try {
          await Provider.of<Products>(context, listen: false)
              .updateProduct(_product);
        } catch (error) {
          await showDialog<Null>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Xatolik"),
                  content:
                      const Text("Mahsulotni tahrirlashda xatolik yuz berdi"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("OK"),
                    ),
                  ],
                );
              });
        }
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pop();
      }
    }
  }

  void showImageUrl(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Rasm urli"),
            content: Form(
              key: _formKeyImage,
              child: TextFormField(
                initialValue: _product.image,
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                    hintText: "Rasm urlini kiriting",
                    border: OutlineInputBorder()),
                onSaved: (newValue) {
                  _product = ProductModel(
                      name: _product.name,
                      price: _product.price,
                      description: _product.description,
                      image: newValue!,
                      id: _product.id,
                      isFavorite: _product.isFavorite);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Rasm urlini kiriting";
                  } else if (!value.startsWith("http")) {
                    return "Rasm urli xato";
                  }
                },
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Bekor qilish',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  )),
              TextButton(
                onPressed: () {
                  _saveFormImage(context);
                },
                child: const Text(
                  "Kiritish",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              _saveForm();
            },
            child: const Text(
              "Saqlash",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
          )
        ],
        title: const Text(
          "Mahsulot qo'shish",
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(14),
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: _product.name,
                          decoration: const InputDecoration(
                            labelText: "Mahsulot nomi",
                            border: OutlineInputBorder(),
                          ),
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(activPriceField);
                          },
                          onSaved: (newValue) {
                            _product = ProductModel(
                                isFavorite: _product.isFavorite,
                                name: newValue!,
                                price: _product.price,
                                description: _product.description,
                                image: _product.image,
                                id: _product.id);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Mahsulot nomini kiriting";
                            }
                          },
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        TextFormField(
                          initialValue: _product.price,
                          decoration: const InputDecoration(
                            labelText: "Mahsulot narxi",
                            border: OutlineInputBorder(),
                          ),
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(activeDescriptionField);
                          },
                          keyboardType: TextInputType.number,
                          focusNode: activPriceField,
                          onSaved: (newValue) {
                            _product = ProductModel(
                                isFavorite: _product.isFavorite,
                                name: _product.name,
                                price: newValue!,
                                description: _product.description,
                                image: _product.image,
                                id: _product.id);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Mahsulot narxini kiriting";
                            } else if (double.tryParse(value) == null) {
                              return "Mahsulot narxi xato kiritildi";
                            } else if (double.parse(value) < 0) {
                              return "Mahsulot narxi manfiy bo'lishi mumkin emas";
                            }
                          },
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        TextFormField(
                          initialValue: _product.description,
                          maxLines: 5,
                          decoration: const InputDecoration(
                            hintText: "Mahsulot haqida",
                            border: OutlineInputBorder(),
                          ),
                          focusNode: activeDescriptionField,
                          onSaved: (newValue) {
                            _product = ProductModel(
                                isFavorite: _product.isFavorite,
                                name: _product.name,
                                price: _product.price,
                                description: newValue!,
                                image: _product.image,
                                id: _product.id);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Mahsulot haqida ma'lumot kiriting";
                            } else if (value.length < 10) {
                              return "Mahsulot haqida to'liqroq ma'lumot kiriting";
                            }
                          },
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        InkWell(
                          focusColor: Colors.teal,
                          splashColor:
                              Theme.of(context).primaryColor.withOpacity(0.2),
                          onTap: () {
                            showImageUrl(context);
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: isImageUrl
                                        ? Colors.grey
                                        : Theme.of(context).errorColor),
                                borderRadius: BorderRadius.circular(6)),
                            child: Container(
                              decoration: BoxDecoration(),
                              height: 200,
                              width: double.infinity,
                              child: _product.image.isEmpty
                                  ? Center(
                                      child: Text(
                                        "Rasm urli",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: isImageUrl
                                                ? Colors.black45
                                                : Theme.of(context).errorColor),
                                      ),
                                    )
                                  : Image.network(
                                      _product.image,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
    );
  }
}
