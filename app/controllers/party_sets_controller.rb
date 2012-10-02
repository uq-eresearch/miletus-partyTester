require 'partyTester/config'

class PartySetsController < ApplicationController

  # GET /party_sets
  # GET /party_sets.json
  def index
    @party_sets = PartySet.order("name, created_at")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @party_sets }
    end
  end

  # GET /party_sets/1
  # GET /party_sets/1.json
  def show
    @party_set = PartySet.find(params[:id])
    @set_records = PartyRecord.where("partySet_id = ?", params[:id]).order("created_at")

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @party_set }
    end
  end

  # GET /party_sets/new
  # GET /party_sets/new.json
  def new
    @party_set = PartySet.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @party_set }
    end
  end

  # GET /party_sets/1/edit
  def edit
    @party_set = PartySet.find(params[:id])
  end

  # POST /party_sets
  # POST /party_sets.json
  def create
    if params[:party_set][:name].blank?
      params[:party_set][:name] = PartyTester::Config::DEFAULT_SET_NAME
    end
    @party_set = PartySet.new(params[:party_set])

    respond_to do |format|
      if @party_set.save

        # Generate the prefix
        @party_set.prefix = PartyTester::Config::PREFIX_STR + @party_set.id.to_s
        @party_set.save
        
        format.html { redirect_to @party_set, notice: 'Party set was successfully created.' }
        format.json { render json: @party_set, status: :created, location: @party_set }
      else
        format.html { render action: "new" }
        format.json { render json: @party_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /party_sets/1
  # PUT /party_sets/1.json
  def update
    @party_set = PartySet.find(params[:id])

    respond_to do |format|
      if @party_set.update_attributes(params[:party_set])
        format.html { redirect_to @party_set, notice: 'Party set was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @party_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /party_sets/1
  # DELETE /party_sets/1.json
  def destroy
    @party_set = PartySet.find(params[:id])
    @party_set.destroy

    respond_to do |format|
      format.html { redirect_to party_sets_url }
      format.json { head :no_content }
    end
  end
end
