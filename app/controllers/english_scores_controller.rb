class EnglishScoresController < ApplicationController
  before_action :set_english_score, only: [:show, :edit, :update, :destroy]

  # GET /english_scores
  # GET /english_scores.json
  def index
    @english_scores = EnglishScore.all
  end

  # GET /english_scores/1
  # GET /english_scores/1.json
  def show
  end

  # GET /english_scores/new
  def new
    @english_score = EnglishScore.new
  end

  # GET /english_scores/1/edit
  def edit
  end

  # POST /english_scores
  # POST /english_scores.json
  def create
    @english_score = EnglishScore.new(english_score_params.merge(passed))

    respond_to do |format|
      if @english_score.save
        format.html { redirect_to @english_score, notice: 'English score was successfully created.' }
        format.json { render :show, status: :created, location: @english_score }
      else
        format.html { render :new }
        format.json { render json: @english_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /english_scores/1
  # PATCH/PUT /english_scores/1.json
  def update
    respond_to do |format|
      if @english_score.update(english_score_params.merge(passed))
        format.html { redirect_to @english_score, notice: 'English score was successfully updated.' }
        format.json { render :show, status: :ok, location: @english_score }
      else
        format.html { render :edit }
        format.json { render json: @english_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /english_scores/1
  # DELETE /english_scores/1.json
  def destroy
    @english_score.destroy
    respond_to do |format|
      format.html { redirect_to english_scores_url, notice: 'English score was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_english_score
      @english_score = EnglishScore.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def english_score_params
      params.require(:english_score).permit(:name, :reading, :writing, :speaking, :listening)
    end

    def passed
      # The following line raises LocalJumpError (no block given)
      # because each_value method requires block, does not
      # returns Enumerator object when block is not given.
      # { passed: english_score_params.each_value.map(&:to_i).sum / 4.0 >= 70.0 }

      total = 0
      english_score_params.each_value do |score|
        total += score.to_i
      end
      { passed: total / 4.0 >= 70.0 }
    end
end
