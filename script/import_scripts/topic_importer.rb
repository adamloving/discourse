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

    if category[:name] == 'Is it gluten free?'
      topic[:text] = "Is #{topic[:text].downcase} gluten free?"
    end

    t = Topic.find_by(title: topic[:text]) 
    if t.nil?
      puts "New topic: #{topic[:text]}"
      p = PostCreator.create(
        user, 
        raw: 'autocreated', 
        title: topic[:text], 
        skip_validations: true, 
        category: c.id
      )
    else
      puts "Topic '#{topic[:text]}' exists"
      p = t.posts.first
    end

    p.raw = "Here's what we've got so far, please reply with yours.\n\n"

    if topic[:description]
      p.raw << "> #{topic[:description]}\n\n"
      p.raw << "Source: "
    end  

    p.raw << "[#{topic[:text]}](http://www.glutenfreefancy.com/#{topic[:href]})"    
    p.save 

    TopicLink.extract_from(p) # enable link in post

    puts "Saved #{p.raw}"
  end
end