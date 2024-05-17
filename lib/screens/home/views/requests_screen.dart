import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:product_repository/product_repository.dart';
import 'package:request_repository/request_repository.dart';
import 'package:user_repository/user_repository.dart';


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
  late List<MyUser> requestUsers = [];
  late List<Product> requestProducts = [];
  late int nrequests = 0;
  bool isLoadingRequests = true;

  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    fetchUnansweredRequests();
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
                    if (isLoadingRequests)
                      const CircularProgressIndicator()
                    else if (requests.isEmpty)
                      const SizedBox(height: 24)
                    else
                      SizedBox(
                        width: 345,
                        child: Text(
                          '${nrequests} new product requests',
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
                    ...buildRequestWidgets(),
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
                      image: NetworkImage(requestUsers[i].image),
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
                          text: requestUsers[i].name,
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
                image: NetworkImage(requestProducts[i].image),
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
                      image: NetworkImage(requestUsers[i].image),
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
                          text: requestUsers[i].name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                          ),
                        ),
                        TextSpan(
                          text: '${ans ? 'accepted ' : 'declined '} your request.',
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
                image: NetworkImage(requestProducts[i].image),
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
                                      image: NetworkImage(requestUsers[i].image),
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
                                        requestUsers[i].name,
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
                                        '2 days ago',
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
                                        requestUsers[i].rating.toString(),
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
                                Text(
                                  '${requestUsers[i].reviews
                                      .length} reviews',
                                  style: TextStyle(
                                    color: Color(0xFF818181),
                                    fontSize: 13.86,
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
                                  requestProducts[i].title,
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
                                image: NetworkImage(requestProducts[i].image),
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
                                // Remove the rejected request from the list
                                setState(() {requests.removeAt(i);});
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
                                  requests.removeAt(i);
                                  youDid(i, requests[i].accepted!);
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

List<Widget> buildRequestWidgets(){
    List<Widget> widgets = [];
    for (int i = 0; i < requests.length; i++) {
      widgets.add(const SizedBox(height: 24));
      if (requests[i].accepted == null) {
          widgets.add(unacceptedWidget(i));
        } else {
          bool ans = requests[i].accepted!;
          widgets.add(youDid(i, ans));
        }
    }
    return widgets;
}
  /* EXTRACT TO REQUEST LOGIC */
  Future<void> fetchUnansweredRequests() async {
    try {
      ProductRepo productRepo = FirebaseProductRepo();
      List<Product> productss = await productRepo.getProducts();
      RequestRepo requestRepo = FirebaseRequestRepo();
      List<Request> requestss = await requestRepo.getRequests();

      for (Product p in productss) {
        if (p.userId != FirebaseAuth.instance.currentUser?.uid) {
          continue;
        } else {
          for (Request r in requestss) {
            if (p.id == r.productId) {
              requests.insert(0, r);
              if(r.accepted==null) {
                nrequests++;
              }
            }
          }
        }
      }
        await fillRequestInfo(); // Await the completion of fillRequestInfo()
    } catch (error) {
        print("Error fetching requests: $error");
    } finally {
      setState(() {
        isLoadingRequests = false;
      });
    }
  }

  Future<MyUser> getRequesterInfo(Request r) async {
    try {
      String uid = r.fromUserId;
      MyUser user = await FirebaseUserRepo().getUser(uid);
      return user;
    } catch (error) {
      rethrow;
    }
  }

  Future<Product> getProductInfo(Request r) async {
    try {
      String pid = r.productId;
      Product p = await FirebaseProductRepo().getProduct(pid);
      return p;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fillRequestInfo() async {
    try {
      for (Request r in requests) {
        requestUsers.add(await getRequesterInfo(r));
        requestProducts.add(await getProductInfo(r));
      }
    } catch (error) {
      print("Error filling request info: $error");
    }
  }

/* -----------------ENDS HERE----------------- */

}
