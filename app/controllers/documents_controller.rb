class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :update_files, :destroy]

  # GET /documents
  # GET /documents.json
  def index
    if params[:q].nil? or params[:q]==""
      @documents = current_user.documents
    else
      @documents = current_user.documents.search(params[:q]).records
    end
    if(params[:note_id])
      @documents = @documents.where(note_id: params[:note_id])
    end
    @documents = @documents.order(updated_at: :desc).page(params[:page]).per(5)
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
  end

  # GET /documents/new
  def new
    @document = Document.new
    if params[:note_id]
      @note = Note.find(params[:note_id])
      @document.note = @note
      @document.tag_list = @note.tag_list
    end
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)
    @document.user = current_user

    if params[:note_id]
      @note = Note.find(params[:note_id])
      @document.note = @note
    end

    respond_to do |format|
      if @document.save
        @document.__elasticsearch__.index_document
        format.html { redirect_to @document, notice: 'Document was successfully created.' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        if params[:update_files]
          begin
            @document.file.cache_stored_file! 
            @document.file.retrieve_from_cache!(@document.file.cache_name) 
            @document.file.recreate_versions! 
            @document.save! 
          rescue => e
            format.html { render :edit }
            format.json { render json: @document.errors, status: :unprocessable_entity }
          end
        end
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_files
    respond_to do |format|
      begin
        @document.file.cache_stored_file! 
        @document.file.retrieve_from_cache!(@document.file.cache_name) 
        @document.file.recreate_versions! 
        @document.save! 
        format.html { redirect_to @document, notice: 'The files were successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      rescue => e
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:title, :author, :summary, :user_id, :note_id, :file, :remote_file_url, :tag_list, :main_link, :use_main_link)
    end
end
