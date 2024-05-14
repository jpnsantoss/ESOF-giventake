import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giventake/screens/home/blocs/get_product_bloc/get_product_bloc.dart';
import 'package:giventake/screens/home/views/details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Atualiza a lista de produtos sempre que a tela for exibida
    context.read<GetProductBloc>().add(GetProduct());
  }

  @override
  Widget build(BuildContext context) {
    // final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    // String photoURL = authBloc.state.user?.photoURL ?? 'default_url';
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'GiveNTake',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Handle envelope icon tap
            },
            icon: const Icon(Icons.mail_outline), // Envelope symbol icon
          ),
          IconButton(
            onPressed: () {
              // Handle profile icon tap
            },
            icon: const CircleAvatar(
              radius: 15,
              // backgroundImage: NetworkImage(
              //   photoURL,
              // ), // Circle with profile image icon
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Give things\nanother chance",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 20), // give it some space
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        context
                            .read<GetProductBloc>()
                            .add(SearchProduct(value));
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(CupertinoIcons.search),
                        hintText: 'Search Items..',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10), // give it some space
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: () {
                      // Handle add button tap
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: BlocBuilder<GetProductBloc, GetProductState>(
                builder: (context, state) {
                  if (state is GetProductSuccess) {
                    return ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(state.products[index].title),
                          subtitle: Text(state.products[index].description),
                          //leading: Image.network(state.products[index].image),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    DetailsScreen(
                                        product: state.products[index]),
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else if (state is GetProductProcess) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return const Center(
                      child: Text("An error has occured..."),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
