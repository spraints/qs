#require_relative "target_parser/language"

module TargetParser
  class ParseError < RuntimeError ; end

  def self.new
    ParserWrapper.new
  end

  class ParserWrapper
    def parse(str)
      parser = TargetParser::LanguageParser.new
      if parsed = parser.parse(str)
        parsed.simplify
      else
        raise ParseError, parser.failure_reason
      end
    end
  end
end

Treetop.load(File.expand_path("target_parser/language_parser.treetop", File.dirname(__FILE__)))
