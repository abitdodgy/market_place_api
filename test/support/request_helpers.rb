module Support
  module Request
    module JSONHelpers
      private def json_response_body(&block)
        JSON.parse(response.body, symbolize_names: true).tap do |content|
          yield content if block_given?
        end
      end
    end

    module HeadersHelpers
      def api_authorization_header(token:)
        request.headers['Authorization'] = token
      end

      def api_version_header(version: 1)
        request.headers['Accept'] = "application/vnd.marketplace.v#{version}"
      end

      def api_response_format(format: Mime::JSON)
        request.headers['Accept'] = "#{api_version_header},#{format.to_s}"
        request.headers['Content-Type'] = format.to_s
      end

      def include_default_request_headers
        api_version_header
        api_response_format
      end
    end
  end
end
