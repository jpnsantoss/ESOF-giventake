
Padding(
padding: const EdgeInsets.all(20.0),
child: ElevatedButton(
onPressed: () async {
String? userId = FirebaseAuth.instance.currentUser?.uid;
if (userId != null) {
Request request = await Request.createWithRequesterId(userId, product.id);
await requestRepo.addRequest(request);
} else {
print(
'Error: Couldn\'t get User ID. Ensure you are logged in.');
}
},
style: ElevatedButton.styleFrom(
backgroundColor: Colors.black,
foregroundColor: Colors.white,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(10),
),
),
child: const Text("Request Product"),
),