#include <cstdlib>
#include <cstdio>
#include <cstring>
#include <sstream>

#include <curlpp/cURLpp.hpp>
#include <curlpp/Easy.hpp>
#include <curlpp/Options.hpp>
#include <curlpp/Exception.hpp>


namespace
{
	std::string url("");
	std::string certFile("");
	std::string keyName("");
	std::string thingName("");
}

int main(int argc, char *argv[])
{

	if(argc == 5)
	{
		url = argv[1];
		thingName = argv[2];
		certFile = argv[3];
		keyName = argv[4];		
	}
	else if(argc == 3)
	{
		url = argv[1];
		thingName = argv[2];
		certFile = "./cert/certificate.pem.crt";
		keyName = "./cert/private.pem.key";
	}
	else 
	{
		std::cerr << "Missing argument" << std::endl 
			<< "Usage: iotcred <credentials_provider_endpoint> <thingName> <certFile> <keyName>" << std::endl 
			<< "Usage: iotcred <credentials_provider_endpoint> <thingName>"
			<< std::endl;
		return EXIT_FAILURE;
	}

	std::string thingHeader("x-amzn-iot-thingname: ");
	thingHeader += thingName;

	try
	{
		curlpp::Cleanup cleaner;
		curlpp::Easy request;
		std::ostringstream os;

		std::list<std::string> headers;
		headers.push_back(thingHeader); 

		using namespace curlpp::Options;
		request.setOpt(new HttpHeader(headers));
		request.setOpt(new Url(url));
		request.setOpt(new SslCert(certFile));
		request.setOpt(new SslCertType("PEM"));
		request.setOpt(new SslKey(keyName));
		request.setOpt(new SslKeyType("PEM"));

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