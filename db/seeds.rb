require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Question.create([
{ 
  question: "Whats your fitness goal over the next few months?", 
  options: ['Get leaner', 'Get stronger', 'Get active again', 'Reduce pain or injury',            'Improve cardio or speed', 'Improve sports performance'],
  user_type: 'Client'
}, 
{  
  question: 'How many days per week do you currently workout?',
  options: ['0-1 days', '2-3 days', '3-5 days', '5+ days'],
  user_type: 'Client'
},
{ 
  question: 'How many days per week can you train?',
  options: ['2-3 days', '3-4 days', '4-5 days', '5-6 days'],
  user_type: 'Client'
}, 
{  
  question: 'If you have any diagnosed health problems please, list the condition(s).?', user_type: 'Client'
},
{
  question: 'If you are on any medications, please list them. ?', 
  user_type: 'Client'
},
{
  question: 'If you have any injuries, please list them. ?',
  user_type: 'Client'
},
{
  question: 'Preferred sex of coach',
  options: ['Male', 'Female', 'either'],
  user_type: 'Client'
},
{
  question: 'Which disciplines and skills you are qualified to deliver?',
  options: ['Personal training', 'Yoga', 'Pilates', 'Barre', 'Ballet', 'Dance','Boxing','Martial Arts', 'Kickboxing', 'Streching', 'Running', 'Meditation'],
  user_type: 'Trainer'
},
{
  question: 'How many years of experience do you have in your discipline?',
  options: ['0-1 years', '1-2 years', '2-3 years', '3-5 years', '5+ years'],
  user_type: 'Trainer'
}
])

[
  { name: 'Taster session', number_of_sessions: 0.50 },
  { name: '1 session', number_of_sessions: 10.00 },
  { name: '5 sessions', number_of_sessions: 5.00 },
  { name: '10 sessions', number_of_sessions: 10.0 },
  { name: '15 sessions', number_of_sessions: 15.0 }
].each do |attributes|
  Option.create(attributes)
end

# [
# '/Users/shabankarumba/Downloads/royalty-free-avatar-clipart-illustration-1166289.jpg','/Users/shabankarumba/Downloads/royalty-free-avatar-clipart-illustration-1166291.jpg', '/Users/shabankarumba/Downloads/ff1a14d1c79bdeb51896cc654fe5327f--create-your-own-avatar-avatar-maker.jpg',
# '/Users/shabankarumba/Downloads/4641831.png',
# '/Users/shabankarumba/Downloads/Benjohnsone54fbec7a167c5.png',
# '/Users/shabankarumba/Downloads/147140.png',
# '/Users/shabankarumba/Downloads/FullSizeRender5-1.jpg',
# '/Users/shabankarumba/Downloads/business-caricature-drawing-colored-pencils-style-funny-example.jpg',
# '/Users/shabankarumba/Downloads/danavatar.png'
# ].each do |file|
#   avatar = File.open(file)
#  user = User.create(username: Faker::Internet.username, email: Faker::Internet.safe_email, sex: Faker::Gender.binary_type, type: 'Trainer', password: 'FakeItTillIMakeit123!')
#
#  user.avatar.attach(io: avatar, filename: File.basename(file))
#  user.save
#
#  questions = Question.where(user_type: 'Trainer')
#    questions.each do |question|
#      if !question.options.empty?
#        Answer.create(user: user, question: question, answer: question.options.first).save!
#      else
#        Answer.create(user: user, question: question, answer: Faker::Lorem.paragraph).save!
#      end
#     end
#
#   Profile.create(short_description: Faker::Lorem.characters(number: 120), long_description: Faker::Lorem.characters(number: 240), qualifications: ['Some course'], user: user).save!
# end
#
#
