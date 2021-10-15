require 'simplecov'
SimpleCov.start 'rails'
FactoryGirl.define do
  factory :movie do |f|
    f.title "Spiderman"
    f.rating "G"
    f.description "Spider man movie"
    f.release_date "12-12-12"
    f.director "James"
  end
end