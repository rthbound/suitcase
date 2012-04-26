module Suitcase
  # Public: Represents a single Flight with a departing/arriving date, time,
  #         and location.
  class Flight
    class << self
      # Internal: Build the params for the search URL.
      #
      # options - The Symbol parameters passed into .find.
      #
      # Returns the Stringified parameters.
      def build_params(options)
        params = {}
        params["from"] = options[:from]
        params["to"] = options[:to]
        params["depart-date"] = options[:departure_date]
        params["return-date"] = options[:return_date] if options[:return_date]
        params["adults"] = options[:adults] if options[:adults]
        params["children"] = options[:children] if options[:children]
        params["infants"] = options[:infants] if options[:infants]
        params["carrier"] = options[:carrier] if options[:carrier]
        params["cabin-type"] = options[:cabin_type] if options[:cabin_type]
        params["permitted-carriers"] = options[:permitted_carriers].join("-") if options[:permitted_carriers]
        params["sort"] = options[:sort] if options[:sort]
        params
      end
      
      # Internal: Parse the XML at the URI given.
      #
      # uri - The URI to get the XML from.
      #
      # Returns an Array of Hotels.
      def parse_xml(uri)
        session = Patron::Session.new
        raw = session.get(uri, { "X-CT-API-KEY" => Configuration.cleartrip_api_key })
        binding.pry
      end
      
      # Public: Find flights matching the desired search parameters.
      #
      # options - A Hash of options with the following required keys:
      #           :from               - A String origin city.
      #           :to                 - A String destination city.
      #           :departure_date     - A String departure date, yyyy/mm/dd.
      #           And/or the following optional keys:
      #           :return_date        - A String return date, yyyy/mm/dd.
      #           :adults             - Integer number of the adults.
      #           :children           - Integer number of children.
      #           :infants            - Integer number of infants.
      #           :carrier            - A String airline preference (IATA code).
      #           :cabin_type         - A Symbol cabin type (:business, :economy).
      #           :permitted_carriers - An Array of String carriers to be
      #                                 permitted in the search results.
      #           :sort               - The sorting direction for the search
      #                                 results.
      #
      # Returns an Array of Flight's.
      def find(options)
        params = build_params(options)
        url = "https://api.cleartrip.com/air/1.0/search?"
        url += params.map { |k, v| "#{k}=#{v}" }.join("&")
        uri = URI.parse(URI.escape(url))
        parse_xml(uri)
      end
    end
  end
end