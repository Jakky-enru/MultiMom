6.times do |n|
  User.create!(
    email: "parent#{n + 1}@gmail.com",
    name: "親#{n + 1}",
    password: "password#{n + 1}",
    role: :parent
  )
end

6.times do |n|
  User.create!(
    email: "child#{n + 1}@gmail.com",
    name: "子#{n + 1}",
    password: "password#{n + 1}",
    role: :child
  )
end

6.times do |n|
  User.create!(
    email: "admin#{n + 1}@gmail.com",
    name: "管理者#{n + 1}",
    password: "password#{n + 1}",
    role: :admin
  )
end

6.times do |n|
  Blog.create!(
    content: "anxiety#{n + 1}",
    user_id: n + 1
  )
end

6.times do |n|
  comment = Comment.create!(
    content: "comment#{n + 1}",
    user_id: n + 1,
    blog_id: n + 1
  )

  user = User.find(n + 1)

  Favorite.create!(
      user_id: user.id,
      comment_id: comment.id
    )
end