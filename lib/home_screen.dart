import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:typed_data';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _dataCode = "1234567890";
  int _dataCount = 1;
  Color _color = Colors.blue;
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
                                initialValue: _dataCount.toString(),
                                onChanged: (d) {
                                  if (d.isEmpty || d == "") {
                                    _dataCount = 1;
                                  } else if (d == "0") {
                                    _dataCount = 1;
                                  } else {
                                    _dataCount = int.parse(d);
                                  }
                                  setState(() {});
                                },
                                keyboardType: TextInputType.number,
                              ),
                            )
                          ],
                        ),
                      ),
                      BootstrapCol(
                        sizes: 'col-12',
                        child: const SizedBox(height: 20),
                      ),
                      BootstrapCol(
                        sizes: 'col-12',
                        child: BootstrapRow(
                          children: [
                            BootstrapCol(
                              child: Center(
                                child: TextButton(
                                  onHover: (isHover) {
                                    setState(() {
                                      _color = isHover
                                          ? Colors.blue[200]!
                                          : Colors.blue;
                                    });
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: _color,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.print,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "Print",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            child: PdfPreview(
                                              canChangePageFormat: false,
                                              canChangeOrientation: false,
                                              initialPageFormat:
                                                  PdfPageFormat.a4,
                                              canDebug: false,
                                              build: (format) =>
                                                  _generatePdf("Test"),
                                            ),
                                          );
                                        });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                        crossAxisCount: 6,
                        childAspectRatio: 1.5,
                        crossAxisSpacing: 12,
                        children: List.generate(_dataCount, (index) {
                          return BarcodeWidget(
                            barcode: Barcode.code128(escapes: true),
                            data: _dataCode ?? "",
                            width: 20,
                            height: 50,
                          );
                        }),
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

  Future<Uint8List> _generatePdf(String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.GridView(
            crossAxisCount: 6,
            childAspectRatio: 0.5,
            crossAxisSpacing: 10,
            children: List.generate(_dataCount, (index) {
              return pw.BarcodeWidget(
                barcode: Barcode.code128(escapes: false),
                data: _dataCode ?? "",
                width: 20,
                height: 50,
                textStyle: const pw.TextStyle(fontSize: 7),
              );
            }),
          );
        },
      ),
    );

    return pdf.save();
  }
}
