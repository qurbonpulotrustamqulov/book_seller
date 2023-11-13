import 'dart:async';

import 'package:book_seller/domain/bloc/book_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List mockImages = [
    "assest/images/islom_tarixi.jpg",
    "assest/images/iymon.jpg",
    "assest/images/kifoya.jpg",
    "assest/images/nubuvvat.jpg",
    "assest/images/ruhiy_tarbiya.jpg",
  ];
  TextEditingController controller = TextEditingController();
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  List checkResult = [];
  int total = 0;
  @override
  void initState() {
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    getAllBooks();
    super.initState();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
      getAllBooks();
    });
  }



  void getAllBooks() {
    BlocProvider.of<BookBloc>(context).add(const GetAllBookEvent());
  }



  @override
  Widget build(BuildContext context) {
    if(_connectionStatus.toString() =="ConnectivityResult.mobile"||
        _connectionStatus.toString() =="ConnectivityResult.wifi"||
        _connectionStatus.toString() =="ConnectivityResult.ethernet"||
        _connectionStatus.toString() =="ConnectivityResult.vpn"||
        _connectionStatus.toString() =="ConnectivityResult.bluetooth"||
        _connectionStatus.toString() =="ConnectivityResult.other" || checkResult.isNotEmpty){

      return Scaffold(
          body: BlocBuilder<BookBloc, BookState>(

            builder: (context, state) {
            checkResult= state.books;
              return Padding(
                  padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 55,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextField(
                            controller: controller,
                            style: const TextStyle(height: 0.8),
                            textAlignVertical: TextAlignVertical.center,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                                suffixIcon: Icon(Icons.search)),
                            onChanged: (value) {
                              BlocProvider.of<BookBloc>(context)
                                  .add(const CheckEvent());
                            },
                          ),
                        ),
                      ),
                      for (int i = 0; i < state.books.length; i++)
                        if (state.allBooks[i].name
                            .contains(controller.text.trim()))
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 130,
                                    width: 90,
                                    margin: const EdgeInsets.only(
                                        top: 12, bottom: 12),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(18),
                                      ),
                                    ),
                                    child: Image.asset(
                                      mockImages[i%mockImages.length],
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.allBooks[i].name,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Narxi: ${state.allBooks[i].price}",
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      ),
                                      Text(
                                        "Soni: ${state.books[i].book.count - state.books[i].quantity}",
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      ),
                                      state.allBooks[i].count > 0
                                          ? const Text(
                                        "Sotuvda mavjud",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.green,
                                            overflow: TextOverflow.fade),
                                      )
                                          : const Text(
                                        "Mavjud emas",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 18,
                                            overflow: TextOverflow.fade),
                                      ),
                                      const Text(
                                        "Kitob haqida",
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 100,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border:
                                      Border.all(color: Colors.greenAccent),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        InkWell(
                                          child: const SizedBox(
                                              height: 33,
                                              width: 45,
                                              child: Icon(Icons
                                                  .keyboard_arrow_up_outlined)),
                                          onTap: () {
                                            if (state.books[i].quantity <
                                                state.books[i].book.count &&
                                                state.books[i].book.count > 0) {
                                              BlocProvider.of<BookBloc>(context)
                                                  .add(AddQuantityEvent(
                                                  bookItem: state.books[i]));
                                              BlocProvider.of<BookBloc>(context)
                                                  .add(AddTotalEvent(
                                                  bookItem: state.books[i],
                                                  sum: state.books[i].book
                                                      .price as int));
                                              total+= state.books[i].book.price as int;
                                            }
                                          },
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8)),
                                          radius: 15,
                                        ),
                                        Text(
                                          state.books[i].quantity.toString(),
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        InkWell(
                                          child: const SizedBox(
                                              height: 33,
                                              width: 45,
                                              child: Icon(
                                                  Icons.keyboard_arrow_down)),
                                          onTap: () {
                                            if (state.books[i].quantity > 0) {
                                              BlocProvider.of<BookBloc>(context)
                                                  .add(RemoveQuantityEvent(
                                                  bookItem: state.books[i]));
                                              BlocProvider.of<BookBloc>(context)
                                                  .add(AddTotalEvent(
                                                  bookItem: state.books[i],
                                                  sum: state.books[i].book
                                                      .price as int));
                                              total-= state.books[i].book.price as int;
                                            }
                                          },
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8)),
                                          radius: 15,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const Divider()
                            ],
                          )
                    ],
                  )
              );
            },
          ), floatingActionButton: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                minimumSize: const Size(130, 45),
                backgroundColor: Colors.greenAccent),
            onPressed: () {},
            child: Text(
              "$total so'm",
              style: const TextStyle(fontSize: 16),
            ),
          );
        },
      ));

    }
    else{
      return Scaffold(
        body: Center(
          child: Lottie.asset("assest/lotties/loading.json"),
        ),
      );
    }
  }
  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
