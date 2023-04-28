FactoryBot.define do
  factory :comment do
    content {'comment1'}
  end

  factory :second_comment,class: Comment do
    content {'comment2'}
  end
end
    