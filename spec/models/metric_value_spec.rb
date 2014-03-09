require 'spec_helper'

describe MetricValue do
  it_behaves_like "ActiveModel"

  it "finds all metric instances for a user" do
  end

  it "creates a metric instance" do
    user = double('User')
    user.should_receive(:metrics).and_return(metrics = double('scoped Metric'))
    metrics.should_receive(:named).with('metric.name').and_return(metric = double('Metric'))
    metric.should_receive(:add).with(123).and_return(value = double('Value', :name => 'metric.name', :value => 123))
    v = MetricValue.measure('metric.name', 123, :user => user)
    expect(v).to be_a(MetricValue)
    expect(v.name).to eq('metric.name')
    expect(v.value).to eq(123)
  end
end
