require "alexa/api/base"

module Alexa
  module API
    class SitesLinkingIn < Base
      def fetch(arguments = {})
        raise ArgumentError, "You must specify url" unless arguments.has_key?(:url)
        @arguments = arguments

        @arguments[:count] = arguments.fetch(:count, 20)
        @arguments[:start] = arguments.fetch(:start, 0)

        @response_body = Alexa::Connection.new(@credentials).get(params)
        self
      end

      # Response attributes

      def sites
        @sites ||= safe_retrieve(parsed_body, "SitesLinkingInResponse", "Response", "SitesLinkingInResult", "Alexa", "SitesLinkingIn", "Site")
      end

      def status_code
        @status_code ||= safe_retrieve(parsed_body, "SitesLinkingInResponse", "Response", "ResponseStatus", "StatusCode")
      end

      def request_id
        @request_id ||= safe_retrieve(parsed_body, "SitesLinkingInResponse", "Response", "OperationRequest", "RequestId")
      end

      private

      def params
        {
          "Action"        => "SitesLinkingIn",
          "ResponseGroup" => "SitesLinkingIn",
          "Count"         => arguments[:count],
          "Start"         => arguments[:start],
          "Url"           => arguments[:url]
        }
      end
    end
  end
end
