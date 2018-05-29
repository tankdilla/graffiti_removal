class SodaService
  attr_reader :client

  SODA_DOMAIN = "data.cityofchicago.org"
  WARD_DOMAIN = "7ia9-ayc2"
  SERVICE_REQUEST_DOMAIN = "cdmx-wzbz"

  def initialize
    @client = SODA::Client.new({:domain => SODA_DOMAIN, :app_token => Rails.application.credentials.soda_key})
  end

  def get(params={})
    request_results = []

    last_names = params[:last_name].split(',')

    where_clause =
      last_names.map {|last_name| "alderman LIKE '%#{last_name}%'" }.join(" OR ")

    ward_results = client.get(WARD_DOMAIN, {"$where" => where_clause})
    ward_results.each do |ward_result|
      service_request(ward_result, params, request_results)
    end

    request_results
  end

  private

  def service_request(ward_result, params, request_results)
    ward = ward_result.ward

    dates = parse_date(params[:year], params[:month])

    dates.each do |date|
      where_clause = "ward = #{ward} and creation_date >= '#{date[:begin_date]}' and creation_date <= '#{date[:end_date]}'"
      where_clause += " and what_type_of_surface_is_the_graffiti_on_ = '#{params[:graffiti_surface]}'" if params[:graffiti_surface]
      where_clause += " and where_is_the_graffiti_located_ = '#{params[:graffiti_location]}'" if params[:graffiti_location]

      graffiti_results = client.get(SERVICE_REQUEST_DOMAIN, "$where" => where_clause)

      request_results << {
        alderman_name: ward_result.alderman,
        ward: ward_result.ward,
        report_month_beginning: date[:begin_date],
        number_of_requests: graffiti_results.size
      }
    end

  end

  def format_date(date)
    date.strftime('%FT%T')
  end

  def parse_date(year, month)
    months = month.split(',')
    months.map do |m|
      {
        begin_date: format_date(Date.new(year.to_i, m.to_i)),
        end_date: format_date(Date.new(year.to_i, m.to_i, -1))
      }
    end
  end
end
