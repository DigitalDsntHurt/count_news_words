class ScrapeSessionsController < ApplicationController
  before_action :set_scrape_session, only: [:show, :edit, :update, :destroy]

  # GET /scrape_sessions
  # GET /scrape_sessions.json
  def index
    @scrape_sessions = ScrapeSession.all
  end

  # GET /scrape_sessions/1
  # GET /scrape_sessions/1.json
  def show
  end

  # GET /scrape_sessions/new
  def new
    @scrape_session = ScrapeSession.new
  end

  # GET /scrape_sessions/1/edit
  def edit
  end

  # POST /scrape_sessions
  # POST /scrape_sessions.json
  def create
    @scrape_session = ScrapeSession.new(scrape_session_params)

    respond_to do |format|
      if @scrape_session.save
        format.html { redirect_to @scrape_session, notice: 'Scrape session was successfully created.' }
        format.json { render :show, status: :created, location: @scrape_session }
      else
        format.html { render :new }
        format.json { render json: @scrape_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scrape_sessions/1
  # PATCH/PUT /scrape_sessions/1.json
  def update
    respond_to do |format|
      if @scrape_session.update(scrape_session_params)
        format.html { redirect_to @scrape_session, notice: 'Scrape session was successfully updated.' }
        format.json { render :show, status: :ok, location: @scrape_session }
      else
        format.html { render :edit }
        format.json { render json: @scrape_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scrape_sessions/1
  # DELETE /scrape_sessions/1.json
  def destroy
    @scrape_session.destroy
    respond_to do |format|
      format.html { redirect_to scrape_sessions_url, notice: 'Scrape session was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scrape_session
      @scrape_session = ScrapeSession.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scrape_session_params
      params.require(:scrape_session).permit(:scrape_date, :scrape_time)
    end
end
