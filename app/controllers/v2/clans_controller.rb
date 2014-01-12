class V2::ClansController < ApplicationController

  # GET /clans/
  # Список кланов на сервере.
  def index
    @clans = Clan.select(:id, :clan, :exp, :leader, :members).limit(100).order("exp DESC")

    if params.has_key? :offset
      @clans = @clans.offset(params[:offset])
    end

    @count = Clan.count()

    if @clans.empty?
      render :json => {
          :error => "No clans found.",
          :offset => params[:offset],
          :count => @count,
      }, :status => 422
    else

      render :json => {
          :clans => @clans,
          :count => @count,
          :offset => params[:offset]
      }
    end
  end

  # GET /clan/:id
  # Информация о клане.
  def info

    if !params.has_key? :id
      render json: {error: "Please provide clan id."}, :status => 422
    else
      @clan = Clan.where("id = ?", params[:id])

      if !@clan.empty?
        render json: @clan
      else
        render :json => {
            :error => "Clan with provided id not found.",
            :id => params[:id]
        }, :status => 422
      end
    end
  end

end