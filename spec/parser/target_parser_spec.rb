require "spec_helper"

describe TargetParser do
  subject(:parser) { described_class.new }

  it("parses a series name") { expect(subject.parse("rain")).to eq([:series, "rain"]) }
  it("parses a function call") { expect(subject.parse("dostuff(rain)")).to eq([:call, "dostuff", [:series, "rain"]]) }
  it("parses a function call with arguments") { expect(subject.parse('dostuff(rain, "a", 2)')).to eq([:call, "dostuff", [:series, "rain"], "a", 2]) }
  it("parses a nested function call") { expect(subject.parse('dostuff(otherstuff(rain, "a"), 2)')).to eq([:call, "dostuff", [:call, "otherstuff", [:series, "rain"], "a"], 2]) }
end
