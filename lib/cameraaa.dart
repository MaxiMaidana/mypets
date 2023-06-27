import 'dart:developer';
import 'dart:io';
import 'package:image/image.dart' as imglib;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:mypets/utils_camera.dart';
import 'package:path_provider/path_provider.dart';

import 'core/utils/image_compress.dart';

class Cameraaa extends StatefulWidget {
  const Cameraaa({super.key});

  @override
  State<Cameraaa> createState() => _CameraaaState();
}

class _CameraaaState extends State<Cameraaa> {
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  // List<Face>? facesLit;
  Size? size;
  FaceDetector? _faceDetector;
  CameraDescription? description;
  InputImage? inputImage;
  bool _canProcess = true;
  bool _isBusy = false;
  Color borderColor = Colors.white;
  bool takePhoto = false;
  List<XFile> fotosTomadas = [];

  Directory? tempDir;
  String? encoded;
  File? imageToSend;
  @override
  void initState() {
    super.initState();
    _initFace();
    _initializeCamera();
  }

  void _initFace() {
    _faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        enableContours: true,
        enableClassification: true,
        minFaceSize: 0.1,
      ),
    );
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _canProcess = false;
    _faceDetector!.close();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );
    _cameraController = CameraController(
      frontCamera,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21 // for Android
          : ImageFormatGroup.bgra8888, // for iOS
    );
    await _cameraController!.initialize();
    setState(() {
      _isCameraInitialized = true;
    });
    if (_isCameraInitialized) {
      _starStreamImage(frontCamera.sensorOrientation);
    }
  }

  void _starStreamImage(int sensorOrientation) {
    _cameraController!.startImageStream(
      (image) async {
        inputImage = inputImageFromCameraImage(sensorOrientation, image);
        if (inputImage != null) {
          await processImage(inputImage!, image, sensorOrientation);
        }
      },
    );
  }

  Future<void> processImage(
      InputImage inputImage, CameraImage image, int sensorOrientation) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    final faces = await _faceDetector!.processImage(inputImage);
    if (faces.isNotEmpty) {
      if (inputImage.metadata?.size != null &&
          inputImage.metadata?.rotation != null) {
        if (isFaceCentered(
            Size(image.width.toDouble(), image.height.toDouble()), faces)) {
          borderColor = Colors.orangeAccent;
          if (takePhoto) {
            try {
              _cameraController!.stopImageStream();

              XFile file = await _cameraController!.takePicture();
              takePhoto = false;
              _starStreamImage(sensorOrientation);

              takeFaceUser(file);
            } catch (e) {
              log(e.toString());
            }
          }
        } else {
          borderColor = Colors.white;
        }
      }
    } else {
      borderColor = Colors.white;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  bool isFaceCentered(Size screenSize, List<Face> faces) {
    if (faces.isNotEmpty) {
      final screenWidth = screenSize.width;
      final screenHeight = screenSize.height;

      final screenCenterX = screenWidth / 2;
      final screenCenterY = screenHeight / 2;

      final faceCenterX =
          faces.first.boundingBox.left + (faces.first.boundingBox.width / 2);
      final faceCenterY =
          faces.first.boundingBox.top + (faces.first.boundingBox.height / 2);

      // Establece un margen de tolerancia para determinar si el rostro está centrado
      final tolerance = 1; // Puedes ajustar el valor según tus necesidades

      return (faceCenterX >= screenCenterX - (screenWidth * tolerance) &&
          faceCenterX <= screenCenterX + (screenWidth * tolerance) &&
          faceCenterY >= screenCenterY - (screenHeight * tolerance) &&
          faceCenterY <= screenCenterY + (screenHeight * tolerance));
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: _isCameraInitialized
          ? Stack(
              children: [
                backgroundCamera(),
                camera(),
                FloatingActionButton(
                    onPressed: () => setState(() {
                          takePhoto = true;
                        }))
              ],
            )
          : loading(),
    );
  }

  Widget loading() => const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );

  Widget backgroundCamera() => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 90),
          child: Container(
            decoration: BoxDecoration(
              color: borderColor,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      );

  Widget camera() => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: CameraPreview(
              _cameraController!,
            ),
          ),
        ),
      );

  Future<void> takeFaceUser(XFile picture) async {
    fotosTomadas.add(picture);
    log('fotos tomadas = ${fotosTomadas.length}');
    File? otherfile =
        await ImageCompress.compressAndGetFile(File(picture.path), 'asdasdasd');

    imageToSend = otherfile;

    try {
      File? otherfile = await ImageCompress.compressAndGetFile(
          File(picture.path), 'asdasdasd');

      log(otherfile.toString());
    } catch (e) {
      log(e.toString());
    }
  }

  Uint8List convertUint8ListToPng(Uint8List data) {
    final image =
        imglib.Image.fromBytes(width: 320, height: 240, bytes: data.buffer);

    final pngBytes = imglib.encodePng(image);
    return Uint8List.fromList(pngBytes);
  }

  Uint8List convertNV21ToUint8List(CameraImage cameraImage) {
    final nv21Data = cameraImage.planes[0].bytes;
    final width = cameraImage.width;
    final height = cameraImage.height;

    final imageSize = width * height * 3 ~/ 2; // Tamaño de la imagen NV21

    final convertedData = Uint8List.fromList(nv21Data.sublist(0, imageSize));

    return convertedData;
  }

  Future<File> convertUint8ListToFile(Uint8List data, String filename) async {
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/$filename';

    final file = File(filePath);
    await file.writeAsBytes(data);

    return file;
  }

  Future<Uint8List?> convertImageToPng(CameraImage image) async {
    Uint8List? bytes;
    try {
      imglib.Image img;
      if (image.format.group == ImageFormatGroup.yuv420) {
        bytes = await convertYUV420toImageColor(image);
      } else if (image.format.group == ImageFormatGroup.bgra8888) {
        img = _convertBGRA8888(image);
        imglib.PngEncoder pngEncoder = imglib.PngEncoder();
        bytes = pngEncoder.encode(img);
      }
    } catch (e) {
      print(">>>>>>>>>>>> ERROR:" + e.toString());
    }
    return bytes;
    // return null;
  }

  Future<Uint8List?> convertYUV420toImageColor(CameraImage image) async {
    try {
      final int width = image.width;
      final int height = image.height;
      final int uvRowStride = image.planes[1].bytesPerRow;
      final int uvPixelStride = image.planes[1].bytesPerPixel!;
      // print("uvRowStride: " + uvRowStride.toString());
      // print("uvPixelStride: " + uvPixelStride.toString());
      var img =
          imglib.Image(width: width, height: height); // Create Image buffer
      // Fill image buffer with plane[0] from YUV420_888
      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          final int uvIndex =
              uvPixelStride * (x / 2).floor() + uvRowStride * (y / 2).floor();
          final int index = y * width + x;
          final yp = image.planes[0].bytes[index];
          final up = image.planes[1].bytes[uvIndex];
          final vp = image.planes[2].bytes[uvIndex];
          int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
          int g = (yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91)
              .round()
              .clamp(0, 255);
          int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
          // img.data. = (0xFF << 24) | (b << 16) | (g << 8) | r;
        }
      }
      imglib.PngEncoder pngEncoder = imglib.PngEncoder(level: 0);
      Uint8List png = pngEncoder.encode(img);
      final originalImage = imglib.decodeImage(png);
      final height1 = originalImage!.height;
      final width1 = originalImage.width;
      imglib.Image? fixedImage;
      if (height1 < width1) {
        fixedImage = imglib.copyRotate(originalImage, angle: 270);
      }
      Directory asd = await getTemporaryDirectory();
      final path = asd.path + "${DateTime.now()}.jpg";
      // join((await getTemporaryDirectory()).path, "${DateTime.now()}.jpg");
      // print(path);
      File(path).writeAsBytesSync(imglib.encodeJpg(fixedImage!));
      return imglib.encodeJpg(fixedImage);
    } catch (e) {
      print(">>>>>>>>>>>> ERROR:" + e.toString());
    }
    return null;
  }

  imglib.Image _convertBGRA8888(CameraImage image) {
    return imglib.Image.fromBytes(
      width: image.width,
      height: image.height,
      bytes: image.planes[0].bytes.buffer,
      // format: imglib.Format.bgra,
    );
  }
}
