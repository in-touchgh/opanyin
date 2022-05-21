
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weightapp/service/firestore_service.dart';
import 'package:weightapp/views/edit_weight.dart';

import '../models/weight.dart';

class Weights extends StatelessWidget {
  const Weights({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weightList = Provider.of<List<Weight>>(context);
    final service = FireStoreService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weights'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(EditOrAddWeight.routeArgs);
            },
          ),
        ],
      ),
      body: weightList != null
          ?
      weightList.isNotEmpty?
      ListView.builder(
                itemCount: weightList.length,
                itemBuilder: (ctx, i) => FlatButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(EditOrAddWeight.routeArgs, arguments: {
                    'id': weightList[i].id,
                    'weight': weightList[i].weight,
                    'timestamp': weightList[i].timestamp,
                  }),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("weight: ${weightList[i].weight} kg"),
                      Text("date:${( weightList[i].timestamp.toDate())}")
                    ],
                  ),
                ),
              ):Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children:  [
            Expanded(child: Container()),
            const Text("You have no weight list at the moment. Please add", textAlign: TextAlign.center,),
            const SizedBox(height: 10,),
            Expanded(child: Container()),

          ],
        ),
      )
          : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
