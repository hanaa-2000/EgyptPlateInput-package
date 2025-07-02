# Egypt Plate Input

ويدجت جاهزة لإدخال لوحة أرقام عربية للسيارات المصرية، تتكون من ثلاث خانات حروف وخانة واحدة للأرقام، مع دعم للغة العربية والتحكم الكامل في الشكل والفاليديشن.

## 📦 الاستخدام

```dart
class PlateDemoScreen extends StatefulWidget {
  const PlateDemoScreen({super.key});

  @override
  State<PlateDemoScreen> createState() => _PlateDemoScreenState();
}

class _PlateDemoScreenState extends State<PlateDemoScreen> {
  final field1Controller = TextEditingController();
  final field2Controller = TextEditingController();
  final field3Controller = TextEditingController();
  final numberController = TextEditingController();

  @override
  void dispose() {
    field1Controller.dispose();
    field2Controller.dispose();
    field3Controller.dispose();
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('تجربة لوحة عربية'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EgyptPlateInput(
                field1Controller: field1Controller,
                field2Controller: field2Controller,
                field3Controller: field3Controller,
                numberController: numberController,
                background: Colors.grey,
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.black26,
                  fontWeight: FontWeight.bold,
                ),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                onPlateChanged: (plate) {
                  log("اللوحة الجديدة: $plate");
                },
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  final plate =
                      "${field1Controller.text}${field2Controller.text}${field3Controller.text}-${numberController.text}";
                  print("رقم اللوحة: $plate");
                },
                child: const Text("طباعة اللوحة"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

dependencies:
  egypt_plate_input: ^1.0.0

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
