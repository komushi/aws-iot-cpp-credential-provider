* https://github.com/jpbarrette/curlpp/blob/8810334c830faa3b38bcd94f5b1ab695a4f05eb9/examples/example02.cpp
* https://aws.amazon.com/jp/blogs/security/how-to-eliminate-the-need-for-hardcoded-aws-credentials-in-devices-by-using-the-aws-iot-credentials-provider/
* https://curl.haxx.se/libcurl/c/simplessl.html

```
#include <cstdlib>
#include <cstdio>
#include <cstring>

#include <curlpp/cURLpp.hpp>
#include <curlpp/Easy.hpp>
#include <curlpp/Options.hpp>
#include <curlpp/Exception.hpp>



int main(int argc, char *argv[])
{

	std::string url("https://<your_credentials_provider_endpoint>/role-aliases/<your_role_alias>/credentials");
	std::string certFile("testcert.pem");
	std::string certType("PEM");
	std::string keyName("testkey.pem");
	std::string keyType("PEM");

	try
	{
		curlpp::Cleanup cleaner;
		curlpp::Easy request;
		std::ostringstream os;

		std::list<std::string> headers;
		headers.push_back("x-amzn-iot-thingname: <your_thing_name>"); 

		using namespace curlpp::Options;
		request.setOpt(new HttpHeader(headers));
		request.setOpt(new Url(url));
		request.setOpt(new SslCert(certFile));
		request.setOpt(new SslCertType(certType));
		request.setOpt(new SslKey(keyName));
		request.setOpt(new SslKeyType(keyType));

		request.perform();

		os << request;
	}
	catch (curlpp::LogicError & e)
	{
		std::cout << e.what() << std::endl;
	}
	catch (curlpp::RuntimeError & e)
	{
		std::cout << e.what() << std::endl;
	}

	return 0;
}
```