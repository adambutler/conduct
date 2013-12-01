# Create two users

first_user = User.create({
  email: "adam@lab.io",
  password: "hammertime"
})

second_user = User.create({
  email: "adam@littlebigmedia.co.uk",
  password: "hammertime"
})

# First Topic

topic = Topic.create({
  title: "What film shall I watch this weekend",
  user_id: first_user.id,
  locked: false
})

ideas = ["Toy Story", "Up", "Monsters Inc", "Brave", "Finding Nemo"]

ideas.each do |idea|
  Idea.create({
    title: idea,
    user_id: first_user.id,
    topic_id: topic.secret
  })
end

ideas_for_votes = Idea.all.shuffle.take(3)

ideas_for_votes.each do |idea|
  Vote.create({
    idea_id: idea.id,
    user_id: first_user.id
  })
end

ideas_for_votes = Idea.all.shuffle.take(3)

ideas_for_votes.each do |idea|
  Vote.create({
    idea_id: idea.id,
    user_id: second_user.id
  })
end

# Second Topic

topic = Topic.create({
  title: "Subject for next weeks meetup",
  description: "Suggest toppics for SouthvilleJS meetup, we'll try and find speakers for the top three subjects.",
  user_id: first_user.id,
  locked: true
})

ideas = [
  {
    title: "AngularJS",
    description: "AngularJS is what HTML would have been, had it been designed for building web-apps. Declarative templates with data-binding, MVW, MVVM, MVC."
  },
  {
    title: "Backbone",
    description: "Backbone.js gives structure to web applications by providing models with key-value binding and custom events, collections with a rich API of enumerable."
  },
  {
    title: "Meteor"
  },
]

ideas.each do |idea|
  Idea.create({
    title: idea[:title],
    description: idea[:description],
    user_id: first_user.id,
    topic_id: topic.secret
  })
end

ideas_for_votes = Idea.all.shuffle.take(1)

ideas_for_votes.each do |idea|
  Vote.create({
    idea_id: idea.id,
    user_id: first_user.id
  })
end

ideas_for_votes = Idea.all.shuffle.take(1)

ideas_for_votes.each do |idea|
  Vote.create({
    idea_id: idea.id,
    user_id: second_user.id
  })
end
