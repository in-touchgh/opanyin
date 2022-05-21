import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weightapp/controls/provider.dart';
import 'package:weightapp/models/weight.dart';
import 'package:weightapp/service/firestore_service.dart';
import 'package:weightapp/views/edit_weight.dart';
import 'package:weightapp/views/signin.dart';
import 'package:weightapp/views/weights.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var services = FireStoreService();
  var open;

  await services.checkUser()?
  open = Weights():open = SignIn();
  runApp( MyApp(open));
}

class MyApp extends StatelessWidget {
  Widget open;
  MyApp(this.open);




  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    var services = FireStoreService();

    return MultiProvider(
      providers: [
        StreamProvider<List<Weight>>.value(value: services.getWeight(), initialData: [],),
        ChangeNotifierProvider<WeightProvider>(create: (context)=>WeightProvider(),
          child: Weights(),
        ),

      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
        title: 'Weight Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: open,
          routes: {
            EditOrAddWeight.routeArgs:(ctx)=>EditOrAddWeight(),
          }
      ),
    );
  }


}