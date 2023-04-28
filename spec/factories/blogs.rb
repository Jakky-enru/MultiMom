FactoryBot.define do
  factory :blog do
    content {'blog1'}
  end

  factory :second_blog,class: Blog do
    content {'blog2'}
  end
end
