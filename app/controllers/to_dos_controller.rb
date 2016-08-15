class ToDosController < ApplicationController
  before_action :set_to_do, only: [:show, :edit, :update, :destroy]

  # GET /to_dos
  # GET /to_dos.json
  def index
    @to_dos = current_user.to_dos
    if params[:tag]
      @tag = params[:tag]
      @to_dos = @to_dos.tagged_with(params[:tag])
    elsif params[:note_id]
      @to_dos = @to_dos.where(note_id: params[:note_id].to_i)
    end
    ## TODO: Manage display_all param: all todos: only open, todos of a note: all
    if not(params[:display_all])
      @to_dos = @to_dos.where(displayed: "true").order(deadline: :asc)
    end
    @to_dos = @to_dos.order(deadline: :asc).page(params[:page]).per(10)
  end

  # GET /to_dos/1
  # GET /to_dos/1.json
  def show
  end

  # GET /to_dos/new
  def new
    @to_do = ToDo.new
    if params[:note_id]
      @note = Note.find(params[:note_id])
      @to_do.note = @note
      @to_do.tag_list = @note.tag_list
    end
    @to_do.displayed = true
  end

  # GET /to_dos/1/edit
  def edit
  end

  # POST /to_dos
  # POST /to_dos.json
  def create
    @to_do = ToDo.new(to_do_params)
    @to_do.user = current_user
    if params[:note_id]
      @note = Note.find(params[:note_id])
      @to_do.note = @note
    end

    respond_to do |format|
      if @to_do.save
        format.html { redirect_to @to_do, notice: 'To do was successfully created.' }
        format.json { render :show, status: :created, location: @to_do }
      else
        format.html { render :new }
        format.json { render json: @to_do.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /to_dos/1
  # PATCH/PUT /to_dos/1.json
  def update
    respond_to do |format|
      if @to_do.update(to_do_params)
        format.html { redirect_to @to_do, notice: 'To do was successfully updated.' }
        format.json { render :show, status: :ok, location: @to_do }
      else
        format.html { render :edit }
        format.json { render json: @to_do.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /to_dos/1
  # DELETE /to_dos/1.json
  def destroy
    @to_do.destroy
    respond_to do |format|
      format.html { redirect_to to_dos_url, notice: 'To do was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_to_do
      @to_do = ToDo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def to_do_params
      params.require(:to_do).permit(:title, :text, :status, :deadline, :displayed, :achieved, :user, :note, :tag_list)
    end
end
