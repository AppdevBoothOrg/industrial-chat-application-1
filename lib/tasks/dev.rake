# frozen_string_literal: true

desc 'Fill the database tables with some sample data'
task sample_data: :environment do
  starting = Time.now

  Comment.delete_all
  Conversation.delete_all
  Rating.delete_all
  User.delete_all

  people = Array.new(20) do
    {
      username_generated_from_name: Faker::Name.unique.first_name,
    }
  end

  people << { username_generated_from_name: 'Alice' }
  people << { username_generated_from_name: 'Bob' }
  people << { username_generated_from_name: 'Carol' }
  people << { username_generated_from_name: 'Doug' }

  people.each do |person|
    username = person.fetch(:username_generated_from_name).downcase

    user = User.create(
      email: "#{username}@example.com",
      password: 'password',
      username: username,
      customer: [true, true, false].sample
    )

    p user.errors.full_messages
  end

  users = User.all

  users.where({ :customer => true }).each do |complaining_customer|
    users.where({ :customer => false }).each do |customer_representative|
      if rand < 0.3
        complaining_customer_grade_submission = complaining_customer.gradee_ratings.create(
          gradee: customer_representative,
          grader: complaining_customer,
          grade: rand(5)
        )

        customer_representative_grade_submission = customer_representative.gradee_ratings.create(
          gradee: complaining_customer,
          grader: customer_representative,
          grade: rand(5)
        )

        pick_a_status = [:open, :closed, :urgent].sample

        conversation = Conversation.create(
          company_representative: customer_representative,
          customer: complaining_customer,
          status: pick_a_status
        )
        
        p conversation.errors.full_messages

        comments_per_conversation = rand(10)+1

        comments_per_conversation.times do
          comment = conversation.comments.create(
            body: Faker::Quote.jack_handey,
            author: [customer_representative, complaining_customer, complaining_customer].sample
          )
        
        p comment.errors.full_messages

      end

      end

    end
  end


  ending = Time.now
  p "It took #{(ending - starting).to_i} seconds to create sample data."
  p "There are now #{User.count} users, of which #{User.where({ :customer => true }).count} are customers and #{User.where({ :customer => false }).count} are company representatives"
  p "There are now #{Conversation.count} conversations in total."
  p "There are now #{Comment.count} comments."
  p "There are now #{Rating.count} ratings, double the about of conversations (i.e. we assume everyone always rates)."

end
