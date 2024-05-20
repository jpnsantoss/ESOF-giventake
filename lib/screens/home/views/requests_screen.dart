import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giventake/screens/profile/blocs/get_reviews/get_reviews_bloc.dart';
import 'package:product_repository/product_repository.dart';
import 'package:request_repository/request_repository.dart';
import 'package:review_repository/review_repository.dart';
import 'package:user_repository/user_repository.dart';

class Pair<T, U> {
  final T first;
  final U second;

  Pair(this.first, this.second);
}

class RequestsScreen extends StatefulWidget {

  final String userId;
  final MyUserEntity user;

  const RequestsScreen({super.key, required this.userId, required this.user});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();

}

class _RequestsScreenState extends State<RequestsScreen> {

  late String userId;

  late List<Request> requests = [];
  late List<MyUser> requestsUsers = [];
  late List<Product> requestsProducts = [];

  late List<Widget> myWidgets = [];
  late int requestsToAnswer = 0;
  bool isLoadingrequestsRequests = true;


  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    buildRequestWidgets();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 393,
        height: 852,
        padding: const EdgeInsets.only(left: 24, right: 19),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: const Color(0xFFF7F7F7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 345,
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: const FlutterLogo(),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    if (isLoadingrequestsRequests)
                      Center(
                        child: const CircularProgressIndicator(),
                      )
                    else if (requests.isEmpty)
                      SizedBox(
                        width: 345,
                        child: Text(
                          'You have no product requests',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Color(0xFF6C8A47),
                            fontSize: 24,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      )
                    else
                      SizedBox(
                        width: 345,
                        child: Text(
                          '${requestsToAnswer} new product requests',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Color(0xFF6C8A47),
                            fontSize: 24,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                      ...myWidgets,
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  void dispose(){
    super.dispose();
  }

  Widget youDid(int i, bool ans) {
    return Container(
      width: 350,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage(requestsUsers[i].image),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 229,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'You ${ans ? 'accepted ' : 'declined '}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                          ),
                        ),
                        TextSpan(
                          text: requestsUsers[i].name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                          ),
                        ),
                        TextSpan(
                          text: '’s',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                          ),
                        ),
                        TextSpan(
                          text: ' request.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w300,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 42,
            height: 42,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: NetworkImage(requestsProducts[i].image),
                fit: BoxFit.fill,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget someoneDid(int i, bool ans) {
    return Container(
      width: 350,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage(requestsUsers[i].image),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 229,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: requestsUsers[i].name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                          ),
                        ),
                        TextSpan(
                          text: '${ans ? ' accepted ' : ' declined '} your request.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 42,
            height: 42,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: NetworkImage(requestsProducts[i].image),
                fit: BoxFit.fill,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget unacceptedWidget(int i) {
    return
        Container(
          padding: const EdgeInsets.all(20.79),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 0.87, color: Color(0xFFECEAEB)),
              borderRadius: BorderRadius.circular(8.66),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x26000000),
                blurRadius: 8,
                offset: Offset(0, 6),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 308.42,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment
                                  .start,
                              crossAxisAlignment: CrossAxisAlignment
                                  .center,
                              children: [
                                Container(
                                  width: 55.45,
                                  height: 55.45,
                                  decoration: ShapeDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(requestsUsers[i].image),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius
                                          .circular(86.63),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 17.33),
                                Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment
                                        .center,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        requestsUsers[i].name,
                                        style: TextStyle(
                                          color: Color(0xFF212121),
                                          fontSize: 17.33,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                          height: 0,
                                        ),
                                      ),
                                      const SizedBox(height: 3.47),
                                      Text(
                                        DateTime.now().difference(requests[i].created_at.toDate()).inDays == 0 ? 'Today' : '${DateTime.now().difference(requests[i].created_at.toDate()).inDays} day(s) ago',
                                        style: TextStyle(
                                          color: Color(0xFF818181),
                                          fontSize: 10.40,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 60.44),
                          Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment
                                  .start,
                              crossAxisAlignment: CrossAxisAlignment
                                  .end,
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment
                                        .start,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [
                                      Container(
                                        width: 17.33,
                                        height: 17.33,
                                        child: FlutterLogo(),
                                      ),
                                      const SizedBox(width: 3.47),
                                      Text(
                                        requestsUsers[i].rating.toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13.86,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 1.73),
                                BlocProvider(
                                                create: (context) =>
                                                    GetReviewsBloc(
                                                  FirebaseReviewRepo(),
                                                  FirebaseUserRepo(),
                                                )..add(GetReviewsCount(
                                                        widget.user.userId)),
                                                child: BlocBuilder<
                                                    GetReviewsBloc,
                                                    GetReviewsState>(
                                                  builder: (context, state) {
                                                    if (state
                                                        is GetReviewsCountProcess) {
                                                      return Text(
                                                        'Loading...',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF818181),
                                                          fontSize: 13.39,
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 0,
                                                        ),
                                                      );
                                                    } else if (state
                                                        is GetReviewsCountSuccess) {
                                                      return Text(
                                                        '${state.reviews} reviews',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF818181),
                                                          fontSize: 13.39,
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 0,
                                                        ),
                                                      );
                                                    } else if (state
                                                        is GetReviewsCountFailure) {
                                                      return Text(
                                                        'Error: Failed to load reviews',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF818181),
                                                          fontSize: 13.39,
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 0,
                                                        ),
                                                      );
                                                    }
                                                    return Container(); // or a default text
                                                  },
                                                ),
                                              ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.79),
                    Container(
                      width: 308.42,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment
                                  .start,
                              crossAxisAlignment: CrossAxisAlignment
                                  .start,
                              children: [
                                Text(
                                  'Product',
                                  style: TextStyle(
                                    color: Color(0xFF818181),
                                    fontSize: 13.86,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                    letterSpacing: 0.14,
                                  ),
                                ),
                                const SizedBox(height: 3.47),
                                Text(
                                  requestsProducts[i].title,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17.33,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                    letterSpacing: 0.17,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20.79),
                          Container(
                            width: 55.45,
                            height: 55.45,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: NetworkImage(requestsProducts[i].image),
                                fit: BoxFit.fill,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    8.66),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.79),
                    Container(
                      width: 308.42,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              try {
                                // Call rejectRequest function
                                await FirebaseRequestRepo().rejectRequest(requests[i].id);
                                setState(() {
                                  Widget w = youDid(i, false); //building the right widget
                                  myWidgets.removeAt(i*2 + 1);
                                  myWidgets.insert(i*2 + 1, w);
                                  requestsToAnswer--;
                                });

                              } catch (error) {
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Failed to reject request: $error")),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 41.58, vertical: 10.40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    8.66),
                              ),
                              backgroundColor: Color(0xFFECEAEB),
                            ),
                            child: Text(
                              'Decline',
                              style: TextStyle(
                                color: Color(0xFF818181),
                                fontSize: 17.33,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                height: 0,
                                letterSpacing: 0.17,
                              ),
                            ),
                          ),

                          SizedBox(width: 10.40),
                          ElevatedButton(
                            onPressed: () async {
                              try {
                                // Call acceptRequest function
                                await FirebaseRequestRepo().acceptRequest(requests[i].id);
                                setState(() {
                                  //this always happens
                                  Widget w = youDid(i, true); //building the right widget
                                  myWidgets.removeAt(i*2 + 1); //removing the index before :(
                                  myWidgets.insert(i*2 + 1, w);
                                  requestsToAnswer--;
                                });

                              } catch (error) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  SnackBar(
                                      content: Text("Failed to accept request: $error")),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 41.58, vertical: 10.40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    8.66),
                              ),
                              backgroundColor: Color(0xFF212121),
                            ),
                            child: Text(
                              'Accept',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17.33,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                height: 0,
                                letterSpacing: 0.17,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
}

