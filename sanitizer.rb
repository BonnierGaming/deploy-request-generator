require 'cgi'

class Sanitizer
  class << self
    def escape(raw_text)
      CGI.escape(raw_text).gsub('+', '%20')
    end
  end
end
