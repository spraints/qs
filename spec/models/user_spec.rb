require 'spec_helper'

describe User do
  subject(:user) { FactoryGirl.create(:user) }

  context "#measure" do
    it "creates a metric for a new measurement" do
      expect { user.measure("new.metric", 100) }.to change { Metric.count }.by(1)
    end

    it "creates a value for a new measurement" do
      expect { user.measure("new.metric", 100) }.to change { Value.count }.by(1)
    end

    context "after creating a metric" do
      before { user.measure("new.metric", 50) }

      it "belongs to the user" do
        Metric.where(:user_id => user.id).pluck(:name).should eq(['new.metric'])
      end

      it "associates a value" do
        Metric.where(:user_id => user.id).first.values.pluck(:value).should eq([50])
      end

      it "does not create a metric" do
        expect { user.measure("new.metric", 100) }.not_to change { Metric.count }
      end

      it "creates a value" do
        expect { user.measure("new.metric", 100) }.to change { Value.count }.by(1)
      end
    end
  end
end
