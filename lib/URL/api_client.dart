import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:m_power/URL/app_constant.dart';
import 'package:m_power/Widgets/show_message.dart';
import 'package:m_power/main.dart';
import 'package:path/path.dart';

enum Method { POST, GET,PUT,DELETE,PATCH }



class Api_Client{
  var client = http.Client();
  Map<String,String> header()=>{
    "Accept": "application/json",
    'Authorization':'${AppConstant.Bearer} ${auth!.token}'
  };
  Map<String,String> header1()=>{
    "Accept": "application/json"
  };

  void close(){
    client.close();
  }

  Future Request({required String url,Method method=Method.GET,var body,required Function onSuccess,required Function onError,bool enableShowError=true})async{

    try{
      http.Response? response;
      if(method==Method.POST)
      {
        response = await client.post(Uri.parse(url),body: body, headers: header());
      }
      else if(method==Method.DELETE){
        response = await client.delete(Uri.parse(url), headers: header());
      }
      else if(method==Method.PATCH){
        response = await client.patch(Uri.parse(url), headers: header(),body: body);
      }
      else{
        response = await client.get(Uri.parse(url), headers: header());
      }
      showData(url: url,response: response.body,body: body,method: method,header: header());
      if (response.statusCode == 200 || response.statusCode == 401 || response.statusCode == 422 || response.statusCode == 400) {
        var data=json.decode(response.body);
        onSuccess(data);
      } else {
        if(enableShowError) {
          ErrorMessage(message: language.Something_went_wrong);
        }
        onError({'error': language.Something_went_wrong});
      }
    } on TimeoutException catch (e) {
      client.close();
      if(enableShowError) {
        ErrorMessage(message: language.Check_Your_Internet_Connection);
      }
      onError({'error': language.Check_Your_Internet_Connection});
    } on SocketException catch (e) {
      client.close();
      if(enableShowError) {
        ErrorMessage(message: language.Check_Your_Internet_Connection);
      }
      onError({'error': language.Check_Your_Internet_Connection});
    } on Error catch (e) {
      client.close();
      if(enableShowError) {
        ErrorMessage(message: language.Something_went_wrong);
      }
      onError({'error': language.Something_went_wrong});
    }
  }


  Future SimpleRequest({required String url,Method method=Method.GET,Map<String , dynamic>? body,required Function onSuccess,required Function onError,bool enableShowError=true,bool isThirdPartyApi=false})async{
    http.Response? response;
    try{
      if(method==Method.POST)
      {
        response = await client.post(Uri.parse(url),body: body,);
      }
      else if(method==Method.DELETE){
        response = await client.delete(Uri.parse(url), );
      }
      else if(method==Method.PATCH){
        response = await client.patch(Uri.parse(url),body:body);
      }
      else{
        response = await client.get(Uri.parse(url));
      }
      showData(url: url,response: response.body,body: body,method: method, header: header1());
      if (response.statusCode == 200 || response.statusCode == 401 || response.statusCode == 422 || response.statusCode == 400) {
        var data=json.decode(response.body);
        onSuccess(data);
      } else {
        if(enableShowError) {
          ErrorMessage(message: language.Something_went_wrong);
        }
        onError({'error': language.Something_went_wrong});
      }
    } on TimeoutException catch (e) {
      client.close();
      if(enableShowError) {
        ErrorMessage(message: language.Check_Your_Internet_Connection);
      }
      onError({'error': language.Check_Your_Internet_Connection});
    } on SocketException catch (e) {
      client.close();
      if(enableShowError) {
        ErrorMessage(message: language.Check_Your_Internet_Connection);
      }
      onError({'error': language.Check_Your_Internet_Connection});
    } on Error catch (e) {
      client.close();
      if(enableShowError) {
        ErrorMessage(message: language.Check_Your_Internet_Connection);
      }
      onError({'error': language.Check_Your_Internet_Connection});
    }
  }

  Future RequestWithFile({required String url,Map<String,String>? body,List<String>? fileKey,List<File>? files,Method method=Method.POST,required Function onSuccess,required Function onError,bool enableShowError=true,bool withAuthorization= true})async{
    var result;
    var uri = Uri.parse(url);
    http.MultipartRequest? request;
    if(method==Method.POST){
      request = http.MultipartRequest("POST", uri)..fields.addAll(body!)..headers.addAll(withAuthorization ? header() : header1());
    }
    else if(method==Method.PATCH){
      request = http.MultipartRequest("PATCH", uri)..fields.addAll(body!)..headers.addAll(withAuthorization ? header() : header1());
    }
    else if(method==Method.PATCH){
      request = http.MultipartRequest("PATCH", uri)..headers.addAll(withAuthorization ? header() : header1())..fields.addAll(body!);
    }


    for(int i=0;i<fileKey!.length;i++){
      var stream = http.ByteStream(files![i].openRead().cast());
      var length = await files[i].length();
      var multipartFile = http.MultipartFile(fileKey[i], stream, length, filename: basename(files[i].path));
      request!.files.add(multipartFile);
    }
    http.StreamedResponse? response;
    try {
      response = await request!.send();
      if (response.statusCode == 200 || response.statusCode == 401 || response.statusCode == 422 || response.statusCode == 400) {
        await response.stream.transform(utf8.decoder).listen((value) {
          result = value;
        });
        showData(body: body,method: method,response: result,url: url,header: withAuthorization ? header() : header1());
        var data=json.decode(result);
        onSuccess(data);
      } else {
        if(enableShowError) {
          ErrorMessage(message: language.Something_went_wrong);
        }
        onError({'error': language.Something_went_wrong});
      }
    }on TimeoutException catch (e) {
      if(enableShowError) {
        ErrorMessage(message: language.Check_Your_Internet_Connection);
      }
      onError({'error': language.Check_Your_Internet_Connection});
    } on SocketException catch (e) {
      if(enableShowError) {
        ErrorMessage(message: language.Check_Your_Internet_Connection);
      }
      onError({'error': language.Check_Your_Internet_Connection});
    } on Error catch (e) {
      if(enableShowError) {
        ErrorMessage(message: language.Check_Your_Internet_Connection);
      }
      onError({'error': language.Check_Your_Internet_Connection});
    }
  }




  void showData({required String url, var body,required Map<String, dynamic> header, required String response,required Method method}) {
    if (kDebugMode) {
      print("URL = $url");
      print("Body = $body");
      print("Header = $header");
      print("Method = $method");
      print("Response = $response");
    }
  }

}


