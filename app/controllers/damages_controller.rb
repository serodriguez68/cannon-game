class DamagesController < ApplicationController
  def new
    @game = Game.find(params[:game_id])
    @damage = @game.damages.build
    unless @game.winner.blank?
      flash[:notice] = "Match won by #{@game.winner.name}! Congratulations!"
      # check sergio: change redirect to score board
      redirect_to games_path and return
    end
  end

  def create
    @game = Game.find(params[:game_id])
    @damage = @game.damages.build(damage_params)
    @damage.damage_amount = Damage.random_damage
    if @damage.save
      @game.reload

      if @game.winner.blank?
        flash[:notice] = "Fired a #{@damage.damage_amount} hit cannon ball!"
        redirect_to new_game_damage_path(@game)
      else
        @game.update(winner_player: @game.winner, winner_remaining_health: @game.calculate_winner_remaining_health)
        flash[:notice] = "Fired a #{@damage.damage_amount} hit cannon ball and won! Congratulations #{@game.winner.name}!"
        redirect_to games_path
      end
    else
      flash[:alert] = "There is a bug in the code."
    end
  end

  private
  def damage_params
    params.require(:damage).permit(:player_id)
  end
end
