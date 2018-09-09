class Api::V1::TwerpsController < ApplicationController
  before_action :verify_authentication
  before_action :set_user,  only: [:index, :create, :show, :update, :destroy]
  before_action :set_twerp, only: [:show, :update, :destroy]

  
  def index
    @twerps = @user.twerps
    render json: @user.twerps
  end

 
  def show
    render json: @twerp
  end

  
  def create
    @twerp = Twerp.create(
        twerp: params["twerp"],
        numfavs: params["numfavs"],
        user_id: @user.id
        )
      render json: @twerp
  end

  def update
    if @twerp.update(twerp_params)
      render json: @twerp
    else
      render json: @twerp.errors, status: :unprocessable_entity
    end
  end
  
  def destroy
    @twerp.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params["user_id"])
    end

    def set_twerp
      @twerp= Twerp.find(params["id"])
    end

    # Only allow a trusted parameter "white list" through.
    def twerp_params
      params.require(:twerp).permit(:twerp, :numfavs)
    end

end
