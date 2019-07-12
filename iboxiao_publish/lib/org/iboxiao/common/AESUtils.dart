import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/pointycastle.dart';

class AESUtils {
  /// AES 加密处理
  /// 对 密钥的字节数据进行了自定处理后加密
  /// password:密钥
  /// content ：内容
  ///
  static String encrypt(String password, String content) {
    final key = generateKey(Uint8List.fromList(utf8.encode(password)));
    String message = content;
    print("Key: $key");
    print("Message: $message");

    CipherParameters params = new PaddedBlockCipherParameters(
        new KeyParameter(Uint8List.fromList(key)), null);

    BlockCipher encryptionCipher = new PaddedBlockCipher("AES/ECB/PKCS7");
    encryptionCipher.init(true, params);
    Uint8List encrypted = encryptionCipher.process(utf8.encode(message));
    String text = new Base64Encoder().convert(encrypted);
    print("Encrypted: $text");
    print("Encrypted:" + encrypted.toString());
    return formatBytesAsHexString(encrypted);
  }

  /// 对字节数组进行自定义处理
  static Uint8List generateKey(Uint8List seed) {
    if (seed.length > 16) {
//      int p = (seed.length / 16).toInt();
      int p = (seed.length ~/ 16);
      Uint8List key = Uint8List(16);
      for (int i = 0; i < 16; i++) {
        int index = (i * p) + (i % p);
        key[i] = seed[index];
      }

      return key;
    } else {
      int i = 0;
      Uint8List key = Uint8List(16);
      for (; i < seed.length; i++) key[i] = seed[i];
      for (; i < 16; i++) key[i] = 59;
      return key;
    }
  }

  ///字节数组转换为 16进制
  static String formatBytesAsHexString(Uint8List bytes) {
    var result = new StringBuffer();
    for (var i = 0; i < bytes.lengthInBytes; i++) {
      var part = bytes[i];
      result.write('${part < 16 ? '0' : ''}${part.toRadixString(16)}');
    }
    return result.toString();
  }

  /// 解密
  ///
  static String decrypte(String password, String content) {
    final key = generateKey(Uint8List.fromList(utf8.encode(password)));
    String message = content;
    print("Key: $key");
    print("Message: $message");
    CipherParameters params = new PaddedBlockCipherParameters(
        new KeyParameter(Uint8List.fromList(key)), null);

    BlockCipher encryptionCipher = new PaddedBlockCipher("AES/ECB/PKCS7");
    encryptionCipher.init(true, params);
    Uint8List encrypted = encryptionCipher.process(utf8.encode(message));
//    CipherParameters params = new PaddedBlockCipherParameters(
//        new KeyParameter(key), null);
    BlockCipher decryptionCipher = new PaddedBlockCipher("AES/ECB/PKCS7");
    decryptionCipher.init(false, params);
    String decrypted = utf8.decode(decryptionCipher.process(encrypted));
    print("Decrypted: $decrypted");
    return decrypted;
  }

  ///
  /// AES 加密处理普通加密 ：key 未按照自定义方式获取 字节数组
  /// password :加密密钥
  /// content :加密内容
  static String encryptCommon(String password, String content) {
    final key = new Uint8List.fromList(password.codeUnits);
    String message = content;
    print("Key: $key");
    print("Message: $message");
    CipherParameters params = new PaddedBlockCipherParameters(
        new KeyParameter(Uint8List.fromList(key)), null);
    BlockCipher encryptionCipher = new PaddedBlockCipher("AES/ECB/PKCS7");
    encryptionCipher.init(true, params);
    Uint8List encrypted = encryptionCipher.process(utf8.encode(message));
    String text = new Base64Encoder().convert(encrypted);
    print("Encrypted: $text");
    print("Encrypted:" + encrypted.toString());
    return formatBytesAsHexString(encrypted);
  }
}
