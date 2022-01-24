import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _dataCode = "1234567890";
  final int _dataCount = 0;
  final List<Widget> _barcodeWidget = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Barcode Generator"),
      ),
      body: SingleChildScrollView(
        child: BootstrapContainer(
          padding: const EdgeInsets.only(top: 20),
          children: [
            BootstrapRow(
              children: [
                BootstrapCol(
                  sizes: 'col-md-4 col-sm-12',
                  child: BootstrapRow(
                    children: [
                      BootstrapCol(
                        sizes: 'col-12',
                        child: TextFormField(
                          decoration: const InputDecoration(
                            label: Text("Barcode Text"),
                            hintText: "Barcode Text",
                          ),
                          onChanged: (val) {
                            setState(() {
                              _dataCode = val;
                            });
                          },
                        ),
                      ),
                      BootstrapCol(
                        sizes: 'col-12',
                        child: const SizedBox(height: 20),
                      ),
                      BootstrapCol(
                        child: BootstrapRow(
                          children: [
                            BootstrapCol(
                              sizes: 'col-6 col-sm-6',
                              child: const Text("Copy : "),
                            ),
                            BootstrapCol(
                              sizes: 'col-6 col-sm-6',
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                BootstrapCol(
                  sizes: 'col-md-8 col-sm-12',
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        crossAxisCount: 5,
                        childAspectRatio: 1.5,
                        crossAxisSpacing: 12,
                        children: _barcodeWidget.map((e) {
                          return BarcodeWidget(
                            barcode: Barcode.code128(escapes: true),
                            data: _dataCode ?? "",
                            width: 20,
                            height: 50,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
          fluid: true,
        ),
      ),
    );
  }
}
