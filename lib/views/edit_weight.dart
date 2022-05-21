import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weightapp/models/weight.dart';

import '../controls/provider.dart';

class EditOrAddWeight extends StatefulWidget {
  static const routeArgs = '/add-edit-screen';

  @override
  _EditOrAddWeightState createState() => _EditOrAddWeightState();
}

class _EditOrAddWeightState extends State<EditOrAddWeight> {
  final _formKey = GlobalKey<FormState>();
  final weightController = TextEditingController();
  var routeData;

  void clearData() {
    weightController.text = '';
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if(ModalRoute.of(context)?.settings.arguments!=null){
        setState(() {
          routeData =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
        });
      }
    }).then((_) => routeData == null
        ? Future.delayed(Duration.zero, () {
      clearData();
      final weightProvider =
      Provider.of<WeightProvider>(context, listen: false);
    })
        : Future.delayed(Duration.zero, () {

          setState(() {
            try {
              weightController.text = routeData['weight'].toString();} catch (e, s) {
              print(s);
            }
          });

      final weightProvider =
      Provider.of<WeightProvider>(context, listen: false);
      Weight w = Weight(
        weight: routeData['weight'],
        id: routeData['id'],
        timestamp:routeData['timestamp'],
      );
      weightProvider.loadValues(w);
    }));
  }

  @override
  void dispose() {
    super.dispose();
    weightController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weightProvider = Provider.of<WeightProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add or Edit Product'),
      ),
      body: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Name';
                        }
                        return null;
                      },
                      controller: weightController,
                      decoration: InputDecoration(
                        hintText: 'Enter Weight',
                      ),
                      onChanged: (val) => weightProvider.changeWeight(val),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(

                      child: routeData!=null?Text('Update Weight'):Text("Save Weight"),

                      onPressed: () {
                        if(_formKey.currentState!.validate())
                        {
                          weightProvider.saveData();
                          Navigator.of(context).pop();
                        }
                      },
                      color: Colors.blue,
                      textColor: Colors.white,
                    ),

                    SizedBox(height: 10,),

                    routeData!=null?
                    RaisedButton(
                      child: Text('Delete'),
                      onPressed: () {
                        weightProvider.removeData(routeData['id']);
                        Navigator.of(context).pop();
                      },
                      color: Colors.red,
                      textColor: Colors.white,
                    ):Container()
                  ],
                ),
              ),
            ),
          )),
    );
  }
}