  Future<void> buildRequestWidgets() async {
    await fetchUserRequests();
    List<Widget> tempWidgets = [];

    for (int i = 0; i < requests.length; i++) {
      tempWidgets.add(const SizedBox(height: 24));
      if (requests[i].accepted == null) {
        tempWidgets.add(unacceptedWidget(i));
      }else if(requests[i].fromUserId == userId){
        bool ans = requests[i].accepted!;
        tempWidgets.add(someoneDid(i, ans));
      }else{
        bool ans = requests[i].accepted!;
        tempWidgets.add(youDid(i, ans));
      }
    }
    setState(() {
      myWidgets = tempWidgets;
    });
  }


  Future<void> fetchUserRequests() async {
    try {
      ProductRepo productRepo = FirebaseProductRepo();
      List<Product> productss = await productRepo.getProducts();
      RequestRepo requestRepo = FirebaseRequestRepo();
      List<Request> requestss = await requestRepo.getRequests();

      for (Request r in requestss) {
        for (Product p in productss) {
          if (p.userId == userId && p.id == r.productId) {
              print("added request for mine");
              requests.add(r);
            if (r.accepted == null) requestsToAnswer++;
            break;
          }else if(((r.fromUserId == FirebaseAuth.instance.currentUser?.uid) && (p.id == r.productId) && (r.accepted != null))){
              print("added my request");
              requests.add(r);
              break;
          }
        }
      }
      await fillRequestInfo();
    } catch (error) {
        print("Error fetching requests: $error");
    } finally {
      setState(() {
        isLoadingrequestsRequests = false;
      });
    }
  }


  Future<Pair<MyUser, Product>>getUserNProductInfo(Request r) async {
    try {
      String pid = r.productId;
      Product p = await FirebaseProductRepo().getProduct(pid);
      MyUser usr;
      if(r.fromUserId != userId){  //pedido feito por outros aos meus produtos
        usr = await FirebaseUserRepo().getUser(r.fromUserId); // o tipo que me pediu
      }else{              //pedido feito por mim aos outros
        usr = await FirebaseUserRepo().getUser(p.userId);  // a pessoa de quem era o produto que pedi?
      }
      return Pair(usr, p);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fillRequestInfo() async {
    try {
      for (Request r in requests) {
          Pair<MyUser, Product> p = await getUserNProductInfo(r);
          requestsUsers.add(await p.first);
          requestsProducts.add(await p.second);
      }
    } catch (error) {
         print("Error filling request info: $error");
    }
  }


}
