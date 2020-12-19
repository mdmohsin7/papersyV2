import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';

class PDFViewerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Papersy PDF Viewer"),
        centerTitle: true,
      ),
      body: PDFViewer(
        document: args,
        lazyLoad: false,
        enableSwipeNavigation: true,
        pickerButtonColor: Theme.of(context).primaryColor,
        scrollDirection: Axis.vertical,
      ),
    );
  }
}
