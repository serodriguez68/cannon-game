class GamesController < ApplicationController

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      flash[:notice] = 'Game created. Start playing!'
      redirect_to root_path
    else
      flash[:alert] = 'There is a problem creating the game. Check the error messages'
      render 'new'
    end
  end

  private
  def game_params
    params.require(:game).permit(:player_1_id, :player_2_id)
  end
end
