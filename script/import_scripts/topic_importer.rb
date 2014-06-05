require File.expand_path(File.dirname(__FILE__) + "../../../config/environment")
# require 'json'

user = User.find_by(id: 1)

category_data = JSON.parse(File.read('data/categories.json'), symbolize_names: true)
category_data = category_data[:categories]

for category in category_data
  c = Category.find_by(name: category[:name])
  unless c
    puts "Category #{category[:name]} NOT FOUND"
    next
  end
  
  puts "Category [#{c.id}] #{c.name} found"

  for topic in category[:topics]

    puts "topic: #{topic}"

    unless Topic.find_by(title: topic).nil?
      puts "Topic '#{topic}' exists"
      next
    end

    PostCreator.create(
      user, 
      raw: 'autocreated', 
      title: topic, 
      skip_validations: true, 
      category: c.id
    )
  end
end