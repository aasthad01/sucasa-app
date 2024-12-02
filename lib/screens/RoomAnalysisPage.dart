import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';

class RoomAnalysisPage extends StatefulWidget {
  final File imageFile;

  RoomAnalysisPage({required this.imageFile});
  @override
  _RoomAnalysisPageState createState() => _RoomAnalysisPageState();
}

class _RoomAnalysisPageState extends State<RoomAnalysisPage> {
  File? _image;
  String _mlResult = 'Processing...';
  final ImagePicker _picker = ImagePicker();

  // Function to pick image from gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _mlResult = 'Processing...';
        _analyzeRoom();
      } else {
        _mlResult = 'No image selected.';
      }
    });
  }

  // Function to analyze the selected image
  Future<void> _analyzeRoom() async {
    if (_image == null) return;

    final inputImage = InputImage.fromFilePath(_image!.path);

    // Set up the ObjectDetector with options
    final objectDetector = ObjectDetector(
      options: ObjectDetectorOptions(
        mode: DetectionMode.single,
        classifyObjects: true,
        multipleObjects: true,
      ),
    );

    try {
      // Detect objects in the image
      final detectedObjects = await objectDetector.processImage(inputImage);

      // Extracting layout information from detected objects
      final layout = detectedObjects.map((obj) {
        return {
          'label': obj.labels.isNotEmpty ? obj.labels[0].text : 'unknown',
          'boundingBox': obj.boundingBox,
        };
      }).toList();

      // Estimate room dimensions based on the detected objects
      final roomDimensions = _estimateRoomDimensions(detectedObjects);

      // Generate the API prompt for image generation
      final apiPrompt = _generateApiPrompt(roomDimensions, layout);

      setState(() {
        _mlResult = apiPrompt; // Display the generated API prompt
      });
    } catch (e) {
      setState(() {
        _mlResult = 'Error in room analysis: $e';
      });
    } finally {
      objectDetector.close();
    }
  }

  // Estimate room dimensions based on detected objects
  RoomDimensions _estimateRoomDimensions(List<DetectedObject> objects) {
    double estimatedWidth = 0.0;
    double estimatedLength = 0.0;
    double estimatedHeight = 0.0;

    if (objects.isNotEmpty) {
      final boundingBoxes = objects.map((obj) => obj.boundingBox).toList();

      estimatedWidth = boundingBoxes.map((box) => box.width).reduce(max);
      estimatedLength = boundingBoxes.map((box) => box.height).reduce(max);
      estimatedHeight = estimatedWidth * 2.5; // Approximate room height
    }

    return RoomDimensions(
      width: estimatedWidth,
      length: estimatedLength,
      height: estimatedHeight,
    );
  }

  // Generate the prompt for the image generation API
  String _generateApiPrompt(RoomDimensions roomDimensions, List<Map<String, dynamic>> layout) {
    String layoutDescription = layout.map((obj) {
      return "${obj['label']} at position (${obj['boundingBox'].left}, ${obj['boundingBox'].top}) with size (${obj['boundingBox'].width}, ${obj['boundingBox'].height})";
    }).join('\n');

    // Example style (can be dynamic or user-defined)
    String roomStyle = 'Modern';

    // Construct the API prompt
    return '''
      Generate an interior design image for a room with the following specifications:
      - Room dimensions: Width: ${roomDimensions.width.toStringAsFixed(2)} m, Length: ${roomDimensions.length.toStringAsFixed(2)} m, Height: ${roomDimensions.height.toStringAsFixed(2)} m
      - Room style: $roomStyle
      - Layout:
        $layoutDescription
      - Include realistic lighting and ambiance with a modern aesthetic.
    ''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Room Analysis')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Display the selected image
              _image == null
                  ? Text('No image selected.')
                  : Image.file(_image!),
              SizedBox(height: 20),
              // Buttons to pick image from camera or gallery
              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.camera),
                child: Text('Pick Image from Camera'),
              ),
              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.gallery),
                child: Text('Pick Image from Gallery'),
              ),
              SizedBox(height: 20),
              // Display the room analysis result or error message
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _mlResult,  // Display the generated API prompt or error
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Room Dimensions Class
class RoomDimensions {
  final double width;
  final double length;
  final double height;

  RoomDimensions({
    required this.width,
    required this.length,
    required this.height,
  });

  String get formattedDimensions {
    return 'Width: ${width.toStringAsFixed(2)} m\n'
        'Length: ${length.toStringAsFixed(2)} m\n'
        'Height: ${height.toStringAsFixed(2)} m';
  }
}
