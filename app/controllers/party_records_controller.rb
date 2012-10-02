
require 'uuid'

class PartyRecordsController < ApplicationController

  KEY_STR = ':r'
  TESTIDENT_STR = ':'

  DEFAULT_FORENAME = 'John'
  DEFAULT_SURNAME = 'Smith'

  # GET /party_records
  # GET /party_records.json
  def index
    @party_records = PartyRecord.order("partySet_id, testident, surname, forename")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @party_records }
    end
  end

  # GET /party_records/1
  # GET /party_records/1.json
  def show
    @party_record = PartyRecord.find(params[:id])
    @set = PartySet.find(@party_record.partySet_id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @party_record }
    end
  end

  # GET /party_records/new
  # GET /party_records/new.json
  def new
    @party_record = PartyRecord.new

    if params[:set].nil? || params[:set].blank?
      params[:set] = "1"
      # TODO: fix tests so this can be put back
      #raise "Internal error: parameter 'set' not defined"
    end
    @set = PartySet.find(params[:set])
    @party_record.partySet_id = params[:set]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @party_record }
    end
  end

  # GET /party_records/1/edit
  def edit
    @party_record = PartyRecord.find(params[:id])
    @set = PartySet.find(@party_record.partySet_id)
  end

  # POST /party_records
  # POST /party_records.json
  def create

    # Get the test set this party record belongs to

    psid = params[:party_record][:partySet_id]
    if psid.nil?
      raise "Internal error: test set not specified"
    end
    @set = PartySet.find(psid)
    if @set.nil?
      raise "Internal error: test set not found for create"
    end

    # Generate the testident and set it

    person = params[:party_record][:testident]
    if person.blank?
      person = @set.prefix + TESTIDENT_STR + UUID.new.generate(:compact)
    end
    params[:party_record][:testident] = person

    # Default forename

    if params[:party_record][:forename].blank?
      params[:party_record][:forename] = DEFAULT_FORENAME
    end

    # Set the surname so that it is globally unique to the test set

    surname = params[:party_record][:surname]
    if surname.blank?
      surname = DEFAULT_SURNAME
    end
    params[:party_record][:surname] =
      surname + '-' + @set.prefix.gsub(/\:/, '-')

    # Create party record

    @party_record = PartyRecord.new(params[:party_record])

    respond_to do |format|
      if @party_record.save

        # Generate the RIF-CS key using the set's prefix and this record's id
        @party_record.key = @set.prefix + KEY_STR + @party_record.id.to_s
        @party_record.save

        format.html { redirect_to @party_record, notice: 'Party record was successfully created.' }
        format.json { render json: @party_record, status: :created, location: @party_record }
      else
        format.html { render action: "new" }
        format.json { render json: @party_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /party_records/1
  # PUT /party_records/1.json
  def update
    @party_record = PartyRecord.find(params[:id])

    respond_to do |format|
      if @party_record.update_attributes(params[:party_record])
        format.html { redirect_to @party_record, notice: 'Party record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @party_record.errors, status: :unprocessable_entity }
      end
    end
  end

# Delete not supported (yet?) because this will confuse the testing
# since the ARDC Party Infrastructure does not delete party records
# it has harvested and have assigned to identity container records.
#
#  # DELETE /party_records/1
#  # DELETE /party_records/1.json
#  def destroy
#    @party_record = PartyRecord.find(params[:id])
#    @party_record.destroy
#
#    respond_to do |format|
#      format.html { redirect_to party_records_url }
#      format.json { head :no_content }
#    end
#  end
end
