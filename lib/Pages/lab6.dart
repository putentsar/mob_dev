import 'dart:io';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'dart:convert';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_mobile/main.dart';

class lab6 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => lab6State();
}

class lab6State extends State<lab6> {
  var fileLines = '';
  var keyAES = '';
  var ambientFileName = '';
  var ambientFilePath = '';
  var encryptedFileName = '';
  var encryptedFilePath = '';
  var decryptedFileName = '';
  var decryptedFilePath = '';
  var _inputAesErrorMessage = '';
  var isSavedKeyMsg = '';
  var isEncryptedKeyMsg = '';
  var isDecryptedKeyMsg = '';

  final encryptInitializeVector = encrypt.IV.fromLength(16);
  TextEditingController _keyAESController = TextEditingController(); //
  String _decryptedText = '';
  bool _secureText = true;

  checkPermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
      await Permission.location.request();
    }
  }

  createEncryptedAndDecryptedFiles() async {
    await File(encryptedFilePath).create(recursive: true);
    File(encryptedFilePath).openWrite(mode: FileMode.write).writeAll([]);
    // await File(decryptedFilePath).create(recursive: true);
    // File(decryptedFilePath).openWrite(mode: FileMode.write).writeAll([]);
  }

  cryptAES() async {
    if (keyAES.length == 32 && ambientFilePath.length > 0) {
      File(encryptedFilePath)
          .openWrite(mode: FileMode.write)
          .writeAll([]); //очищаем файл
      _decryptedText = '';
      var encrypter = encrypt.Encrypter(
          encrypt.AES(encrypt.Key.fromUtf8(keyAES), mode: encrypt.AESMode.ctr));
      await for (var textFromFile in File(ambientFilePath).openRead()) {
        String textFromFileString = Utf8Decoder().convert(textFromFile);
        var encrypted =
            encrypter.encrypt(textFromFileString, iv: encryptInitializeVector);
        File(encryptedFilePath)
            .openWrite(mode: FileMode.append, encoding: utf8)
            .write(encrypted.base64);
      }
    }
  }

  decryptAES() async {
    if (keyAES.length == 32 && ambientFilePath.length > 0) {
      File(decryptedFilePath).openWrite(mode: FileMode.write).writeAll([]);
      var encrypter = encrypt.Encrypter(
          encrypt.AES(encrypt.Key.fromUtf8(keyAES), mode: encrypt.AESMode.ctr));
      await for (var textFromFile in File(encryptedFilePath).openRead()) {
        String textFromFileString = Utf8Decoder().convert(textFromFile);
        var decrypted = encrypter.decrypt64(textFromFileString,
            iv: encryptInitializeVector);

        // File(decryptedFilePath)
        //     .openWrite(mode: FileMode.append, encoding: utf8)
        //     .write(decrypted);
        _decryptedText += decrypted;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        Text(
          'ЛР №6. AES',
          textScaleFactor: 2,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 6),
        ),
        Text(
          isSavedKeyMsg,
          textAlign: TextAlign.center,
        ),
        TextField(
          controller: _keyAESController,
          decoration: InputDecoration(
              hintText: (keyAES.length == 0) ? 'Введите ключ' : keyAES,
              labelStyle: TextStyle(fontSize: 24, color: Colors.blueAccent),
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(_secureText ? Icons.remove_red_eye : Icons.security),
                onPressed: () {
                  setState(() {
                    _secureText = !_secureText;
                  });
                },
              )),
          obscureText: _secureText,
        ),
        Text(
          _inputAesErrorMessage,
          style: TextStyle(color: Colors.redAccent),
        ),
        ElevatedButton(
            onPressed: () {
              if (_keyAESController.text.length <= 32) {
                setState(() {
                  keyAES = _keyAESController.text;
                  while (keyAES.length < 32) keyAES += '#';
                  _inputAesErrorMessage = '';
                  isSavedKeyMsg = 'Ключ сохранен';
                });
                // _keyAESController.text = '';
              } else {
                setState(() {
                  _inputAesErrorMessage =
                      'Требуется не более 32 символов, введено: ' +
                          _keyAESController.text.length.toString();
                  isSavedKeyMsg = 'Ошибка!';
                });
              }
            },
            child: Text('Сохранить')),
        Container(
          padding: EdgeInsets.symmetric(vertical: 12),
        ),
        Expanded(
            child: Column(
          children: [
            Text(
              'файл: ' + ambientFileName,
              textAlign: TextAlign.center,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 6),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    File file = await FilePicker.getFile();
                    try {
                      var pathSplitted = file.path.split('/');
                      setState(() {
                        ambientFilePath = file.path;
                        ambientFileName = pathSplitted[pathSplitted.length - 1];
                        encryptedFilePath = '';
                        decryptedFilePath = '';
                        for (int i = 0; i < pathSplitted.length - 2; ++i) {
                          encryptedFilePath += pathSplitted[i] + '/';
                          // decryptedFilePath += pathSplitted[i] + '/';
                        }
                        encryptedFileName = 'encrypted_' +
                            pathSplitted[pathSplitted.length - 1];
                        encryptedFilePath += encryptedFileName;
                        // // decryptedFileName = 'decrypted_' +
                        //     pathSplitted[pathSplitted.length - 1];
                        // decryptedFilePath += decryptedFileName;
                      });

                      await createEncryptedAndDecryptedFiles();
                    } catch (error) {
                      print(error);
                    }
                  },
                  child: Text('Выбрать'),
                ),
                ElevatedButton(
                  onPressed: () {
                    try {
                      OpenFile.open(ambientFilePath);
                    } catch (error) {
                      print(error);
                    }
                  },
                  child: Text('Открыть'),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 6),
            ),
            Text(
              'зашифрованный файл: ' + encryptedFileName,
              textAlign: TextAlign.center,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 6),
            ),
            Text(
              isEncryptedKeyMsg,
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: Text('Зашифровать'),
                  onPressed: () async {
                    try {
                      await checkPermission();
                      await cryptAES();
                      setState(() => isEncryptedKeyMsg = 'Файл зашифрован');
                      setState(() => isDecryptedKeyMsg = '');
                    } catch (error) {
                      print(error);
                      setState(() => isEncryptedKeyMsg = 'Ошибка');
                    }
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    try {
                      OpenFile.open(encryptedFilePath);
                    } catch (error) {
                      print(error);
                    }
                  },
                  child: Text('Открыть'),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 6),
            ),
            // Text(
            //   'расшифрованный файл: ' + decryptedFileName,
            //   textAlign: TextAlign.center,
            // ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 6),
            ),
            Text(
              isDecryptedKeyMsg,
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: Text('Расшифровать'),
                  onPressed: () async {
                    try {
                      await checkPermission();
                      await decryptAES();
                      setState(() => isDecryptedKeyMsg = 'Файл расшифрован');
                      setState(() => isEncryptedKeyMsg = '');
                    } catch (error) {
                      print(error);
                      setState(() => isDecryptedKeyMsg = 'Ошибка');
                    }
                  },
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     try {
                //       OpenFile.open(decryptedFilePath);
                //     } catch (error) {
                //       print(error);
                //     }
                //   },
                //   child: Text('Открыть'),
                // ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 6),
            ),
            Text('Расшифрованный текст:'),
            Container(
              padding: EdgeInsets.symmetric(vertical: 6),
            ),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(_decryptedText
                  // decoration: InputDecoration(
                  //   // hintText: (keyAES.length == 0) ? 'Введите ключ' : keyAES,
                  //   labelStyle: TextStyle(fontSize: 24, color: Colors.blueAccent),
                  //   border: OutlineInputBorder(),
                  // ),
                  ),
            ),
          ],
        )),
        Container(
          padding: EdgeInsets.symmetric(vertical: 12),
        ),
      ],
    );
  }
}
