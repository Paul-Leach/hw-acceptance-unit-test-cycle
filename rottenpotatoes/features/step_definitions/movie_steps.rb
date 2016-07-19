# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    m = Movie.new
    m.title = movie["title"]
    m.rating = movie["rating"]
    m.release_date = movie["release_date"]
    m.director = movie["director"]
    m.save!
    end
#  fail "Unimplemented"
end
Then /the director of "(.*)" should be "(.*)"$/ do | movie, value |
    m = Movie.find_by(title: movie)
    expect(m.director).to eq(value)
end
    