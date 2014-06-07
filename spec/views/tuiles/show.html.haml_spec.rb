require 'spec_helper'

describe "tuiles/show" do
  before(:each) do
    @tuile = assign(:tuile, stub_model(Tuile,
      :lien => "Lien",
      :image => "Image",
      :titre => "Titre",
      :description => "MyText",
      :forme => "Forme"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Lien/)
    rendered.should match(/Image/)
    rendered.should match(/Titre/)
    rendered.should match(/MyText/)
    rendered.should match(/Type/)
  end
end
