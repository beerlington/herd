require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Movies do
  let!(:movie1) { Movie.create!(:name => 'The Goonies', :revenue => 100_000_000) }
  let!(:movie2) { Movie.create!(:name => 'Gigli', :revenue => 0) }


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

  it 'chain a bunch of stuff together and still work' do
    chunk = Character.create!(name: 'chunk')
    rdonner = Director.create!(:name => 'Richard Donner')
    movie1.characters << chunk
    movie1.directors << rdonner

    Movies.directed_by('Richard Donner').first.characters.fat.should == [chunk]
  end

end

describe Directors do
  it 'should set the model name implicitly from the collection name' do
    Directors.create!(:name => 'Richard Donner')

    Directors.all.should have(1).director
  end

  it 'should raise an error if method cannot be found' do
    -> { Directors.no_method }.should raise_error(NoMethodError)
  end
end
