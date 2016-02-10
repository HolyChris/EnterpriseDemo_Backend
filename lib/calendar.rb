require 'rubygems'
require 'google_calendar'

class Calendar

  def initialize

    CLIENT_ID = ''
    SECRET = ''
    CALENDAR_ID = ''
    AUTH_CODE = ''

    @calendar = Google::Calendar.new(
        client_id: CLIENT_ID,
        client_secret: SECRET,
        calendar: CALENDAR_ID,
        redirect_url: 'urn:ietf:wg:oauth:2.0:oob'
    )

    @calendar.authorize_url
    @calendar.login_with_auth_code(AUTH_CODE)
  end

  def create_event(params)
    @calendar.create_event do |e|
      e.title = params[:title]
      e.start_time = params[:start]
      e.end_time = params[:end]
    end
  end

  def events(query=nil)
    if query
      @calendar.find_events query
    else
      @calendar.events
    end
  end

  def find_or_create_event_by_id(id, params)
    @calendar.find_or_create_event_by_id(id) do |e|
      e.title = params[:title]
      e.start_time = params[:start]
      e.end_time = params[:end]
    end
  end

end