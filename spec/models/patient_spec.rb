require 'rails_helper'

RSpec.describe Patient, type: :model do

  it "should start in the state of waiting_room" do
    expect(subject.current_state).to eq("waiting_room")
  end

  it "should be able to transfer to 6 states from under_construction" do
    expect(subject.current_state.events.keys).to eq([
      :wait,
      :checkup,
      :xray,
      :surgery
    ])
  end
end