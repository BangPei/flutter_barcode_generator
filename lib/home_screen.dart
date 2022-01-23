import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _dataCode;
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
                        sizes: 'col-12',
                        child: BarcodeWidget(
                          barcode: Barcode.code128(escapes: true),
                          data: _dataCode ?? "",
                          width: 400,
                          height: 160,
                        ),
                      ),
                    ],
                  ),
                ),
                BootstrapCol(
                  sizes: 'col-md-8',
                  child: const ContentWidget(
                    text: 'col 2 of 2',
                    color: Colors.red,
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

class ContentWidget extends StatelessWidget {
  const ContentWidget({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: color,
      child: Text(text),
    );
  }
}
