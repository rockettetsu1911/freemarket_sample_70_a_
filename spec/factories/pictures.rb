FactoryBot.define do
  factory :picture do
    imgae     {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test1.png'))}
    association :item
  end
end
