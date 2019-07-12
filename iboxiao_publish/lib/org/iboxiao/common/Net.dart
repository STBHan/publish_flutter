import 'package:http/http.dart' as http;
import 'package:iboxiao_publish/org/iboxiao/common/Bean.dart';
import 'package:iboxiao_publish/org/iboxiao/common/Constont.dart';
import 'package:iboxiao_publish/org/iboxiao/common/Parse.dart';
import 'package:iboxiao_publish/org/iboxiao/common/SP.dart';

import 'AESUtils.dart';

class HttpController {
  static void get(String url, Function callback,
      {Map<String, String> params, Function errorCallback}) async {
    Map<String, String> heads = await getHeads();
    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
    }
    try {
      http.Response res = await http.get(url, headers: heads);
      print("url:" + url);
      if (callback != null) {
        callback(res.body);
      }
    } catch (exception) {
      if (errorCallback != null) {
        errorCallback(exception);
      }
    }
  }

  static Future<Map<String, String>> getHeads() async {
    String tokeData =
        await ShapePreferences.getString(SharedPreferenceKey.TOKEN);
    Token token;
    Map<String, String> heads = new Map();

    try {
      if (tokeData != null) {
        print("token :" + tokeData);
        token = Token.fromJson(Parser.parse(tokeData));
        if (token != null) {
          heads['st'] = token.st;
          heads['stPublicKey'] = token.stPublicKey;
          heads['scUserId'] = token.scUserId;
          heads['User-Agent2'] = "iboxiao.android.phone_flutter";
          int time =
              new DateTime.now().millisecondsSinceEpoch + token.baseTimestamp;
          String key = AESUtils.encrypt(token.stPrivateKey, time.toString());
          print("time:" + time.toString() + ":key:" + token.stPrivateKey);
          print("密钥:" + key);
          heads['scCurrentTimeStamp'] = key;
        }
      }
    } catch (e) {
      print("获取Token异常，$e");
    }

    return heads;
  }

  static void post(String url, Function callback,
      {Map<String, String> params, Function errorCallback}) async {
    Map<String, String> heads = await getHeads();

    try {
      
      http.Response res = await http.post(url, body: params, headers: heads);
      if (callback != null) {
        callback(res.body);
      }
    } catch (e) {
      if (errorCallback != null) {
        errorCallback(e);
      }
    }
  }

  static void postDio(){
  }

}



