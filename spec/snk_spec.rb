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
end
