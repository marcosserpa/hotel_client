require 'rails_helper'

RSpec.describe "hotels/index", type: :view do
  before(:each) do
    assign(:hotels, [
      Hotel.create!(
        :name => "Name",
        :address => "Address",
        :star_rating => 1,
        :accomodation_type => "Accomodation Type"
      ),
      Hotel.create!(
        :name => "Name",
        :address => "Address",
        :star_rating => 1,
        :accomodation_type => "Accomodation Type"
      )
    ])
  end

  it "renders a list of hotels" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Accomodation Type".to_s, :count => 2
  end
end