//// AES key size
//const KEY_SIZE = 32; // 32 byte key for AES-256
//const ITERATION_COUNT = 1000;
//
//class AesHelper {
//  static const CBC_MODE = 'CBC';
//  static const CFB_MODE = 'CFB';
//
//  static Uint8List deriveKey(dynamic password,
//      {String salt = '',
//      int iterationCount = ITERATION_COUNT,
//      int derivedKeyLength = KEY_SIZE}) {
//    if (password == null || password.isEmpty) {
//      throw new ArgumentError('password must not be empty');
//    }
//
//    if (password is String) {
//      password = createUint8ListFromString(password);
//    }
//
//    Uint8List saltBytes = createUint8ListFromString(salt);
//    Pbkdf2Parameters params =
//        new Pbkdf2Parameters(saltBytes, iterationCount, derivedKeyLength);
//    KeyDerivator keyDerivator =
//        new PBKDF2KeyDerivator(new HMac(new SHA256Digest(), 64));
//    keyDerivator.init(params);
//
//    return keyDerivator.process(password);
//  }
//
//  static Uint8List pad(Uint8List src, int blockSize) {
//    var pad = new PKCS7Padding();
//    pad.init(null);
//
//    int padLength = blockSize - (src.length % blockSize);
//    var out = new Uint8List(src.length + padLength)..setAll(0, src);
//    pad.addPadding(out, src.length);
//
//    return out;
//  }
//
//  static Uint8List unpad(Uint8List src) {
//    var pad = new PKCS7Padding();
//    pad.init(null);
//
//    int padLength = pad.padCount(src);
//    int len = src.length - padLength;
//
//    return new Uint8List(len)..setRange(0, len, src);
//  }
//
//  static String encrypt(String password, String plaintext,
//      {String mode = CBC_MODE}) {
//    Uint8List derivedKey = deriveKey(password);
//    KeyParameter keyParam = new KeyParameter(derivedKey);
//    BlockCipher aes = new AESFastEngine();
//
//    var rnd = FortunaRandom();
//    rnd.seed(keyParam);
//    Uint8List iv = rnd.nextBytes(aes.blockSize);
//
//    BlockCipher cipher;
//    ParametersWithIV params = new ParametersWithIV(keyParam, iv);
//    switch (mode) {
//      case CBC_MODE:
//        cipher = new CBCBlockCipher(aes);
//        break;
//      case CFB_MODE:
//        cipher = new CFBBlockCipher(aes, aes.blockSize);
//        break;
//      default:
//        throw new ArgumentError('incorrect value of the "mode" parameter');
//        break;
//    }
//    cipher.init(true, params);
//
//    Uint8List textBytes = createUint8ListFromString(plaintext);
//    Uint8List paddedText = pad(textBytes, aes.blockSize);
//    Uint8List cipherBytes = _processBlocks(cipher, paddedText);
//    Uint8List cipherIvBytes = new Uint8List(cipherBytes.length + iv.length)
//      ..setAll(0, iv)
//      ..setAll(iv.length, cipherBytes);
//
////    return base64.encode(cipherIvBytes);
//
//
//
////    final key1 = new Uint8List.fromList(password.codeUnits);
//    final key1 = generateKey(Uint8List.fromList(utf8.encode(password))) ;
////    final key1 = [49,97,100,54,57,54,102,97,98,53,54,57,100,100,55,100];
//    var message = plaintext;
//    print("Key: $key1");
//    print("Message: $message");
////  var iv = new Digest("SHA-256").process(utf8.encode(message)).sublist(0, 16);
////  CipherParameters params = new PaddedBlockCipherParameters(
////      new ParametersWithIV(new KeyParameter(key), iv), null);
//    CipherParameters params1 = new PaddedBlockCipherParameters(
//        new KeyParameter(Uint8List.fromList(key1)), null);
//
//    ////////////////
//    // Encrypting //
//    ////////////////
//    BlockCipher encryptionCipher = new PaddedBlockCipher("AES/ECB/PKCS7");
//    encryptionCipher.init(true, params1);
//    Uint8List encrypted = encryptionCipher.process(utf8.encode(message));
//    String content = new Base64Encoder().convert(encrypted);
//    print("Encrypted: $content");
//    print("Encrypted:"+encrypted.toString() );
//    return formatBytesAsHexString(encrypted);
//  }
//
//
//  static Uint8List generateKey(Uint8List seed ){
//    if(seed.length>16){
//         int p=(seed.length/16).toInt();
//         Uint8List key= Uint8List(16);
//         for (int i=0;i<16;i++){
//           int index =(i*p) +(i%p);
//           key[i]=seed[index];
//         }
//
//         return key;
//    }else{
//
//      int i=0;
//      Uint8List key = Uint8List(16);
//
//      for(;i<seed.length;i++)
//        key[i]=seed[i];
//
//      for(;i<16;i++)
//        key[i]=59;
//
//      return key;
//    }
//
//
//
//  }
//
//
//  static String formatBytesAsHexString(Uint8List bytes) {
//    var result = new StringBuffer();
//    for (var i = 0; i < bytes.lengthInBytes; i++) {
//      var part = bytes[i];
//      result.write('${part < 16 ? '0' : ''}${part.toRadixString(16)}');
//    }
//    return result.toString();
//  }
//
//  static String decrypt(String password, String ciphertext,
//      {String mode = CBC_MODE}) {
//    Uint8List derivedKey = deriveKey(password);
//    KeyParameter keyParam = new KeyParameter(derivedKey);
//    BlockCipher aes = new AESFastEngine();
//
//    Uint8List cipherIvBytes = base64.decode(ciphertext);
//    Uint8List iv = new Uint8List(aes.blockSize)
//      ..setRange(0, aes.blockSize, cipherIvBytes);
//
//    BlockCipher cipher;
//    ParametersWithIV params = new ParametersWithIV(keyParam, iv);
//    switch (mode) {
//      case CBC_MODE:
//        cipher = new CBCBlockCipher(aes);
//        break;
//      case CFB_MODE:
//        cipher = new CFBBlockCipher(aes, aes.blockSize);
//        break;
//      default:
//        throw new ArgumentError('incorrect value of the "mode" parameter');
//        break;
//    }
//    cipher.init(false, params);
//
//    int cipherLen = cipherIvBytes.length - aes.blockSize;
//    Uint8List cipherBytes = new Uint8List(cipherLen)
//      ..setRange(0, cipherLen, cipherIvBytes, aes.blockSize);
//    Uint8List paddedText = _processBlocks(cipher, cipherBytes);
//    Uint8List textBytes = unpad(paddedText);
//
//    return new String.fromCharCodes(textBytes);
//  }
//
//  static Uint8List _processBlocks(BlockCipher cipher, Uint8List inp) {
//    var out = new Uint8List(inp.lengthInBytes);
//
//    for (var offset = 0; offset < inp.lengthInBytes;) {
//      var len = cipher.processBlock(inp, offset, out, offset);
//      offset += len;
//    }
//    return out;
//  }
//}
//
//Uint8List createUint8ListFromString(String s) {
//  var ret = new Uint8List(s.length);
//  for (var i = 0; i < s.length; i++) {
//    ret[i] = s.codeUnitAt(i);
//  }
//  return ret;
//}
//
//Uint8List createUint8ListFromHexString(String hex) {
//  var result = new Uint8List(hex.length ~/ 2);
//  for (var i = 0; i < hex.length; i += 2) {
//    var num = hex.substring(i, i + 2);
//    var byte = int.parse(num, radix: 16);
//    result[i ~/ 2] = byte;
//  }
//  return result;
//}
