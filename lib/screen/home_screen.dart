import 'package:flutter/material.dart';
import 'package:test_02/model/user_data.dart';
import 'package:test_02/screen/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<UserData> listOfData = [];
  List<UserData> data = [];
  List<Widget> formFields = [];
  String name = '';
  String email = '';
  String pinCode = '';
  String test = '';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          children: [
            formField(
                title: "Name",
                onChanged: (value) {
                  name = value;
                },
                validator: (v) {
                  if (v!.length < 3) {
                    return "Enter a valid name";
                  }
                }),
            formField(
                title: "Email",
                onChanged: (value) {
                  email = value;
                },
                validator: (v) {
                  if (v!.length < 3) {
                    return "Enter a valid email";
                  }
                }),
            formField(
                title: "PinCode",
                onChanged: (value) {
                  pinCode = value;
                },
                validator: (v) {
                  if (v!.length < 3) {
                    return "Enter a valid pin code";
                  }
                }),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 16,
                  width: 30,
                );
              },
              itemCount: formFields.length,
              itemBuilder: (BuildContext context, int index) {
                return formFields[index];
              },
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      test = '';
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return dialogBox();
                        },
                      );
                    },
                    icon: const Icon(Icons.add)),
                const SizedBox(
                  width: 24,
                ),
                MaterialButton(
                  onPressed: () {
                    listOfData = [];
                    data = [];
                    if (_formKey.currentState?.validate() == true) {
                      _formKey.currentState?.save();
                      listOfData.addAll(data);
                      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) {
                        return DetailScreen(userData: listOfData);
                      }));
                    }
                  },
                  color: Colors.green,
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget formField(
      {required String title,
      required ValueChanged<String> onChanged,
      required FormFieldValidator<String> validator}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          decoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              label: Text("Enter ${title} here")),
          onChanged: onChanged,
          validator: validator,
          onSaved: (v) {
            data.add(UserData(label: title,data: v));
          },
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget dialogBox() {
    return AlertDialog(
      title: const Text("Add Form Field"),
      content: formField(
          title: "Title",
          onChanged: (value) {
            print(value);
            test = value;
          },
          validator: (v) {
            if (v!.length < 3) {
              return "Enter a valid title";
            }
          }),
      actions: [
        Row(
          children: [
            Expanded(
              child: MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.red,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: MaterialButton(
                onPressed: () {
                  if (test.length == 0 || test == null) {
                  } else {
                    formFields.add(formField(
                        title: test,
                        onChanged: (v) {

                        },
                        validator: (v) {
                          if (v!.length < 3) {
                            return "Enter a valid $test";
                          }
                        }));
                    Navigator.pop(context);
                    setState(() {});
                  }
                },
                child: const Text(
                  "Add",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.green,
              ),
            )
          ],
        ),
      ],
    );
  }
}
