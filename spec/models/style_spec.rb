require "spec_helper"

describe Style do
  let(:v) { Struct.new(:occurred_at, :value) }

  context "default" do
    subject { Style.for(nil) }
    it { expect(subject.value(v.new(Time.now, 10))).to eq(10) }
  end

  context "normal" do
    subject { Style.for("normal") }
    it { expect(subject.value(v.new(Time.now, 10))).to eq(10) }
  end

  context "by_month" do
    pending
  end

  context "by_year" do
    pending
  end

  context "year_v_year" do
    pending
  end
end
