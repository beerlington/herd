require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Movies do
  let!(:movie1) { Movie.create!(:name => 'The Goonies', :revenue => 100_000_000) }
  let!(:movie2) { Movie.create!(:name => 'Gigli', :revenue => 0) }

  let!(:director1) { Director.create!(:name => 'Richard Donner') }

  after do
    Movie.destroy_all
    Director.destroy_all
    Character.destroy_all
  end

  it 'should delegate class methods to model' do
    Movies.find_by_name('The Goonies').should == movie1
  end

  it 'should delegate scope method to model' do
    Movies.failures.should == [movie2]
  end

  it 'should delegate class methods to active relation class' do
    chunk = Character.create!(name: 'chunk')
    movie1.characters << chunk

    movie1.characters.fat.should == [chunk]
  end

end
