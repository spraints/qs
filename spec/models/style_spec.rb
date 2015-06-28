require "spec_helper"

describe Style do
  let(:v) { Struct.new(:occurred_at, :value) }
  def val(occurred_at, value)
    subject.value(v.new(occurred_at, value))
  end

  context "default" do
    subject { Style.for(nil) }
    it { expect(val(Time.now, 10)).to eq(10) }
  end

  context "normal" do
    subject { Style.for("normal") }
    it { expect(val(Time.now, 10)).to eq(10) }
  end

  context "by_month" do
    subject { Style.for("by_month") }
    it do
      expect(val(Time.now, 10)).to eq(10)
    end
    it do
      expect(val(Time.new(2015,1,1), 10)).to eq(10)
      expect(val(Time.new(2015,2,1), 10)).to eq(10)
    end
    it do
      expect(val(Time.new(2015,1,1), 10)).to eq(10)
      expect(val(Time.new(2015,1,2), 10)).to eq(20)
      expect(val(Time.new(2015,1,31), 10)).to eq(30)
    end
  end

  context "by_year" do
    subject { Style.for("by_year") }
    it do
      expect(val(Time.now, 10)).to eq(10)
    end
    it do
      expect(val(Time.new(2014,1,1), 10)).to eq(10)
      expect(val(Time.new(2015,1,1), 10)).to eq(10)
    end
    it do
      expect(val(Time.new(2015,1,1), 10)).to eq(10)
      expect(val(Time.new(2015,2,1), 10)).to eq(20)
      expect(val(Time.new(2015,12,31), 10)).to eq(30)
    end
  end

  context "year_v_year" do
    # This needs to mess with the x-value, too
    pending
  end
end
