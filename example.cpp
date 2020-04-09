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