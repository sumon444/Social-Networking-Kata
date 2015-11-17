require 'spec_helper'
require 'snk'

RSpec.describe Snk do
  before(:each) do
    @snk = Snk.new
  end

  describe "#publish_message" do
    it "publishes message on timeline" do
      user = "Alice"
      message = "I love the weather today"

      @snk.publish_message(user, message)
      post = @snk.posts.select{|p| p[:user] == user && p[:message] == message}
      expect(post).not_to be_nil
    end
  end

  describe "#subscribe_to_timeline" do
    it "subscribes user" do
      user1 = "Charlie"
      user2 = "Alice"

      @snk.subscribe_to_timeline(user1, user2)
      follow = @snk.follows.select{|f| f == "#{user1},#{user2}}"}
      expect(follow).not_to be_nil
    end
  end

  describe "#view_timeline" do
    it "shows only message of the user" do
      user1 = "Charlie"
      user2 = "Alice"
      message1 = "I love the weather today"
      message2 = "Damn! We lost!"

      @snk.publish_message(user1, message1)
      @snk.publish_message(user2, message2)

      expect { @snk.view_timeline(user1) }.to output("#{user1} > #{message1} (just now)").to_stdout
    end
  end

  describe "#view_wall" do
    it "shows only message of the user and following user" do
      user1 = "Charlie"
      user2 = "Alice"
      user3 = "Bob"
      message1 = "I love the weather today"
      message2 = "Damn! We lost!"
      message3 = "Good game though."

      @snk.publish_message(user1, message1)
      @snk.publish_message(user2, message2)
      @snk.publish_message(user3, message3)

      @snk.subscribe_to_timeline(user1, user2)

      expect { @snk.view_wall(user1) }.to output("#{user1} - #{message1} (just now)#{user2} - #{message2} (just now)").to_stdout
    end
  end
end
