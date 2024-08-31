const bearerHeaderContent = 'Bearer ';
const basicHeaderContent = 'Basic ';
const originHeader = 'Origin';
const applicationJsonMediaType = 'application/json';

class HttpMethods {
  HttpMethods._();

  static const get = 'GET';
  static const post = 'POST';
  static const delete = 'DELETE';
  static const patch = 'PATCH';
  static const put = 'PUT';
}

Map<String, String> defaultHeaders(String token) => {
      "authorization": token,
      "accept": applicationJsonMediaType,
      "content-type": applicationJsonMediaType,
    };

class HttpStatus {
  HttpStatus._();

  static const ok = 200;
  static const accepted = 202;
  static const unauthorized = 401;
}
