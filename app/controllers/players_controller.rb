class PlayersController < ApplicationController

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      flash[:notice] = 'Player created successfully.'
      redirect_to :root
    else
      flash[:alert] = 'There are some problems with the player you are creating.  Please check the form for errors.'
      render 'new'
    end
  end

  private

  def player_params
    params.require(:player).permit(:name)
  end
end
