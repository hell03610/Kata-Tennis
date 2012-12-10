class Tennis
	attr_accessor :serverPlayer, :receiverPlayer
	MINIMUM_POINTS_TO_WIN = 3
	DEUCE_POINTS = 3
	DIFF_OF_POINTS_TO_WIN = 2
	
	def initialize 
		@serverPlayer = Player.new
		@receiverPlayer = Player.new
	end

	def pointToServer
		return if gameEnded?
		return recoverSenderFromAdvantage if isAdvantage?(@receiverPlayer, @serverPlayer)
		@serverPlayer.points += 1
	end

	def pointToReceiver
		return if gameEnded? 
		return recoverReceiverFromAdvantage if isAdvantage?(@serverPlayer, @receiverPlayer)
		@receiverPlayer.points += 1
	end

	def recoverReceiverFromAdvantage
		@serverPlayer.points -= 1
	end

	def recoverSenderFromAdvantage
		@receiverPlayer.points -= 1
	end

	def gameEnded?
		isServerPlayerWinner? || isReceiverPlayerWinner?			 
	end

	def isServerPlayerWinner?
		isNormalWinner?(@serverPlayer, @receiverPlayer) || isAdvantageWinner?(@serverPlayer, @receiverPlayer)
	end

	def isReceiverPlayerWinner?
		isNormalWinner?( @receiverPlayer, @serverPlayer) || isAdvantageWinner?( @receiverPlayer, @serverPlayer)
	end


	def serverScore
		toScore(@serverPlayer, @receiverPlayer)
	end

	def receiverScore
		toScore(@receiverPlayer, @serverPlayer)
	end
	
private

	def isDeuce? (player, adversary)
		return player.points == adversary.points && player.points == DEUCE_POINTS
	end

	def isAdvantage?(player, adversary)
		return player.points == adversary.points + 1 && player.points == DEUCE_POINTS + 1
	end

	def isAdvantageWinner?(player, adversary)
		return player.points == (adversary.points + DIFF_OF_POINTS_TO_WIN) && player.points == (DEUCE_POINTS + DIFF_OF_POINTS_TO_WIN)
	end

	def isNormalWinner?(player, adversary)
		return player.points == MINIMUM_POINTS_TO_WIN && (player.points - adversary.points >= DIFF_OF_POINTS_TO_WIN)
	end
	
	def toScore(player, adversary)
		return 'deuce' if isDeuce?(player, adversary) 
		return 'advantage' if isAdvantage?(player, adversary)
		return ['love','15','30','40'][player.points]
	end
	
end



class Player
	attr_accessor :points

	def initialize
		@points = 0
	end

end