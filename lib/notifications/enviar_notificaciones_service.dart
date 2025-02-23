import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

class AccessToken {
  Future<String> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "app-banco-flutter",
      "private_key_id": "d4e3d75ea0f08fa14e5ad77126801d48c72a1921",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDJXQRe3VSZf4S7\ncXwLNVQsi9vMlvsK9LtbfRFan+M/NdRbjoUTJD0uYrNMDn1viUfStfVPdyVYwbGu\nt5wo9t/cqXRB1a96KyZHzP2ZKHHSBTzcON/SqDlrQtrBuRuVA4Ys2qR27drPjJIJ\nZAyCDLVzDk9vkTf/KlWNIpPDqrVFymlvoWjYDoCu1M+OR4G084/SRIqiA7nb53tA\nFZnO3RBqcMfPxw3PQaEnHsNP+7WongIpNvnZqHfn/fXdoRtkk3hez7EV7tA1NsLp\nBLfOxgBf0O5cp/OyIZtapOfetvKbQwhEE03hRDpfVMiS85Z7y2lNn/3fTAH87VxV\nhFXoKd9bAgMBAAECggEAVNtQFjIrjqxAYUWHwqlsmYEu1V7i2FEeC4X/JDOw7lhe\n7152EgT5i2yopmqMzc4KaG+pux04rdiiakCSHGk9GZ6HkZ7dXhyE+0kVrc9vd9Qh\nO6T0HbAq0lrQGUdKqldb2dch68R8q25PtIlnA/8bECt9qkSGVo+ekeV6Y8Cyt3+/\nwo0jIVuYIjbgKw9gBYFDO9N1Ig6kvG7ssga6cTButmL8C39J6jtXfUYO+KiEYJRg\nOykwCC26OzrCP0jHMc6aFJMAmib5Ubk+t1G4ZTFfojfTfXE6XpSFO6x9ZGWvlzJD\nTwNbEfa8ZxxNnWdA24QveJSDq5NlT0g3Xn6dL9ZKcQKBgQDr7tP1wMheScOKitxW\npR9b2SIyhoTuFPNDEB1/rsmSikbBNhbXCATA6PdDGydinodHqsyrGGtv0MdF6UGg\niPumec8lcGJmoBMjqv+yttyxsK3TkqpynkFUPERz4vsDrETPt64qcCatDuim7tVp\np7EebTRolFxJuYL+vtkb5z6JpQKBgQDafXnOY5v90eFAP+CZtfXTQ/yb8dwOeBzA\nxW7WcQa4MMqfOXXg2yx4yqAvXwvuQNOONZUVcHMDJokwaIuKs/DX7V8eY0bcQY/P\nNwuHlBEVZ04Pta8M6pURfA4YNXjS1uAqQwgS3+dz76mnh6JtZDZejr05mYyC5yJy\nvAr7SIB0/wKBgQCe2KFkqHM+6DL7KBrJS0sdr8dSdTcyhHB0CnmR6cBVJTwWAbDG\n/eMVbsRrLfEKeOlj2x8JYtuS4OIJs843o4KqxwAsmMnnhobcUNjvHibgi6+87tZL\nbTlW2WzNCVkvU+DQaT6d2/xuL8d7/Pk6tWiOr7/FWX35NSl5Ek1ieAKm8QKBgQDL\nILaao87Fxld1RS3JmfqmZGG4lb3xkcehjKxEH6aQnYPzTheCaiHJVxBfmizcX1aP\nss8ctIOo3S3UXI3G8Q2rodq5xLB/W1CY5GMKtCTB0l4nitDo4Dqgm8X6ydO/qNeV\nUuZxrcpf5ePDhf0DWJSXinrvzwpsNPi41IwdHEWY/wKBgQCB3W0swmvWe7lwB186\nCUZsXpJlKahKyFppOOlEGFBFVw+MuRrDvp7hdVmfY43EcucgpP2OMeGCSNvMuJYV\nAjfM8/SHLwsXVlUf4nfuH2wowTdxfGQEoU/WZ5kLhnWehhvz0uScaYXQQjxsVNnM\nzR9s9b6sMyRV8G4tuQHJA15InA==\n-----END PRIVATE KEY-----\n",
      "client_email":
          "firebase-adminsdk-fbsvc@app-banco-flutter.iam.gserviceaccount.com",
      "client_id": "110555423940610882875",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40app-banco-flutter.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging",
    ];

    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );

    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
      client,
    );

    client.close();

    return credentials.accessToken.data;
  }
}

class Constants {
  static const String BASE_URL =
      'https://fcm.googleapis.com/v1/projects/app-banco-flutter/messages:send';
}

class EnviarNotificacionService {
  Future<bool> pushNotifications({
    required String title,
    required String body,
    required String token,
  }) async {
    Map<String, dynamic> payload = {
      "message": {
        "token": token,
        "notification": {
          "title": title,
          "body": body,
        },
      },
    };
    String dataNotifications = jsonEncode(payload);

    final String keyServer = await AccessToken().getAccessToken();

    var response = await http.post(
      Uri.parse(Constants.BASE_URL),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $keyServer',
      },
      body: dataNotifications,
    );
    debugPrint(response.body.toString());
    if (response.statusCode != 200) {
      return false;
    }
    return true;
  }
}
