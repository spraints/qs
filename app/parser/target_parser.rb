#require_relative "target_parser/language"

module TargetParser
  def self.new
    ParserWrapper.new
  end

  class ParserWrapper
    def parse(str)
      parsed = parser.parse(str)
      parsed.simplify
    end

    def parser
      TargetParser::LanguageParser.new
    end
  end
end

Treetop.load(File.expand_path("target_parser/language_parser.treetop", File.dirname(__FILE__)))
