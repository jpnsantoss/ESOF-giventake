import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';


class ProfileScreen extends StatefulWidget {
  final MyUserEntity user;
  const ProfileScreen({super.key,
    required this.user,
    });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin{
  late TabController tabController;
      @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 2.5,
                  
                  child: Column(
                    children: [
                      Text("Profile"),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: TabBar(
                          controller: tabController,
                          unselectedLabelColor: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.5),
                          labelColor:
                              Theme.of(context).colorScheme.onBackground,
                          tabs: const [
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                'Products',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                'Reviews',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: TabBarView(
                        controller: tabController,
                        children: [
                         Text("Products"),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              
                              Center(child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: widget.user.reviews.map((review) {
                                  return Container(
                                    
                                    margin: EdgeInsets.symmetric(vertical: 5.0),
                                    padding: EdgeInsets.all(20.0),
                                    width: 350,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5), // Cor da sombra
                                        spreadRadius: 3, // Raio de propagação da sombra
                                        blurRadius: 7, // Raio de desfoque da sombra
                                        offset: Offset(0, 3), // Deslocamento da sombra
                                      ),
                                    ],
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                     child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        
                                        Text('User ID: ${review['username']}'),
                                        SizedBox(height: 8), // Espaçamento entre as linhas
                                        Text('Review: ${review['review']}'),
                                      ],
                                    ),
                                  
                                    
                                  );
                                }).toList(),
                              ),
                              ),
                            ],
                          )
                              
                        ],
                      )
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}