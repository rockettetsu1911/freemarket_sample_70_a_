  
FactoryBot.define do

  factory :picture do
    item
  end
  
  factory :picture_0, parent: :picture do |picture|
    image     {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test1.jpg'))}
  end

  factory :picture_1, parent: :picture do |picture|
    image     {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test2.jpg'))}
  end

  factory :picture_2, parent: :picture do |picture|
    image     {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test3.png'))}
  end
  
  factory :picture_3, parent: :picture do |picture|
    image     {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test4.png'))}
  end

  factory :picture_4, parent: :picture do |picture|
    image     {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test5.png'))}
  end

  factory :picture_5, parent: :picture do |picture|
    image     {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test6.png'))}
  end

  factory :picture_6, parent: :picture do |picture|
    image     {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test7.png'))}
  end

  factory :picture_7, parent: :picture do |picture|
    image     {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test8.jpg'))}
  end

  factory :picture_8, parent: :picture do |picture|
    image     {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test9.png'))}
  end

  factory :picture_9, parent: :picture do |picture|
    image     {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test10.png'))}
  end
  
  factory :picture_10, parent: :picture do |picture|
    image     {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test1.jpg'))}
  end

end