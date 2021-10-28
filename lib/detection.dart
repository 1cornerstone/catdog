

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class Detection extends StatefulWidget {
  const Detection({Key? key}) : super(key: key);

  @override
  _DetectionState createState() => _DetectionState();
}

class _DetectionState extends State<Detection> {


  String result ="";
  String path = "assets/file.jpeg";
  final ImagePicker _picker = ImagePicker();


  @override
  void initState(){
    super.initState();

     initTflite();

  }

  void initTflite()async{

    String? res = await Tflite.loadModel(
        model: "assets/model_unquant.tflite",
        labels: "assets/labels.txt",
        numThreads: 1, // defaults to 1
        isAsset: true, // defaults to true, set to false to load resources outside assets
        useGpuDelegate: false // defaults to false, set to true to use GPU delegate
    );

  }

  void runTest()async{

     List? reslt = await Tflite.runModelOnImage(
        path: path,   // required
        imageMean: 0.0,   // defaults to 117.0
        imageStd: 255.0,  // defaults to 1.0
        numResults: 1,    // defaults to 5
        threshold: 0.2,   // defaults to 0.1
        asynch: true      // defaults to true
    );

     setState((){
       result = reslt![0]['label'];

     });

  }

  void pickFile()async{

    XFile? file = await _picker.pickImage(source: ImageSource.gallery);

      if (file== null) return;
      setState((){
        path= file.path;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children:[

            InkWell(
              onTap:pickFile,
              child:Image(
                height: 150,
                width: 150,
                image: AssetImage(path),
              ),
            ),

            Text(
              result
            ),

            TextButton(
                onPressed:runTest,
                child: const Text(
                  "Process",
                  style: TextStyle(
                    color : Colors.white
                  ),
            ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)
              ),
            )



          ],
        ),
      )
    );
  }


}
