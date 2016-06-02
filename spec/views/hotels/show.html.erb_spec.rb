require 'rails_helper'

RSpec.describe "hotels/show", type: :view do
  before(:each) do
    @hotel = assign(:hotel, Hotel.create!(
      :name => "Name",
      :address => "Address",
      :star_rating => 1,
      :accomodation_type => "Accomodation Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Address/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Accomodation Type/)
  end
end
