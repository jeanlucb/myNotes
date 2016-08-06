# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Note.destroy_all
57.times do |n|
	Note.create!(
		title: Faker::Book.title,
		summary: Faker::Lorem.paragraph(random_sentences_to_add=8),
		text: Faker::Lorem.paragraphs,
		user: User.first,
		tag_list: Faker::Hipster.words(4, true, true),
		created_at: Faker::Time.between(DateTime.now - 100, DateTime.now)
		)
end