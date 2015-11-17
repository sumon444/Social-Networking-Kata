require 'time_ago_in_words'

class Snk
  attr_accessor :command, :posts, :follows
  def initialize
    @command = ''
    @posts = []
    @follows = []
  end

  def start
    prompt
    until @command.eql? 'exit'
      @command = gets.chomp
      filter_command
      prompt
    end
    puts 'Bye!'
  end

  def filter_command
    if @command.include? '->'
      user, message = @command.split(' -> ')
      publish_message(user, message)
    elsif @command.include? 'follows'
      follower, following = @command.split(' follows ')
      subscribe_to_timeline(follower, following)
    elsif @command.include? 'wall'
      user = @command.split(' wall')
      view_wall(user[0])
    else
      view_timeline(@command)
    end
  end

  def publish_message(user, message)
    msg_hash = { user: user, message: message, time: Time.now }
    @posts << msg_hash
  end

  def subscribe_to_timeline(follower, following)
    @follows << "#{follower},#{following}"
  end

  def view_wall(user)
    @posts.reverse.each do |msg|
      print "#{msg[:user]} - #{msg[:message]} (#{msg[:time].ago_in_words})" if user == msg[:user]
    end

    @posts.reverse.each do |msg|
      print "#{msg[:user]} - #{msg[:message]} (#{msg[:time].ago_in_words})" if @follows.include?("#{user},#{msg[:user]}")
    end
  end

  def view_timeline(user)
    print user
    @posts.reverse.each do |msg|
      print " > #{msg[:message]} (#{msg[:time].ago_in_words})" if user == msg[:user]
    end
  end

  def prompt
    print '> '
  end
end

if __FILE__ == $0
  Snk.new.start
end
