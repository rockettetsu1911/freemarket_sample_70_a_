FactoryBot.define do
  factory :picture do
    image     {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test1.jpg'))}
  end
end
