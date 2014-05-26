require "spec_helper"

describe TargetParser do
  subject(:parser) { described_class.new }

  it("parses a series name") { expect(subject.parse("rain")).to eq([:series, "rain"]) }
  it("parses a function call") { expect(subject.parse("dostuff(rain)")).to eq([:call, "dostuff", [:series, "rain"]]) }
  it("parses a function call with arguments") { expect(subject.parse('dostuff(rain, "a", 2)')).to eq([:call, "dostuff", [:series, "rain"], "a", 2]) }
  it("parses a nested function call") { expect(subject.parse('dostuff(otherstuff(rain, "a"), 2)')).to eq([:call, "dostuff", [:call, "otherstuff", [:series, "rain"], "a"], 2]) }
  it("parses everything") do
    expr = 'dostuff(fn2(rain.inches.week, "1", "a.b.c", 3.4, -2.3, +4.7), "ok", -3, +4)'
    out = [ :call, "dostuff",
            [ :call, "fn2", [:series, "rain.inches.week"], "1", "a.b.c", 3.4, -2.3, 4.7 ],
            "ok", -3, 4 ]
    expect(subject.parse(expr)).to eq(out)
  end
end
