# frozen_string_literal: true

desc 'Fill the database tables with some sample data'
task sample_data: :environment do
  starting = Time.now

  Comment.delete_all
  Conversation.delete_all
  Rating.delete_all
  User.delete_all

  people = Array.new(10) do
    {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name
    }
  end

  people << { first_name: 'Alice', last_name: 'Smith' }
  people << { first_name: 'Bob', last_name: 'Smith' }
  people << { first_name: 'Carol', last_name: 'Smith' }
  people << { first_name: 'Doug', last_name: 'Smith' }

  people.each do |person|
    username = person.fetch(:first_name).downcase

    user = User.create(
      email: "#{username}@example.com",
      password: 'password',
      username: username.downcase,
      name: "#{person[:first_name]} #{person[:last_name]}",
      private: [true, false].sample
    )

    p user.errors.full_messages
  end

  users = User.all

  users.each do |first_user|
    users.each do |second_user|
      if rand < 0.75
        first_user_follow_request = first_user.sent_follow_requests.create(
          recipient: second_user,
          status: FollowRequest.statuses.values.sample
        )

        p first_user_follow_request.errors.full_messages
      end

      next unless rand < 0.75

      second_user_follow_request = second_user.sent_follow_requests.create(
        recipient: first_user,
        status: FollowRequest.statuses.values.sample
      )

      p second_user_follow_request.errors.full_messages
    end
  end

  users.each do |user|
    rand(15).times do
      photo = user.own_photos.create(
        caption: Faker::Quote.jack_handey,
        image: "/#{rand(1..10)}.jpeg"
      )

      p photo.errors.full_messages

      user.followers.each do |follower|
        photo.fans << follower if rand < 0.5

        next unless rand < 0.25

        comment = photo.comments.create(
          body: Faker::Quote.jack_handey,
          author: follower
        )

        p comment.errors.full_messages
      end
    end
  end

  ending = Time.now
  p "It took #{(ending - starting).to_i} seconds to create sample data."
  p "There are now #{User.count} users."
  p "There are now #{FollowRequest.count} follow requests."
  p "There are now #{Photo.count} photos."
  p "There are now #{Like.count} likes."
  p "There are now #{Comment.count} comments."
end
