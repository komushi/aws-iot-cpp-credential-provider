# aws-iot-cpp-credential-provider
## Authorizing Direct Calls to AWS Services with AWS IoT Credentials Provider C++ example powered by curlpp and libcurl

![architecture](asset/arch.png)


## 1. References
* [Authorizing Direct Calls to AWS Services ](https://docs.aws.amazon.com/iot/latest/developerguide/authorizing-direct-aws.html)

* [How to Eliminate the Need for Hardcoded AWS Credentials in Devices by Using the AWS IoT Credentials Provider](https://aws.amazon.com/jp/blogs/security/how-to-eliminate-the-need-for-hardcoded-aws-credentials-in-devices-by-using-the-aws-iot-credentials-provider/)

* [Basic curlapp example](https://github.com/jpbarrette/curlpp/blob/8810334c830faa3b38bcd94f5b1ab695a4f05eb9/examples/example02.cpp)

* [Shows HTTPS usage with client certs and optional ssl engine use - libcurl example](https://curl.haxx.se/libcurl/c/simplessl.html)


* [cURLpp - a C++ wrapper for libcURL](http://www.curlpp.org/)

## 2. Complie & Build
*This guide is for macOS mojave and it is similar on linux*

## 2-1. Check curl
```
$ curl --version
curl 7.54.0 (x86_64-apple-darwin18.0) libcurl/7.54.0 LibreSSL/2.6.5 zlib/1.2.11 nghttp2/1.24.1
Protocols: dict file ftp ftps gopher http https imap imaps ldap ldaps pop3 pop3s rtsp smb smbs smtp smtps telnet tftp 
Features: AsynchDNS IPv6 Largefile GSS-API Kerberos SPNEGO NTLM NTLM_WB SSL libz HTTP2 UnixSockets HTTPS-proxy 
```

## 2-2. Check curl
```
$ g++ --version
Configured with: --prefix=/Library/Developer/CommandLineTools/usr --with-gxx-include-dir=/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/c++/4.2.1
Apple LLVM version 10.0.1 (clang-1001.0.46.4)
Target: x86_64-apple-darwin18.7.0
Thread model: posix
InstalledDir: /Library/Developer/CommandLineTools/usr/bin
```

## 2-3. Install curlpp library
```
$ brew install curlpp

$ curlpp-config --cflags --libs
```

## 2-4. Build executable
```
$ g++ -std=c++11 src/example.cpp -o bin/iotcred -lcurl -lcurlpp
```

## 3. [Prepare AWS IoT Settings](./AWSIOT.MD)

## 4. Run
```
$ ./bin/iotcred https://<prefix>.credentials.iot.<aws_region>.amazonaws.com/role-aliases/firehose-access-role-alias/credentials thing002
{
  "credentials": {
    "accessKeyId": "ASIAQTTDABVUXAQ6G5NN",
    "secretAccessKey": "s6CGohGsuqtQlO0sxnaqB8lkXZIMlK44TGUB+xA4",
    "sessionToken": "IQoJb3JpZ2luX2VjEPj//////////wEaDmFwLW5vcnRoZWFzdC0xIkcwRQIhAN2C1/NSqF7RDOy4/QjEa9FRzMG9FRCG2gNQ4fhOcVsGAiAkM9NbZCBuVLycHccyRb3caoPAkbHDU/52Sw2fD3cQPSrDAwgREAMaDDA0MjA4MzU1MjYxNyIMvsruGPxC8UTb4ZF5KqADeT2K2mBPmJgjHI8nJDos+MTRL0AISPEyDdudw0UPMqg1oy5Ontuu50rQqBIMhV42hpOwc2lDzEIsiGdxB7kJsJLGzVuikOQp7ZyBdCTZFonuWKB9Y4Ky0SugbZKiVxWn8SvIu0lrQkEtOh1S/vfDixN+QazPuSiwdgwMwnObx3Aos/fU8McreRyv5m3W1zlXyzDe3K7WsqIEjE6L7CkcZqoe2kvCjASmUELNgBI98KV6gL4Ni2MfTJXEc3czBPWaGy8eKmOLEPGsVI1KbR1yNRfyivkr3gsbPSGRbVcM4z1ELABXjOcRFthcBCgeuN9KKrpUMPFP+xcww/hMX2eKNn98mMjtIr0ycsuo77U30JoVTYgevlIYo/RJf8DPn2u2TZZdYTR8mwb26OFgu1euM1yuyRp4+l4FDtyOTOyqEiW9X3WJX3kv+35KEr62/UsesW1zGkhBiGNw74RvIEbar8RbwQpapRBnuV37ODtK2pZMA59/9Gq9mBulwsZOleo2YYuM1Lv1U0oiqfFG2tMdSc7Zqd8gjI5ptO0y31w/yW8wvMbA9AU6jAL6Whved4rLDTPR/SF/TGmFrv1tl+Urf1uze0PTmzpN0O6Ek56NYrUaRuOw50V9JCB7HNqs46YQ6CGSdiEimgEnHk9Vkqp6JNzu7KuEsXSATvnmDCw9jFPgEkE05OghX70u0rzqrshNvYDV/IeD3aJKWkcB8NI/hkPp+bBL1PHE0H/UZUlFBh4lUOTLDw46Eas1jjBPzaU0Q8ySmskR4LmG8JwjiMamIrY6SpxSjU3H5yCq3u/S1qwY+RhixMXymsSRAC99rV6gLBlq303yWOLPmq9K0ZLlVzKUEwzAfv7C3zeQmv8EkWUNa1VOsBLCcHnbx4OHZlq79OCTTRxlySbc+A+19cQUT0ONRth/",
    "expiration": "1920-12-10T08:41:48Z"
  }
}
```
