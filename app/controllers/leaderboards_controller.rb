class LeaderboardsController < ApplicationController

	def leader

		@users = User.all
		
	end
end