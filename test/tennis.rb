# encoding: utf-8
require 'rspec'

require_relative '../tennis'


describe 'Tennis' do

	before(:each) do
    	@tennis = Tennis.new
    end
	
	it 'has two players' do
		@tennis.serverPlayer.should_not eql nil
		@tennis.receiverPlayer.should_not eql nil
	end

	it 'knows the score of the players' do
		@tennis.serverScore.should eql 'love'
		@tennis.receiverScore.should eql 'love'
	end

	it 'can add points to server player' do
		@tennis.pointToServer
		@tennis.serverScore.should eql '15'
		@tennis.pointToServer
		@tennis.serverScore.should eql '30'
		@tennis.pointToServer
		@tennis.serverScore.should eql '40'
	end

	it 'can add points to receiver player' do
		@tennis.pointToReceiver
		@tennis.receiverScore.should eql '15'
		@tennis.pointToReceiver
		@tennis.receiverScore.should eql '30'
		@tennis.pointToReceiver
		@tennis.receiverScore.should eql '40'
	end

	it 'knows if a game is ended if one of players reaches 40' do
		@tennis.gameEnded?.should be_false
		@tennis.pointToReceiver
		@tennis.pointToReceiver
		@tennis.gameEnded?.should be_false
		@tennis.pointToReceiver
		@tennis.serverScore.should eql 'love'
		@tennis.receiverScore.should eql '40'
		@tennis.gameEnded?.should be_true
	end

	it 'cannot add more than 40 points to a player - simple rules' do
		@tennis.pointToReceiver
		@tennis.pointToReceiver
		@tennis.pointToReceiver
		@tennis.pointToReceiver
		@tennis.pointToReceiver
		@tennis.receiverScore.should eql '40'		
	end

	it 'is deuce when both players reach 40' do
		@tennis.pointToServer
		@tennis.pointToReceiver
		@tennis.pointToServer
		@tennis.pointToReceiver
		@tennis.pointToServer
		@tennis.pointToReceiver
		@tennis.gameEnded?.should be_false
		@tennis.serverScore.should eql 'deuce'
		@tennis.receiverScore.should eql 'deuce'
	end

	it 'is advantage if one players gets a point after deuce' do
		@tennis.pointToServer
		@tennis.pointToReceiver
		@tennis.pointToServer
		@tennis.pointToReceiver
		@tennis.pointToServer
		@tennis.pointToReceiver
		@tennis.receiverScore.should eql 'deuce'
		@tennis.pointToReceiver
		@tennis.receiverScore.should eql 'advantage'
		@tennis.serverScore.should eql '40'
		
		@tennis.gameEnded?.should be_false
	end	

	it 'ends if one players gets a point after advantage' do
		@tennis.pointToServer
		@tennis.pointToReceiver
		@tennis.pointToServer
		@tennis.pointToReceiver
		@tennis.pointToServer
		@tennis.pointToReceiver
		@tennis.pointToReceiver
		@tennis.receiverScore.should eql 'advantage'
		@tennis.pointToReceiver	
		@tennis.gameEnded?.should be_true
	end	

	it 'can recover from advantage and make deuce again' do
		@tennis.pointToServer
		@tennis.pointToReceiver
		@tennis.pointToServer
		@tennis.pointToReceiver
		@tennis.pointToServer
		@tennis.pointToReceiver
		@tennis.receiverScore.should eql 'deuce'
		@tennis.pointToReceiver
		@tennis.receiverScore.should eql 'advantage'
		@tennis.pointToServer
		@tennis.serverScore.should eql 'deuce'
		@tennis.receiverScore.should eql 'deuce'
	end

	it 'knows if server player is winner' do
		@tennis.isServerPlayerWinner?.should be_false
		@tennis.pointToServer
		@tennis.pointToServer
		@tennis.pointToServer
		@tennis.isServerPlayerWinner?.should be_true
		@tennis.gameEnded?.should be_true
	end

	it 'knows if receiver player is winner' do
		@tennis.isReceiverPlayerWinner?.should be_false
		@tennis.pointToServer
		@tennis.pointToServer
		@tennis.pointToReceiver
		@tennis.pointToReceiver
		@tennis.pointToReceiver
		@tennis.serverScore.should eql '30'
		@tennis.receiverScore.should eql '40'
		@tennis.pointToServer
		@tennis.pointToReceiver
		@tennis.receiverScore.should eql 'advantage'
		@tennis.pointToServer
		@tennis.receiverScore.should eql 'deuce'
		@tennis.pointToReceiver	
		@tennis.pointToReceiver	

		@tennis.isReceiverPlayerWinner?.should be_true
		@tennis.gameEnded?.should be_true
	end

end